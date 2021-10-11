import UIKit

protocol RedditTopEntriesListViewControllerProtocol: AnyObject {
    func displayEntries(from model: [RedditChildrenData])
}

final class RedditTopEntriesListViewController: UIViewController, Storyboarded {
    @IBOutlet weak var entriesTableView: UITableView!
    
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

extension RedditTopEntriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfEntries ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
