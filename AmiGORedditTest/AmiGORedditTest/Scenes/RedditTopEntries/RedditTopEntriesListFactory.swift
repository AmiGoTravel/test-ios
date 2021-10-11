import UIKit

enum RedditTopEntriesListFactory {
    static func make(coordinatorDelegate: MainCoordinator) -> UIViewController {
        let viewController = RedditTopEntriesListViewController.instantiate()
        let viewModel = RedditTopEntriesListViewModel(controllerDelegate: viewController)
        viewController.viewModel = viewModel
        viewController.coordinator = coordinatorDelegate
        return viewController
    }
}
