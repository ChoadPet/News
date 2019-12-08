//
//  AppDelegate.swift
//  WorldwideNews
//
//  Created by pc251 on 03.12.2019.
//  Copyright © 2019 vpoltave. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = NewsNavigationController()
        let router = Router(navigationController: navigationController)
        
        coordinator = Coordinator(router: router)
        coordinator.initialViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Change global tint color
        window?.tintColor = UIColor.systemYellow
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

