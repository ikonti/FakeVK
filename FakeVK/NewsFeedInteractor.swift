//
//  NewsFeedInteractor.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright (c) 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

protocol NewsFeedDataStore
{
  var name: String { get set }
}

class NewsFeedInteractor: NewsFeedBusinessLogic, NewsFeedDataStore {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    var name: String = "Teeest"
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    print(name)
    switch request {
    
    case .getNewsFeed:
        fetcher.getFeed { [weak self] feedResponse in
            guard let feedResponse = feedResponse else { return }
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse))
        }
  
    }
  }
  
}
