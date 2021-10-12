@testable import AmiGORedditTest
import XCTest

final class ImageDataLoaderStub: ImageDataLoader {
    private(set) var url = URL(string: "https://invalid-url")!
    private(set) var completions = [(ImageDataLoader.Result) -> Void]()
    private(set) var cancelledURLs = [URL]()
    
    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        self.url = url
        completions.append(completion)
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
    
    private struct Task: ImageDataLoaderTask {
        let callback: () -> Void
        func cancel() { callback() }
    }
    
    func completeWithAnyImageData(at index: Int = 0) throws {
        let image = UIImage(systemName: "heart.fill")
        let dataImage = try XCTUnwrap(image?.pngData())
        completions[index](.success(dataImage))
    }
    
    func completeWithFailure(at index: Int = 0) {
        let error = NSError(domain: "anyError", code: -1)
        completions[index](.failure(error))
    }
}
