import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let topEntriesController = RedditTopEntriesListFactory.make(coordinatorDelegate: self)
        navigationController.pushViewController(topEntriesController, animated: false)
    }
}
