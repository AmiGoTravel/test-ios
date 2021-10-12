//
//  DetailsViewControllerTests.swift
//  RedditTest-iosTests
//
//  Created by Stefan V. de Moraes on 22/09/21.
//

import XCTest
@testable import RedditTest_ios
class DetailsViewControllerTests: XCTestCase {

    var sut: DetailsViewController!

    override func setUp() {
        sut = UIViewController.instanceBaseController(with: AppIdentifiers.detailsController) as? DetailsViewController
        sut.awakeFromNib()
        sut.loadView()
        sut.viewDidLoad()
        sut.viewDidAppear(true)
        let testEntry = RedditEntryData(title: "Esse é o texto para teste!", author: "Stefan", thumbnail: nil, commentsNumber: 1234, created: 1732238837.0)
        sut.start(entry: testEntry)
        sut.viewModel?.bind()

    }
    
    func testTitle() throws {
        
        XCTAssertTrue(sut.titleLabel?.text == "Esse é o texto para teste!", "View Controller has a text for title.")
    }
    
    func testAuthor() throws {
        
        XCTAssertTrue(sut.authorLabel?.text == "Stefan", "View Controller has 'Stefan' as title.")
    }
    
    func testComent() throws {
        
        XCTAssertTrue(sut.commentsLabel?.text == "comments: 1234", "View Controller has '1234' comments.")
    }
    
    func testViewModel() throws {
        
        XCTAssertTrue(sut.viewModel != nil)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
}
