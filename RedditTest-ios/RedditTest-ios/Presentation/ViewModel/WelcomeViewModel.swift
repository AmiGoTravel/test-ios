//
//  WelcomeViewModel.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 20/09/21.
//

import UIKit

class WelcomeViewModel: BaseViewModelProtocol {
    var view: UIView
    let title: String = Texts.welcomeTitle
    var action: EnterAction?
    
    
    init(view: UIView) {
        self.view = view
    }
    
    func bind() {        
        if let welcomeView = self.view as? WelcomeMainView {
            welcomeView.start(with: self)
            welcomeView.setTitle(title)
        }
    }
    
    func setAction(_ action: @escaping () -> Void) {
        self.action = action
    }
}
