//
//  NewsFeedCell.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
    var geo: [FeedCellGeoViewModel] { get }
}

protocol FeedCellGeoViewModel {
    var showmap: String? { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol NewsFeedCellDelegate: class {
    func didElementClick(_ row: Int)
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    weak var delegate: NewsFeedCellDelegate?
    
    let galleryCollectionView = GalleryCollectionView()

    var row: Int?
    
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.addSubview(galleryCollectionView)
        
        galleryCollectionViewTapped()
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(viewModel: FeedCellViewModel, row: Int) {
//        print(viewModel.geo.first.showmap)
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if viewModel.photoAttachments.count >= 1 {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            galleryCollectionView.set(photos: viewModel.photoAttachments)
            self.row = row
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
        
    }
    
    func galleryCollectionViewTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
        galleryCollectionView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    @objc func pressed(sender: UITapGestureRecognizer) {
        guard let row = row else { return }
        delegate?.didElementClick(row)
    }
    
}
