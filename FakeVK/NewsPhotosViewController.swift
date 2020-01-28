//
//  NewsPhotosViewController.swift
//  FakeVK
//
//  Created by Admin on 23.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class NewsPhotosViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 1.1
        scrollView.bounces = true
        scrollView.delegate = self

    }
    
    func set(viewModel: FeedCellViewModel) {
        self.photos = viewModel.photoAttachments
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        postImageView.contentMode = .scaleAspectFill
        return photosCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return photos.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotosCell", for: indexPath) as! NewsCollectionViewCell
           cell.set(imageUrl: photos[indexPath.row].photoUrlString)
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photosCollectionView.frame.width, height: photosCollectionView.frame.height)
       }

}
