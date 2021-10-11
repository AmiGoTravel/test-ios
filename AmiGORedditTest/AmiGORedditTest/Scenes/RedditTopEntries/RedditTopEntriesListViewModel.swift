import Foundation

protocol RedditTopEntriesListViewModelProtocol {
    func fetchEntries()
}

final class RedditTopEntriesListViewModel {
    weak var controllerDelegate: RedditTopEntriesListViewControllerProtocol?
    private let service: RedditTopEntriesListServiceProtocol
    private var entriesList = [RedditChildrenData]()
    private var after = ""
    
    init(controllerDelegate: RedditTopEntriesListViewControllerProtocol,
         service: RedditTopEntriesListServiceProtocol = RedditTopEntriesListService()) {
        self.service = service
    }
}

extension RedditTopEntriesListViewModel: RedditTopEntriesListViewModelProtocol {
    func fetchEntries() {
        service.fetchTopEntries { result in
            switch result {
            case let .success(redditModel):
                self.after = redditModel.data.after
                let newEntries = redditModel.data.children.compactMap { $0.data }
                self.entriesList.append(contentsOf: newEntries)
            case .failure:
                break
            }
        }
    }
}
