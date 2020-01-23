//
//  AppDelegate.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?
    
    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        window = UIWindow()
        self.authService = AuthService()
        authService.delegate = self
        let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as? AuthViewController
        
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    /// MARK: AuthServiceDelegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSingIn() {
        print(#function)
        let feedVC = UIStoryboard(name: "NewsFeedViewController", bundle: nil).instantiateInitialViewController() as! NewsFeedViewController
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }


}

