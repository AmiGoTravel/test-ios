//
//  EntryDetailsViewController.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import UIKit

class EntryDetailsViewController: UIViewController, ViewControllerProtocol {
    private var coordinator: Coordinator?
    private var viewModel: ViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setCoordinator(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
    }
}
