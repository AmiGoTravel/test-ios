//
//  ViewController.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import UIKit

class EntryListViewController: UIViewController, ViewControllerProtocol {
    private var coordinator: Coordinator?
    private var viewModel: EntryListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData() {
            result in
            switch result {
            case .success:
                // reload data
                let a = ""
            case .failure(let error):
                // show error
                let a = ""
            }
        }
    }

    func setCoordinator(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel as? EntryListViewModel
    }
}
