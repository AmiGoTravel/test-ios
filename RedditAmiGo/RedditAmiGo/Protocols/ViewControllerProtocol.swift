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
}
