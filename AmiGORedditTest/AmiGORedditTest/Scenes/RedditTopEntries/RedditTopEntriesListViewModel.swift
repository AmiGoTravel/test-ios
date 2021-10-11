import Foundation

protocol RedditTopEntriesListViewModelProtocol {
    func fetchEntries()
}

final class RedditTopEntriesListViewModel {
    private let service: RedditTopEntriesListServiceProtocol
    
    init(service: RedditTopEntriesListServiceProtocol = RedditTopEntriesListService()) {
        self.service = service
    }
}

extension RedditTopEntriesListViewModel: RedditTopEntriesListViewModelProtocol {
    func fetchEntries() {
        service.fetchTopEntries { result in
            switch result {
            case let .success(redditModel):
                break
            case .failure:
                break
            }
        }
    }
}
