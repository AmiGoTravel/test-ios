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
    private var viewModel: EntryDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Entry details..."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    func setCoordinator(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func bindViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel as? EntryDetailsViewModel
    }
    
    func loadData() {
        lblTitle.text = viewModel?.item?.title
        lblAuthor.text = viewModel?.item?.author
        lblNumComments.text = "\(viewModel?.item?.num_comments ?? 0)"
        let now = Int(Date().timeIntervalSince1970)
        let diff = Int(viewModel?.item?.created ?? 0) - now
        let hours = diff / 3600
        lblDate.text = "\(hours)"
        let thumbnail = viewModel?.item?.thumbnail
        ApiHelper.getImage(fromUrl: thumbnail ?? "") {
            [weak self]
            success, data in
            guard let self = self else { return }
            if success {
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imgThumb.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.imgThumb.image = #imageLiteral(resourceName: "ph")
                }
            }
        }
    }
}
