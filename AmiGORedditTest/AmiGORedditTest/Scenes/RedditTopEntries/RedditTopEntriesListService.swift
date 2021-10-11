import Foundation

typealias CardHomeTransactionsServiceCompletion = (Result<RedditAPIRootModel, Error>) -> Void

protocol RedditTopEntriesListServiceProtocol {
    func fetchTopEntries(completion: @escaping CardHomeTransactionsServiceCompletion)
}

final class RedditTopEntriesListService {
    let serviceLoader: ServiceLoader
    
    init(serviceLoader: ServiceLoader = CoreServiceLoader(apiEndpoint: TopEntriesEndPoint.topEntries)) {
        self.serviceLoader = serviceLoader
    }
}

extension RedditTopEntriesListService: RedditTopEntriesListServiceProtocol {
    func fetchTopEntries(completion: @escaping CardHomeTransactionsServiceCompletion) {
        
    }
}
