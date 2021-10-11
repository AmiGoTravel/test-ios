import UIKit

final class RedditTopEntriesListViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel: RedditTopEntriesListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
