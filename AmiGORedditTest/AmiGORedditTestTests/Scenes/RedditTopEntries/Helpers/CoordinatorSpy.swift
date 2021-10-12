@testable import AmiGORedditTest

final class CoordinatorSpy: RedditTopEntriesCoordinatorDelegate {
    private(set) var showEntryDetailsCallCount = 0
    
    func showEntryDetails(with model: RedditChildrenData) {
        showEntryDetailsCallCount += 1
    }
}
