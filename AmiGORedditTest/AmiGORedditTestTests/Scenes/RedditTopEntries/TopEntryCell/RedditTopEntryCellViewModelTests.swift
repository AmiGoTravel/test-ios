import XCTest
@testable import AmiGORedditTest

final class RedditTopEntryCellViewModelTests: XCTestCase {
    
    func test_requestImage_presentImageDataWhenServiceCompletesSuccessfully() throws {
        let controllerSpy = EntryCellControllerDelegateSpy()
        let (sut, serviceStub) = makeSUT(controllerDelegate: controllerSpy)
        
        sut.requestImage()
        try serviceStub.completeWithAnyImageData()
        
        XCTAssertEqual(controllerSpy.presentImageDataCallCount, 1)
        XCTAssertEqual(controllerSpy.didStartLoadingImageCallCount, 1)
    }
    
    func test_requestImage_presentsModelWithNoImageIfImageServiceFails() throws {
        let controllerSpy = EntryCellControllerDelegateSpy()
        let (sut, serviceStub) = makeSUT(controllerDelegate: controllerSpy)
        
        sut.requestImage()
        serviceStub.completeWithFailure()
        
        XCTAssertEqual(controllerSpy.presentWithDefaultImageCallCount, 1)
    }
    
    func test_requestImage_cancelsClientTaskWhenServiceTaskIsCanceled() throws {
        let entryModel = RedditChildrenData.fixture()
        let controllerSpy = EntryCellControllerDelegateSpy()
        let (sut, serviceStub) = makeSUT(controllerDelegate: controllerSpy)
        
        sut.requestImage()
        sut.cancelImageRequest()
        
        let modelUrl = try XCTUnwrap(URL(string: entryModel.thumbnail))
        XCTAssertEqual(serviceStub.cancelledURLs, [modelUrl])
    }
    
    private func makeSUT(model: RedditChildrenData = RedditChildrenData.fixture(),
                         controllerDelegate: EntryCellControllerDelegateSpy = EntryCellControllerDelegateSpy()) -> (sut: RedditTopEntryCellViewModel, serviceStub: ImageDataLoaderStub) {
        let serviceStub = ImageDataLoaderStub()
        let sut = RedditTopEntryCellViewModel(model: model, imageLoader: serviceStub)
        sut.controllerDelegate = controllerDelegate
        trackForMemoryLeaks(sut)
        
        return (sut, serviceStub)
    }
}
