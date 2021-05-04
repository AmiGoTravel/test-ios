//
//  ViewControllerProtocol.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 4/5/21.
//

import Foundation
import UIKit

protocol ViewControllerProtocol {
    static func getInstance() -> Self
    func setCoordinator(coordinator: Coordinator)
    func bindViewModel(viewModel: ViewModelProtocol)
}

extension ViewControllerProtocol {
    static func getInstance() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        getWindow().rootViewController?.present(alert, animated: true)
    }
    
    func getWindow() -> UIWindow {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        
        return alertWindow
    }
}
