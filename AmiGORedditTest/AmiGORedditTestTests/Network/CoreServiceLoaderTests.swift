import XCTest
@testable import AmiGORedditTest

final class CoreServiceLoaderTests: XCTestCase {
    typealias RedditApiResult = Result<RedditAPIRootModel, ServiceError>
    let completion: ((RedditApiResult) -> Void) = { _ in }
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() throws {
        let endpoint = ApiEndpointFake.fake
        let url = try XCTUnwrap(URL(string: endpoint.absoluteStringUrl))
        let (sut, client) = makeSUT(endpoint: endpoint)
        
        let completion: ((Result<String, ServiceError>) -> Void) = { _ in }
        sut.load(completion: completion)
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() throws {
        let endpoint = ApiEndpointFake.fake
        let url = try XCTUnwrap(URL(string: endpoint.absoluteStringUrl))
        let (sut, client) = makeSUT(endpoint: endpoint)
        
        let completion: ((Result<String, ServiceError>) -> Void) = { _ in }
        sut.load(completion: completion)
        sut.load(completion: completion)
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let endpoint = ApiEndpointFake.fake
        let client = HTTPClientSpy()
        var sut: CoreServiceLoader? = CoreServiceLoader(apiEndpoint: endpoint, client: client)
        
        var capturedResults = [RedditApiResult]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(endpoint: ApiEndpointFake = .fake, file: StaticString = #file, line: UInt = #line) -> (sut: CoreServiceLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = CoreServiceLoader(apiEndpoint: endpoint, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func failure(_ error: ServiceError) -> RedditApiResult {
        return .failure(error)
    }
    
    private func expect(_ sut: CoreServiceLoader, toCompleteWith expectedResult: Result<RedditAPIRootModel, ServiceError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        let completion: ((Result<RedditAPIRootModel, ServiceError>) -> Void) = { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        sut.load(completion: completion)
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["data": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}

extension RedditAPIRootModel: AutoEquatable {}
extension RedditDataModel: AutoEquatable {}
extension ChildrenModel: AutoEquatable {}
extension RedditChildrenData: AutoEquatable {}
