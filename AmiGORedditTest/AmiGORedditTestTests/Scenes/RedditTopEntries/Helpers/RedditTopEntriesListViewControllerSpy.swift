@testable import AmiGORedditTest

final class RedditTopEntriesListViewControllerSpy : RedditTopEntriesListViewControllerProtocol {
    private(set) var displayEntriesCallCount = 0
    private(set) var displayErrorCallCount = 0
    
    func displayEntries() {
        displayEntriesCallCount += 1
    }
    
    func displayError() {
        displayErrorCallCount += 1
    }
}
