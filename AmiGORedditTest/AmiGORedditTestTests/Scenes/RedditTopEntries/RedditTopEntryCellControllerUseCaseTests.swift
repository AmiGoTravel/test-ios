import XCTest
@testable import AmiGORedditTest

final class RedditTopEntryCellControllerUseCaseTests: XCTestCase {
    
    func test_loadEntriesCompletion_shouldRenderSuccessfullyLoadedEntries() {
        let serviceResponse = RedditAPIRootModel.fixture()
        let serviceStub = RedditTopEntriesListServiceStub()
        let (sut, _) = makeSUT(serviceStub: serviceStub)
        
        serviceStub.completeSuccessfully(with: serviceResponse)
        
        let mappedModel = serviceResponse.data.children.map { $0.data }
        assertThat(sut, isRendering: mappedModel)
    }
    
    private func makeSUT(serviceStub: RedditTopEntriesListServiceStub = RedditTopEntriesListServiceStub()) -> (sut: RedditTopEntriesListViewController, viewModel: RedditTopEntriesListViewModel) {
        let viewModel = RedditTopEntriesListViewModel(controllerDelegate: RedditTopEntriesListViewControllerSpy(), service: serviceStub)
        let sut = RedditTopEntriesListViewController.instantiate()
        sut.viewModel = viewModel
        viewModel.controllerDelegate = sut
        sut.loadViewIfNeeded()
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModel)
        
        return (sut, viewModel)
    }
    
    
    private func assertThat(_ sut: RedditTopEntriesListViewController, isRendering model: [RedditChildrenData], file: StaticString = #file, line: UInt = #line) {

        guard sut.numberOfRenderedAnswersRows() == model.count else {
            return XCTFail("Expected \(model.count) items, got \(sut.numberOfRenderedAnswersRows()) instead", file: file, line: line)
        }

        model.enumerated().forEach { index, cellModel in
            assertCell(sut, hasViewConfiguredFor: cellModel, at: index, file: file, line: line)
        }
    }

    private func assertCell(_ sut: RedditTopEntriesListViewController, hasViewConfiguredFor model: RedditChildrenData, at index: Int, file: StaticString = #file, line: UInt = #line) {
        let view = sut.questionnaireCell(at: index)

        guard let cell = view as? RedditTopEntryCell else {
            return XCTFail("Expected \(RedditTopEntryCell.self) instance, got \(String(describing: view)) instead",file: file, line: line)
        }

        XCTAssertEqual(cell.titleLabel.text, model.title, file: file, line: line)
        XCTAssertEqual(cell.authorLabel.text, model.author, file: file, line: line)
        XCTAssertEqual(cell.numOfCommentsLabel.text, "Comments: \(model.numComments)", file: file, line: line)
    }
}

private extension RedditTopEntriesListViewController {
    func questionnaireCell(at row: Int) -> UITableViewCell? {
        let ds = entriesTableView.dataSource
        let index = IndexPath(row: row, section: topEntriesSection)
        return ds?.tableView(entriesTableView, cellForRowAt: index)
    }
    
    func numberOfRenderedAnswersRows() -> Int {
        return entriesTableView.numberOfRows(inSection: topEntriesSection)
    }
    
    func willDisplay(row: Int) {
        entriesTableView.delegate?.tableView?(entriesTableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: row, section: topEntriesSection))
    }
    
    var topEntriesSection: Int {
        return 0
    }
}
