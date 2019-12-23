//
//  SearchItemsTests.swift
//  
//
//  Created by hicka04 on 2019/12/13.
//

import XCTest
import QiitaAPIClient
import Combine

class SearchItemsTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testRequest() {
        XCTContext.runActivity(named: "when response OK") { _ in
            XCTContext.runActivity(named: "items.count > 0") { _ in
                let expectation = self.expectation(description: "fetch")
                QiitaAPIClient().send(QiitaAPI.SearchItems())
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
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
    }
    
    func testQueryRequest() {
        XCTContext.runActivity(named: "when query parameter is empty") { _ in
            XCTContext.runActivity(named: "items.count == 0") { _ in
                let expectation = self.expectation(description: "query is empty")
                QiitaAPIClient().send(QiitaAPI.SearchItems(query: ""))
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
                        XCTAssertEqual(items.count, 0)
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
        
        XCTContext.runActivity(named: "when query parameter is not empty") { _ in
            XCTContext.runActivity(named: "items.count > 0") { _ in
                let expectation = self.expectation(description: "query is not empty")
                QiitaAPIClient().send(QiitaAPI.SearchItems(query: "Swift"))
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
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
    }
    
    func testPageRequest() {
        XCTContext.runActivity(named: "when page parameter is 0") { _ in
            XCTContext.runActivity(named: "error response") { _ in
                let expectation = self.expectation(description: "page is 0")
                QiitaAPIClient().send(QiitaAPI.SearchItems(page: 0))
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            switch error {
                            case .apiError(let response):
                                print(response)
                                XCTAssertTrue(true)
                                expectation.fulfill()
                            default:
                                XCTFail()
                            }
                        case .finished:
                            XCTFail()
                        }
                    }) { items in
                        XCTFail()
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
        
        XCTContext.runActivity(named: "when page parameter > 0") { _ in
            XCTContext.runActivity(named: "items.count > 0") { _ in
                let expectation = self.expectation(description: "page > 0")
                QiitaAPIClient().send(QiitaAPI.SearchItems(page: 1))
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure:
                            XCTFail()
                        case .finished:
                            expectation.fulfill()
                        }
                    }) { items in
                        XCTAssertGreaterThan(items.count, 0)
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
    }
    
    func testPerPageRequest() {
        XCTContext.runActivity(named: "when perPage parameter is 0") { _ in
            XCTContext.runActivity(named: "error response") { _ in
                let expectation = self.expectation(description: "perPage is 0")
                QiitaAPIClient().send(QiitaAPI.SearchItems(perPage: 0))
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            switch error {
                            case .apiError(let response):
                                print(response)
                                XCTAssertTrue(true)
                                expectation.fulfill()
                            default:
                                XCTFail()
                            }
                        case .finished:
                            XCTFail()
                        }
                    }) { items in
                        XCTFail()
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
        
        XCTContext.runActivity(named: "when perPage parameter > 0") { _ in
            XCTContext.runActivity(named: "items.count > 0") { _ in
                let expectation = self.expectation(description: "perPage > 0")
                QiitaAPIClient().send(QiitaAPI.SearchItems(perPage: 1))
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure:
                            XCTFail()
                        case .finished:
                            expectation.fulfill()
                        }
                    }) { items in
                        XCTAssertGreaterThan(items.count, 0)
                }.store(in: &cancellables)
                self.wait(for: [expectation], timeout: 3)
            }
        }
    }
}
