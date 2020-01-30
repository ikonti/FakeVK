//
//  PhotosCollectionViewCell.swift
//  FakeVK
//
//  Created by Admin on 29.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PhotosCollectionViewCell"
    
    let myImageView: WebImageView = {
          let imageView = WebImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(myImageView)
        // myImageView constraints
        myImageView.fillSuperview()
        
        let tap = UIPinchGestureRecognizer(target: self, action: #selector(scaleImage))
        myImageView.addGestureRecognizer(tap)
        myImageView.isUserInteractionEnabled = true
        
        myImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
    }
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageUrl: imageUrl)
    }
    
    @objc func imageViewTapped() {
        myImageView.image?.share()
    }
    
    @objc func scaleImage(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .ended || sender.state == .changed {
            let currentScale = sender.view!.frame.size.width / sender.view!.bounds.size.width
            var newScale = currentScale * sender.scale
            
            if newScale < 1 {
                newScale = 1
            }
            
            if newScale > 7 {
                newScale = 7
            }
            
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            
            self.myImageView.transform = transform
            sender.scale = 1
        }
    }
    
}
