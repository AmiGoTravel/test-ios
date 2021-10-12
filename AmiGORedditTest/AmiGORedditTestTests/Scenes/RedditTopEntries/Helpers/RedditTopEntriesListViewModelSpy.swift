@testable import AmiGORedditTest
import Foundation

final class RedditTopEntriesListViewModelSpy: RedditTopEntriesListViewModelProtocol {
    private(set) var fetchEntriesCallCount = 0
    private(set) var refreshDataCallCount = 0
    private(set) var navigateToDetailSceneCallCount = 0
    
    
    var numberOfEntries: Int { return 2 }
    
    func fetchEntries() {
        fetchEntriesCallCount += 1
    }
    
    func cellController(forRowAt indexPath: IndexPath) -> RedditTopEntryCellController {
        return RedditTopEntryCellController(viewModel: RedditTopEntryCellViewModel(model: RedditChildrenData.fixture()))
    }
    
    func refreshData() {
        refreshDataCallCount += 1
    }
    
    func navigateToDetailScene(indexpath: IndexPath) {
        navigateToDetailSceneCallCount += 1
    }
}
