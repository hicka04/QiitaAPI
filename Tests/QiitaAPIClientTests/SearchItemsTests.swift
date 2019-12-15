//
//  SearchItemsTests.swift
//  
//
//  Created by hicka04 on 2019/12/13.
//

import XCTest
import QiitaAPIClient

class SearchItemsTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testSearchItems() {
        XCTContext.runActivity(named: "when response OK") { _ in
            XCTContext.runActivity(named: "items.count > 0") { _ in
                let expectation = self.expectation(description: "fetch")
                QiitaAPIClient().send(SearchItems()) { result in
                    switch result {
                    case .success(let items):
                        XCTAssertGreaterThan(items.count, 0)
                        expectation.fulfill()
                    case .failure:
                        XCTFail()
                    }
                }
                self.wait(for: [expectation], timeout: 2)
            }
        }
    }
}
