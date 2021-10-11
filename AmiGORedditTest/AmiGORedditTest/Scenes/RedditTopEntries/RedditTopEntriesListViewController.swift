import UIKit

protocol RedditTopEntriesListViewControllerProtocol: AnyObject {
    func displayEntries(from model: [RedditChildrenData])
}

final class RedditTopEntriesListViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel: RedditTopEntriesListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchEntries()
    }
}

extension RedditTopEntriesListViewController: RedditTopEntriesListViewControllerProtocol {
    func displayEntries(from model: [RedditChildrenData]) {
        
    }
}
