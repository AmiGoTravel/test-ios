import UIKit

enum RedditEntryDetailsFactory {
    static func make(model: RedditChildrenData, coordinatorDelegate: MainCoordinator) -> UIViewController {
        let viewController = RedditEntryDetailsViewController.instantiate()
        let viewModel = RedditEntryDetailsViewModel(entryModel: model)
        viewModel.coordinator = coordinatorDelegate
        viewModel.controllerDelegate = viewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
