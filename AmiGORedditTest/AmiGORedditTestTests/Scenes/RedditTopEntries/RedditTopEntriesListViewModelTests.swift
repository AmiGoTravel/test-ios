import XCTest
@testable import AmiGORedditTest

final class RedditTopEntriesListViewModelTests: XCTestCase {
    
    func test_fetchEntries_shouldDisplayErrorOnServiceFailure() {
        let (sut, controllerSpy, serviceStub) = makeSUT()
        
        sut.fetchEntries()
        serviceStub.completeWithFailure()
        
        XCTAssertEqual(controllerSpy.displayErrorCallCount, 1)
    }
    
    func test_fetchEntries_shouldDisplayEntriesOnServiceSuccess() {
        let successModel = RedditAPIRootModel.fixture()
        let (sut, controllerSpy, serviceStub) = makeSUT()
        
        sut.fetchEntries()
        serviceStub.completeSuccessfully(with: successModel)
        
        XCTAssertEqual(controllerSpy.displayEntriesCallCount, 1)
    }
    
    func test_fetchEntries_shouldUpdatePaginationHandlerCorrectly() {
        let successModel = RedditAPIRootModel.fixture()
        let (sut, _, serviceStub) = makeSUT()
        
        sut.fetchEntries()
        serviceStub.completeSuccessfully(with: successModel)
        
        let mappedModel = successModel.data.children.map { $0.data }
        XCTAssertEqual(sut.paginationHandler.after, successModel.data.after)
        XCTAssertEqual(sut.paginationHandler.entriesList, mappedModel)
    }
    
    func test_fetchEntries_shouldUpdatePaginationHandlerCorrectlyWhenCalledTwice() {
        let firstResponse = RedditAPIRootModel.fixture()
        let secondResponse = RedditAPIRootModel.fixture(after: "secondAfter")
        let (sut, _, serviceStub) = makeSUT()
        
        sut.fetchEntries()
        serviceStub.completeSuccessfully(with: firstResponse)
        
        sut.fetchEntries()
        serviceStub.completeSuccessfully(with: secondResponse)
        
        var combinedResponse = firstResponse.data.children.map { $0.data }
        combinedResponse.append(contentsOf: secondResponse.data.children.map { $0.data })
        XCTAssertEqual(sut.paginationHandler.after, secondResponse.data.after)
        XCTAssertEqual(sut.paginationHandler.entriesList, combinedResponse)
    }
    
    func test_refreshData_shouldResetPaginationAndFetchNewEntries() {
        let firstResponse = RedditAPIRootModel.fixture()
        let secondResponse = RedditAPIRootModel.fixture(after: "secondAfter")
        let (sut, _, serviceStub) = makeSUT()
        
        sut.fetchEntries()
        serviceStub.completeSuccessfully(with: firstResponse)
        
        sut.refreshData()
        serviceStub.completeSuccessfully(with: secondResponse)
        
        let mappedModel = secondResponse.data.children.map { $0.data }
        XCTAssertEqual(sut.paginationHandler.after, secondResponse.data.after)
        XCTAssertEqual(sut.paginationHandler.entriesList, mappedModel)
    }

    func test_navigateToDetailScene_shouldStartNavigationToEntryDetails() {
        let successModel = RedditAPIRootModel.fixture()
        let coordinatorSpy = CoordinatorSpy()
        let (sut, _, serviceStub) = makeSUT()
        sut.coordinator = coordinatorSpy
        
        sut.fetchEntries()
        serviceStub.completeSuccessfully(with: successModel)
        
        sut.navigateToDetailScene(indexpath: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(coordinatorSpy.showEntryDetailsCallCount, 1)
    }
    
    //MARK: - HELPERS
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: RedditTopEntriesListViewModel, controllerSpy: RedditTopEntriesListViewControllerSpy, serviceStub: RedditTopEntriesListServiceStub) {
        let controllerSpy = RedditTopEntriesListViewControllerSpy()
        let serviceStub = RedditTopEntriesListServiceStub()
        let sut = RedditTopEntriesListViewModel(controllerDelegate: controllerSpy, service: serviceStub)
        trackForMemoryLeaks(sut)
        
        return (sut, controllerSpy, serviceStub)
    }
    
}
