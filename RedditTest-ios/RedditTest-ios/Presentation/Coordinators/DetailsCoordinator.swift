//
//  DetailsCoordinator.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 22/09/21.
//

import UIKit

class DetailsCoordinator: BaseCoordinator {
        
    var flow: CoordinatorFlow = .none
    
    var navigation: UINavigationController
    
    var controller: BaseViewController
    
    var previous: BaseCoordinator?
    
    var next: BaseCoordinator?
    
    init(navigation: UINavigationController, controller: BaseViewController) {
        self.controller = controller
        self.navigation = navigation
        self.flow = .details
    }
    
    func start(previous: BaseCoordinator?) {
        self.previous = previous
        doPresentaion(action: .push)
    }
    
    func go(to flow: CoordinatorFlow) {
        
        switch flow {
        case .list:
            self.navigation.popViewController(animated: true)
        default:
            return
        }
    }
    
    func doPresentaion(action: PresenterAction) {
        switch action {
        case .push:
            navigation.pushViewController(controller, animated: true)
        case .present:
            navigation.present(controller, animated: true, completion: nil)
        default:
            return
        }
    }
}
