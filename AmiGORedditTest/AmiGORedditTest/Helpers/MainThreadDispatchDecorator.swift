import Foundation

final class MainThreadDispatchDecorator<T> {
    private let decoratee: T
    
    init(_ decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

extension MainThreadDispatchDecorator: RedditTopEntriesListServiceProtocol where T == RedditTopEntriesListServiceProtocol {
    func fetchTopEntries(_ paginationHandler: RedditTopEntriesPaginationHandler, completion: @escaping CardHomeTransactionsServiceCompletion) {
        self.decoratee.fetchTopEntries(paginationHandler) { result in
            self.dispatch { completion(result) }
        }
    }
}

extension MainThreadDispatchDecorator: ImageDataLoader where T == ImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        self.decoratee.loadImageData(from: url) { result in
            self.dispatch { completion(result) }
        }
    }
}
