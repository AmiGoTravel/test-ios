import XCTest
@testable import AmiGORedditTest

final class RedditEntryDetailsUseCaseTests: XCTestCase {
    
    func test_viewDidLoad_shouldConfigureControllerLabelFromViewModelValue() {
        let entrydata = RedditChildrenData.fixture()
        let (sut, _) = makeSUT(model: entrydata)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.titleLabel.text, entrydata.title)
    }
    
    func test_viewDidLoad_shouldSetImageServiceCompletionData() throws {
        let entrydata = RedditChildrenData.fixture()
        let imageDataLoaderStub = ImageDataLoaderStub()
        let (sut, _) = makeSUT(model: entrydata, imageDataLoaderStub: imageDataLoaderStub)
        
        sut.loadViewIfNeeded()
        try imageDataLoaderStub.completeWithAnyImageData()
        
        XCTAssertNotNil(sut.thumbnailImageView.image)
        XCTAssertEqual(entrydata.thumbnail, imageDataLoaderStub.url.absoluteString)
    }
    
    func makeSUT(model: RedditChildrenData = RedditChildrenData.fixture(),
                 imageDataLoaderStub: ImageDataLoaderStub = ImageDataLoaderStub()) -> (sut: RedditEntryDetailsViewController, viewModel: RedditEntryDetailsViewModel) {
        let sut = RedditEntryDetailsViewController.instantiate()
        let viewModel = RedditEntryDetailsViewModel(entryModel: model, imageLoader: imageDataLoaderStub)
        sut.viewModel = viewModel
        viewModel.controllerDelegate = sut
        
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModel)
        
        return (sut, viewModel)
    }
}
