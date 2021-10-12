//
//  DetailsViewController.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet private(set) weak var thumbImageView: UIImageView?
    
    @IBOutlet private(set) weak var authorLabel: UILabel?
    
    @IBOutlet private(set) weak var titleLabel: UILabel?
    
    @IBOutlet private(set) weak var commentsLabel: UILabel?
    
    @IBOutlet private(set) weak var dateLabel: UILabel?
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .redditPurple
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewModel?.bind()
    }
    
    func start(entry: RedditEntryData) {
        viewModel = DetailsViewModel(view: self.view)
        viewModel?.delegate = self
        viewModel?.entry = entry
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func fillView() {
        guard let entry = viewModel?.entry else { return }
        thumbImageView?.imageFromURL(entry.thumbnail ?? String())
        if thumbImageView?.image == nil {
            thumbImageView?.image = UIImage(named: AppIdentifiers.defaultThumbnail)
        }
        titleLabel?.text = entry.title
        authorLabel?.text = entry.author
        dateLabel?.text = String.secondsToLocal(value: entry.created ?? Float.zero)
        commentsLabel?.text = "comments: \(entry.commentsNumber ?? Int.zero)"
    }
}
