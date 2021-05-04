//
//  EntryDetailsViewController.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import UIKit

class EntryDetailsViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblNumComments: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    
    private var coordinator: Coordinator?
    private var viewModel: ViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Entry details..."
    }

    func setCoordinator(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
    }
}
