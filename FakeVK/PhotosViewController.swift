//
//  PhotosViewController.swift
//  FakeVK
//
//  Created by Admin on 23.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    let photosCollectionView = PhotosCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(photosCollectionView)
        photosCollectionView.frame = view.frame
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeNumbers), name: NSNotification.Name("change"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hide), name: NSNotification.Name("hide"), object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        photosCollectionView.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.width)
    }
    
    @objc func share() {
        NotificationCenter.default.post(name: NSNotification.Name("shareTapped"), object: nil)
    }
    
    @objc func hide() {
        if navigationController?.navigationBar.isHidden == true {
            navigationController?.navigationBar.isHidden = false
        } else if navigationController?.navigationBar.isHidden == false {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    @objc func changeNumbers() {
        if let number = photosCollectionView.numbers {
            title = "\(number) / \(photosCollectionView.photos.count)"
        }
    }
    
    func set(viewModel: FeedCellViewModel) {
        photosCollectionView.set(photos: viewModel.photoAttachments)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
