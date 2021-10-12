//
//  UIViewController+Extension.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import UIKit

extension UIViewController {
    
    class func instanceBaseController(with identifier: String) -> BaseViewController {
        let storyboard = UIStoryboard(name: AppIdentifiers.storyboard, bundle: Bundle(for: BaseViewController.self))
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? BaseViewController
        else { return BaseViewController() }
        
        return controller
    }
    
}
