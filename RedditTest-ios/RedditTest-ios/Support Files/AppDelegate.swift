//
//  AppDelegate.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var startCoodinator: BaseCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        UINavigationBar.appearance().isTranslucent = true

        let controller = UIViewController.instanceBaseController(with: AppIdentifiers.welcomeController)
        
        startCoodinator = WelcomeCoordinator(controller: controller)
        window?.rootViewController = startCoodinator?.navigation
        startCoodinator?.start(previous: nil)
        window?.makeKeyAndVisible()
        
        return true
    }

}

