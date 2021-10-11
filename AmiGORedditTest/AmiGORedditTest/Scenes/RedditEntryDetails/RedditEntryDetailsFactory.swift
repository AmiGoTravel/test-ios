import UIKit

enum RedditEntryDetailsFactory {
    static func make(model: RedditChildrenData, coordinatorDelegate: MainCoordinator) -> UIViewController {
        let viewController = RedditEntryDetailsViewController.instantiate()
        let viewModel = RedditEntryDetails(entryModel: model)
        viewModel.coordinator = coordinatorDelegate
        viewModel.controllerDelegate = viewController
        
        return viewController
    }
}
