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
                _ = QiitaAPIClient().send(SearchItems())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            print(error)
                            XCTFail()
                        case .finished:
                            expectation.fulfill()
                        }
                    }) { items in
                        XCTAssertGreaterThan(items.count, 0)
                }
                self.wait(for: [expectation], timeout: 2)
            }
        }
    }
}
