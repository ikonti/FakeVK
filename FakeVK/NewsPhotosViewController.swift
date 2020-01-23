//
//  NewsPhotosViewController.swift
//  FakeVK
//
//  Created by Admin on 23.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class NewsPhotosViewController: UIViewController {

    @IBOutlet weak var postImageView: WebImageView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = url else { return }
        postImageView.set(imageUrl: url)
    }
    
    func load(from imageUrl: String?) {
        url = imageUrl
    }

}
