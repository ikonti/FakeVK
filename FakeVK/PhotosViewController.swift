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
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        photosCollectionView.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.width)
    }
    
    func set(viewModel: FeedCellViewModel) {
        photosCollectionView.set(photos: viewModel.photoAttachments)
    }
}
