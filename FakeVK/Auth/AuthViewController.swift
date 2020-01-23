//
//  AuthViewController.swift
//  FakeVK
//
//  Created by Admin on 22.01.2020.
//  Copyright © 2020 Kanat Kuanyshbek. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        authService = AuthService()
        authService = AppDelegate.shared().authService
    }
    

    @IBAction func signInToch() {
        authService.wakeUpSession()
    }

}
