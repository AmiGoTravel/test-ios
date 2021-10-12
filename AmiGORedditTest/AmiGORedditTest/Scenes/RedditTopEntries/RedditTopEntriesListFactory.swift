import UIKit

enum RedditTopEntriesListFactory {
    static func make(coordinatorDelegate: MainCoordinator) -> UIViewController {
        let viewController = RedditTopEntriesListViewController.instantiate()
        let viewModel = RedditTopEntriesListViewModel(controllerDelegate: viewController)
        viewController.viewModel = viewModel
        viewModel.coordinator = coordinatorDelegate
        return viewController
    }
}
