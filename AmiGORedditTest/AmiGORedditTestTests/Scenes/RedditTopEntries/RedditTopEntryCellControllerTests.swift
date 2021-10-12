import XCTest
@testable import AmiGORedditTest

final class RedditTopEntryCellControllerTests: XCTestCase {
    
    func test_viewDidLoad_shouldFetchEntriesWhenViewLoads() {
        let (sut, viewModel) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(viewModel.fetchEntriesCallCount, 1)
    }
    
    func test_viewDidLoad_shouldRefreshDataWhenPullToRefreshTriggers() {
        let (sut, viewModel) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.refreshControl.simulatePullToRefresh()
        
        XCTAssertEqual(viewModel.refreshDataCallCount, 1)
    }
    
    func test_selectRow_shouldNavigateToDetailsSceneWhenSelectsARow() {
        let (sut, viewModel) = makeSUT()
        
        sut.loadViewIfNeeded()
        sut.didSelectRow()
        
        XCTAssertEqual(viewModel.navigateToDetailSceneCallCount, 1)
    }
    
    private func makeSUT() -> (sut: RedditTopEntriesListViewController, viewModel: RedditTopEntriesListViewModelSpy) {
        let viewModel = RedditTopEntriesListViewModelSpy()
        let sut = RedditTopEntriesListViewController.instantiate()
        sut.viewModel = viewModel
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModel)
        
        return (sut, viewModel)
    }
}

private extension RedditTopEntriesListViewController {
    func didSelectRow(at row: Int = 0) {
        let indexPath = IndexPath(row: row, section: topEntriesSection)
        entriesTableView.delegate?.tableView?(entriesTableView, didSelectRowAt: indexPath)
    }
    
    var topEntriesSection: Int {
        return 0
    }
}
