//
//  NewsFeedPresenter.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright (c) 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
  weak var viewController: NewsFeedDisplayLogic?
    var cellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
    case .presentNewsFeed(let feed):
        
        let cells = feed.items.map { feedItem in
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
        }
        let feedViewModel = FeedViewModel.init(cells: cells)
        viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachment = self.photoAttachment(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment)
        
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachment: photoAttachment,
                                       sizes: sizes)
        
    }
    
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable {
        
        let profilesOrGroups: [ProfileRepresenatable] = sourseId >= 0 ? profiles : groups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresenatable = profilesOrGroups.first { (myProfileRepresenatable) -> Bool in
            myProfileRepresenatable.id == normalSourseId
        }
        return profileRepresenatable!
    }
  
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil}
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
}
