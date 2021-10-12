//
//  DetailsViewModel.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 22/09/21.
//

import UIKit

protocol DetailsViewModelDelegate: AnyObject {
    func fillView()
}

class DetailsViewModel: BaseViewModelProtocol {
    
    var view: UIView
    let title: String = Texts.welcomeTitle
    var action: EnterAction?
    var entry: RedditEntryData?
    var after: String?
    
    weak var delegate: DetailsViewModelDelegate?
        
    init(view: UIView) {
        self.view = view
    }
    
    func bind() {
        delegate?.fillView()
      
    }
    
    func showError(error: RedditError) -> UIAlertController  {
        let alertController = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .cancel) { action in
            (self.action ?? { })()
        }
        
        alertController.addAction(action)
        
        return alertController
    }
    
    func setAction(_ action: @escaping () -> Void) {
        self.action = action
    }
}
