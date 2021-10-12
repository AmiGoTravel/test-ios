//
//  ListCoordinator.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import UIKit

class ListCoordinator: BaseCoordinator {
        
    var flow: CoordinatorFlow = .none
    
    var navigation: UINavigationController
    
    var controller: BaseViewController
    
    var previous: BaseCoordinator?
    
    var next: BaseCoordinator?
    
    var entryData: RedditEntryData?
    
    init(navigation: UINavigationController, controller: BaseViewController) {
        self.controller = controller
        self.navigation = navigation
        self.flow = .list
    }
    
    func start(previous: BaseCoordinator?) {
        self.previous = previous
        doPresentaion(action: .push)
    }
    
    func go(to flow: CoordinatorFlow) {
        switch flow {
        case .welcome:
            navigation.popViewController(animated: true)
        case .details:
            guard let detailsController = UIViewController.instanceBaseController(with: AppIdentifiers.detailsController) as? DetailsViewController,
                  let entry = entryData
            else { return }
            detailsController.start(entry: entry)
            next = DetailsCoordinator(navigation: self.navigation,
                                      controller: detailsController)
            next?.start(previous: self)
        default:
            return
        }
    }
    
    func doPresentaion(action: PresenterAction) {
        switch action {
        case .push:
            navigation.pushViewController(controller, animated: true)
        default:
            return
        }
    }
    
}
