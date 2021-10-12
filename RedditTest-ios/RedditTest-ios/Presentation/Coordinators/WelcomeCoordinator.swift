//
//  WelcomeCoordinator.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 20/09/21.
//

import UIKit

class WelcomeCoordinator: BaseCoordinator {
        
    var flow: CoordinatorFlow = .none
    
    var navigation: UINavigationController
    
    var controller: BaseViewController
    
    var previous: BaseCoordinator?
    
    var next: BaseCoordinator?
    
    init(controller: BaseViewController) {
        self.controller = controller
        self.navigation = UINavigationController(rootViewController: self.controller)
        self.flow = .welcome
    }
    
    func start(previous: BaseCoordinator?) {
        self.previous = previous
        self.controller.coordinator = self
        doPresentaion(action: .push)
    }
    
    func go(to flow: CoordinatorFlow) {
        
        switch flow {
        case .welcome:
            start(previous: nil)
        case .list:
            let listController = UIViewController.instanceBaseController(with: AppIdentifiers.listController)
            let listCoordinator = ListCoordinator(navigation: self.navigation, controller: listController)
            next = listCoordinator
            listController.coordinator = next
            next?.start(previous: self)
        default:
            return
        }
    }
    
    func doPresentaion(action: PresenterAction) {
        switch action {
        case .present:
            navigation.present(controller, animated: true, completion: nil)
        default:
            return
        }
    }
    
}
