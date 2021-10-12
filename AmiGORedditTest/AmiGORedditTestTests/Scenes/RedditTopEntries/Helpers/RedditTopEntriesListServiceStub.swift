@testable import AmiGORedditTest

final class RedditTopEntriesListServiceStub: RedditTopEntriesListServiceProtocol {
    private(set) var paginationHandler = RedditTopEntriesPaginationHandler()
    private(set) var completions = [CardHomeTransactionsServiceCompletion]()
    
    func fetchTopEntries(_ paginationHandler: RedditTopEntriesPaginationHandler, completion: @escaping CardHomeTransactionsServiceCompletion) {
        self.paginationHandler = paginationHandler
        completions.append(completion)
    }
    
    func completeSuccessfully(with model: RedditAPIRootModel, at index: Int = 0) {
        completions[index](.success(model))
    }
    
    func completeWithFailure(error: ServiceError = .connectivity, at index: Int = 0) {
        completions[index](.failure(error))
    }
}
