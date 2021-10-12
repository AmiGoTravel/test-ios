import Foundation

protocol ImageDataLoaderTask {
    func cancel()
}

protocol ImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    @discardableResult
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> ImageDataLoaderTask
}
