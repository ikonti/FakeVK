//
//  NewsCollectionViewCell.swift
//  FakeVK
//
//  Created by Admin on 29.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    let myImageView: WebImageView = {
          let imageView = WebImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleAspectFill
           return imageView
       }()
    
    override func awakeFromNib() {
        addSubview(myImageView)
        // myImageView constraints
        myImageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageUrl: imageUrl)
    }
    
}
