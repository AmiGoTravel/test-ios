//
//  ListViewControllerTests.swift
//  RedditTest-iosTests
//
//  Created by Stefan V. de Moraes on 22/09/21.
//

import XCTest
@testable import RedditTest_ios

class ListViewControllerTests: XCTestCase {
    
    var sut: ListViewController!

    override func setUp() {
        sut = UIViewController.instanceBaseController(with: AppIdentifiers.listController) as! ListViewController
        sut.awakeFromNib()
        sut.loadView()
        sut.viewDidLoad()
        sut.viewDidAppear(true)

    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func testViewModelStartsInFirstPAge() throws {
        XCTAssertTrue(sut.viewModel?.after == nil, "The 'after' key is nil")
    }

    func testMainView() throws {
        var hasMainView = false
        for view in sut.view.subviews {
            if view.isKind(of: PaginableTableView.self) {
                hasMainView = true
            }
        }
        
        XCTAssertTrue(hasMainView, "View Controller has Main Table View.")
    }
    
    func testTitle() throws {
        
        XCTAssertTrue(sut.listTitleLabel?.text == "Reddit List", "View Controller has 'Reddit List' as title.")
    }

    func testPerformanceExample() throws {
        self.measure {
            sut.viewModel?.fetchEntries(params: RedditRequest(), completion: {
                XCTAssertFalse(((self.sut.viewModel?.hasMore) != nil))
            })
        }
    }

}
