//
//  ControllerCoordination.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 20/09/21.
//

import UIKit

protocol ControllerCoordination: AnyObject {
    
    var coordinator: BaseCoordinator? { get set }
}
