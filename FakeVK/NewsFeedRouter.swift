//
//  NewsFeedRouter.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright (c) 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

protocol NewsFeedRoutingLogic {
    func routeToShowDetail(segue: UIStoryboardSegue?)
}

protocol NewsFeedDataPassing
{
  var dataStore: NewsFeedDataStore? { get }
}

class NewsFeedRouter: NSObject, NewsFeedRoutingLogic, NewsFeedDataPassing {
    
    weak var viewController: NewsFeedViewController?
    var dataStore: NewsFeedDataStore?
  
  // MARK: Routing
  
    func routeToShowDetail(segue: UIStoryboardSegue?)
    {
      if let segue = segue {
        let destinationVC = segue.destination as! ShowDetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowDetail(source: dataStore!, destination: &destinationDS)
      } else {
        let storyboard = UIStoryboard(name: "NewsFeedViewController", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ShowDetailViewController") as! ShowDetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowDetail(source: dataStore!, destination: &destinationDS)
        navigateToShowDetail(source: viewController!, destination: destinationVC)
      }
    }

    // MARK: Navigation
    
    func navigateToShowDetail(source: NewsFeedViewController, destination: ShowDetailViewController)
    {
      source.show(destination, sender: nil)
        destination.doSomething()
    }
    
    // MARK: Passing data
    
    func passDataToShowDetail(source: NewsFeedDataStore, destination: inout ShowDetailDataStore)
    {
        print(source.name)
      destination.name = source.name
    }
}
