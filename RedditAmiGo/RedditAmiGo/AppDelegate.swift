//
//  AppDelegate.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navController = UINavigationController()
        coordinator = Coordinator(navController: navController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().barTintColor = UIColor.brown
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        return true
    }
}

