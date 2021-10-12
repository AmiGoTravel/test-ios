//
//  BaseViewModelProtocol.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

protocol BaseViewModelProtocol: AnyObject {
    typealias EnterAction = () -> Void

    var view: UIView { get }
    var action: EnterAction? { get set }

    func bind()
    func setAction(_ action: @escaping () -> Void)
}
