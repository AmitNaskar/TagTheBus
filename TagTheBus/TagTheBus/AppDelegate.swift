//
//  AppDelegate.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor.lightGray
        
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as? ContainerViewController {
            let navigationController = UINavigationController.init(rootViewController: viewController)
            self.window?.rootViewController = navigationController
            
            self.window?.makeKeyAndVisible()
        }
        return true
    }

}

