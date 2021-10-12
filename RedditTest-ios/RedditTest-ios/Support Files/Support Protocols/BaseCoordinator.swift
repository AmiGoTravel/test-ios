//
//  BaseCoordinator.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

@objc
enum PresenterAction: Int {
    case present
    case push
}

@objc
enum CoordinatorFlow: Int {
    case welcome
    case list
    case details
    case none
}

@objc
protocol BaseCoordinator: AnyObject {
    
    var flow: CoordinatorFlow { get set }
    var navigation: UINavigationController { get }
    var controller: BaseViewController { get set}
    var previous: BaseCoordinator? { get }
    var next: BaseCoordinator? { get }
    
    @objc func start(previous: BaseCoordinator?)
    @objc optional func go(to flow: CoordinatorFlow)
    @objc optional func doPresentaion(action: PresenterAction)
}
