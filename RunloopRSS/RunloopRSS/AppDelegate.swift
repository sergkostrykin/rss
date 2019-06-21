//
//  AppDelegate.swift
//  RunloopRSS
//
//  Created by Sergiy Kostrykin on 6/19/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The main window.
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    var router: AppRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        router = AppRouter(window: window)
        return true
    }
    
}

