//
//  WelcomeViewController.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    private(set) lazy var mainView =  WelcomeMainView()
    private(set) var viewModel: WelcomeViewModel?

    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WelcomeViewModel(view: mainView)
        viewModel?.setAction(goToList)
        viewModel?.bind()
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    @objc
    func goToList() {
        coordinator?.go?(to: .list)
    }
    
}
