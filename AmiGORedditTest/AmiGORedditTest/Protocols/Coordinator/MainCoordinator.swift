import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = RedditTopEntriesListViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
}
