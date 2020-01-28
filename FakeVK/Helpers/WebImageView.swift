//
//  WebImageView.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            self.image = nil
            return }
        
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        activityIndicatorView.isHidden = false
        activityIndicatorView.center = center
        
        addSubview(activityIndicatorView)
        bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            activityIndicatorView.isHidden = true
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                    activityIndicatorView.isHidden = true
                    activityIndicatorView.stopAnimating()
                    activityIndicatorView.removeFromSuperview()
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}

