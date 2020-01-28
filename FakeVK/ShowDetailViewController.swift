//
//  ShowDetailViewController.swift
//  FakeVK
//
//  Created by Admin on 28.01.2020.
//  Copyright (c) 2020 Kanat Kuanyshbek. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ShowDetailDisplayLogic: class
{
  func displaySomething(viewModel: ShowDetail.Something.ViewModel)
}

class ShowDetailViewController: UIViewController, ShowDetailDisplayLogic
{
  var interactor: ShowDetailBusinessLogic?
  var router: (NSObjectProtocol & ShowDetailRoutingLogic & ShowDetailDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ShowDetailInteractor()
    let presenter = ShowDetailPresenter()
    let router = ShowDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailImageView: WebImageView!
    
  func doSomething()
  {
    print("FFF")
    let request = ShowDetail.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: ShowDetail.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}