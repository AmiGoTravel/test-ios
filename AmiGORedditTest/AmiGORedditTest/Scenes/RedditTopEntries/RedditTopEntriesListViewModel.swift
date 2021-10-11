import Foundation

protocol RedditTopEntriesListViewModelProtocol {
    var numberOfEntries: Int { get }
    func fetchEntries()
    func cellController(forRowAt indexPath: IndexPath) -> RedditTopEntryCellController
    func refreshData()
}

final class RedditTopEntriesListViewModel {
    weak var controllerDelegate: RedditTopEntriesListViewControllerProtocol?
    private let service: RedditTopEntriesListServiceProtocol
    private let paginationHandler = RedditTopEntriesPaginationHandler()
    
    init(controllerDelegate: RedditTopEntriesListViewControllerProtocol,
         service: RedditTopEntriesListServiceProtocol = MainThreadDispatchDecorator(RedditTopEntriesListService())) {
        self.service = service
        self.controllerDelegate = controllerDelegate
    }
}

extension RedditTopEntriesListViewModel: RedditTopEntriesListViewModelProtocol {
    var numberOfEntries: Int { paginationHandler.entriesCount }
    
    func cellController(forRowAt indexPath: IndexPath) -> RedditTopEntryCellController {
        return paginationHandler.cellControllers[indexPath.row]
    }
    
    func fetchEntries() {
        service.fetchTopEntries(paginationHandler) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(redditModel):
                self.paginationHandler.updatePagination(with: redditModel)
                self.controllerDelegate?.displayEntries()
            case .failure:
                break
            }
        }
    }
    
    func refreshData() {
        paginationHandler.shouldResetPagination = true
        fetchEntries()
    }
}
