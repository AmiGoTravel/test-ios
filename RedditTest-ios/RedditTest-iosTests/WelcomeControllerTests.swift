//
//  WelcomeControllerTests.swift
//  RedditTest-iosTests
//
//  Created by Stefan V. de Moraes on 22/09/21.
//

import XCTest
@testable import RedditTest_ios
class WelcomeControllerTests: XCTestCase {

    var sut: WelcomeViewController!

    override func setUp() {
        sut = UIViewController.instanceBaseController(with: AppIdentifiers.welcomeController) as? WelcomeViewController
        sut.awakeFromNib()
        sut.loadView()
        sut.viewDidLoad()
        sut.viewDidAppear(true)

    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testMainView() throws {
        var hasMainView = false
        if sut.view.isKind(of: WelcomeMainView.self) {
            hasMainView = true
        }
        
        XCTAssertTrue(hasMainView, "View Controller has Main Table View.")
    }

    func testTitle() throws {
        
        XCTAssertTrue(sut.mainView.welcomeLabel.text == "Reddit List", "View Controller has 'Reddit List' as title.")
    }
    
    func testViewModel() throws {
        
        XCTAssertTrue(sut.viewModel?.action != nil)
    }

}
