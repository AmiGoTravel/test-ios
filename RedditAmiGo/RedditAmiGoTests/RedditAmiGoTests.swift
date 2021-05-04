//
//  RedditAmiGoTests.swift
//  RedditAmiGoTests
//
//  Created by Leonardo Saganski on 3/5/21.
//

import XCTest
@testable import RedditAmiGo

class RedditAmiGoTests: XCTestCase {

    var entries: [Entry] = []
    
    override func setUpWithError() throws {
        entries = [Entry(kind: "", data: EntryInfo(id: "0", title: "A", author: "A", thumbnail: "A", num_comments: 0, created: 0)), Entry(kind: "", data: EntryInfo(id: "0", title: "A", author: "A", thumbnail: "A", num_comments: 0, created: 0))]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetItem() throws {
        let viewModel = EntryDetailsViewModel()
        viewModel.setItem(item: entries[0].data)
        XCTAssertTrue(viewModel.item != nil)
    }

    func testGetItemByIndex() throws {
        let viewModel = EntryListViewModel()
        viewModel.setItems(entries: self.entries)
        XCTAssertTrue(viewModel.getItemByIndex(index: 0) != nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
