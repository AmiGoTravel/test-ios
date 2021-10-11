import UIKit

protocol RedditTopEntriesListViewControllerProtocol: AnyObject {
    func displayEntries()
    func displayError()
}

final class RedditTopEntriesListViewController: UIViewController, Storyboarded {
    @IBOutlet weak var entriesTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    weak var coordinator: MainCoordinator?
    var viewModel: RedditTopEntriesListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchEntries()
        entriesTableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        entriesTableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh() {
        viewModel?.refreshData()
    }
    
    private func displayFooterLoading() {
        entriesTableView.tableFooterView?.isHidden = false
        let loadingView = LoadingFooterView()
        loadingView.frame = CGRect(x: 0, y: 0, width: entriesTableView.frame.width, height: 50)
        entriesTableView.tableFooterView = loadingView
    }
}

extension RedditTopEntriesListViewController: RedditTopEntriesListViewControllerProtocol {
    func displayEntries() {
        entriesTableView.reloadData()
        entriesTableView.tableFooterView?.isHidden = true
    }
    
    func displayError() {
        entriesTableView.tableFooterView?.isHidden = true
    }
}

extension RedditTopEntriesListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfEntries ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.cellController(forRowAt: indexPath).view(in: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel?.numberOfEntries ?? 0) - 1 {
            displayFooterLoading()
            viewModel?.fetchEntries()
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            viewModel?.cellController(forRowAt: indexPath).preload()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        viewModel?.cellController(forRowAt: indexPath).cancelLoad()
    }
}
