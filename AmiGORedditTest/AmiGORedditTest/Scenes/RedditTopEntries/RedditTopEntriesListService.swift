import Foundation

typealias CardHomeTransactionsServiceCompletion = (Result<RedditAPIRootModel, ServiceError>) -> Void

protocol RedditTopEntriesListServiceProtocol {
    func fetchTopEntries(_ paginationHandler: RedditTopEntriesPaginationHandler,
                         completion: @escaping CardHomeTransactionsServiceCompletion)
}

final class RedditTopEntriesListService {
    let serviceLoader: ServiceLoader
    
    init(serviceLoader: ServiceLoader = CoreServiceLoader()) {
        self.serviceLoader = serviceLoader
    }
}

extension RedditTopEntriesListService: RedditTopEntriesListServiceProtocol {
    func fetchTopEntries(_ paginationHandler: RedditTopEntriesPaginationHandler,
                         completion: @escaping CardHomeTransactionsServiceCompletion) {
        DispatchQueue.main.async {
            self.serviceLoader.load(
                apiEndpoint: TopEntriesEndPoint.topEntries(after: paginationHandler.after,
                                                           count: paginationHandler.entriesCount),
                completion: completion
            )
        }
    }
}
