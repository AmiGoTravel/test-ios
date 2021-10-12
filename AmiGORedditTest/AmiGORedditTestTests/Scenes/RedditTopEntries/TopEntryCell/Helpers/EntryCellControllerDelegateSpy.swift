@testable import AmiGORedditTest
import Foundation

final class EntryCellControllerDelegateSpy: RedditTopEntryCellControllerDelegate {
    private(set) var presentImageDataCallCount = 0
    private(set) var didStartLoadingImageCallCount = 0
    private(set) var presentWithDefaultImageCallCount = 0
    
    func didStartLoadingImage(for model: RedditChildrenData) {
        didStartLoadingImageCallCount += 1
    }
    
    func presentImageData(with data: Data, for model: RedditChildrenData) {
        presentImageDataCallCount += 1
    }
    
    func presentWithDefaultImage(for model: RedditChildrenData) {
        presentWithDefaultImageCallCount += 1
    }
}
