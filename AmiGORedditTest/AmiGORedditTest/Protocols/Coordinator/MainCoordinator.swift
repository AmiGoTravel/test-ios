import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let topEntriesController = RedditTopEntriesListFactory.make(coordinatorDelegate: self)
        topEntriesController.title = "Top Entries"
        navigationController.pushViewController(topEntriesController, animated: false)
    }
}


extension MainCoordinator {
    func showEntryDetails(with model: RedditChildrenData) {
        let viewController = RedditEntryDetailsFactory.make(model: model, coordinatorDelegate: self)
        viewController.title = model.author
        navigationController.pushViewController(viewController, animated: true)
    }
}
