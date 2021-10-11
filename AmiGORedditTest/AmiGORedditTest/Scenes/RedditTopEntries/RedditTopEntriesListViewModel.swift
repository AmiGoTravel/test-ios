import Foundation

protocol RedditTopEntriesListViewModelProtocol {
    func fetchEntries()
}

final class RedditTopEntriesListViewModel {
    weak var controllerDelegate: RedditTopEntriesListViewControllerProtocol?
    private let service: RedditTopEntriesListServiceProtocol
    private let paginationHandler = RedditTopEntriesPaginationHandler()
    
    init(controllerDelegate: RedditTopEntriesListViewControllerProtocol,
         service: RedditTopEntriesListServiceProtocol = RedditTopEntriesListService()) {
        self.service = service
    }
}

extension RedditTopEntriesListViewModel: RedditTopEntriesListViewModelProtocol {
    func fetchEntries() {
        service.fetchTopEntries(paginationHandler) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(redditModel):
                self.paginationHandler.updatePagination(with: redditModel)
                self.controllerDelegate?.displayEntries(from: self.paginationHandler.entriesList)
            case .failure:
                break
            }
        }
    }
}

final class RedditTopEntriesPaginationHandler {
    private(set) var entriesList = [RedditChildrenData]()
    private(set) var after = ""
    var entriesCount: Int {
        entriesList.count
    }
    
    func updatePagination(with rootModel: RedditAPIRootModel) {
        let newEntries = rootModel.data.children.compactMap { $0.data }
        self.entriesList.append(contentsOf: newEntries)
        self.after = rootModel.data.after
    }
}
