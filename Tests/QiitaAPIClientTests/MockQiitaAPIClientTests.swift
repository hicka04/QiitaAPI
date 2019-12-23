//
//  MockQiitaAPIClientTests.swift
//  
//
//  Created by hicka04 on 2019/12/20.
//

import Foundation
import Combine
import XCTest
@testable import QiitaAPIClient

class MockQiitaAPIClientTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testMock() {
        XCTContext.runActivity(named: "when mock client given success") { _ in
            let request = MockRequest()
            let stubResponseResult: Result<MockRequest.Response, QiitaClientError> = .success("success!")
            let api = MockQiitaAPIClient<MockRequest>(result: stubResponseResult)
            
            XCTContext.runActivity(named: "return success response") { _ in
                let closureExpectation = self.expectation(description: "closure")
                api.send(request) { completion in
                    XCTAssertEqual(completion, stubResponseResult)
                    closureExpectation.fulfill()
                }
                
                let combineExpectation = self.expectation(description: "combine")
                api.send(request)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure:
                            XCTFail()
                        case .finished:
                            combineExpectation.fulfill()
                        }
                    }) { response in
                        switch stubResponseResult {
                        case .success(let stubResponse):
                            XCTAssertEqual(response, stubResponse)
                        case .failure:
                            XCTFail()
                        }
                    }.store(in: &cancellables)
                
                wait(for: [closureExpectation, combineExpectation], timeout: 3)
            }
        }
        
        XCTContext.runActivity(named: "when mock client given connectionError") { _ in
            let request = MockRequest()
            let stubResponseResult: Result<MockRequest.Response, QiitaClientError> = .failure(.connectionError(NSError(domain: "hicka04/QiitaAPIClientTests", code: -1, userInfo: nil)))
            let api = MockQiitaAPIClient<MockRequest>(result: stubResponseResult)
            
            XCTContext.runActivity(named: "return connectionError response") { _ in
                let closureExpectation = self.expectation(description: "closure")
                api.send(request) { completion in
                    XCTAssertEqual(completion, stubResponseResult)
                    closureExpectation.fulfill()
                }
                
                let combineExpectation = self.expectation(description: "combine")
                api.send(request)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            switch stubResponseResult {
                            case .success:
                                XCTFail()
                            case .failure(let stubError):
                                XCTAssertEqual(error, stubError)
                                combineExpectation.fulfill()
                            }
                        case .finished:
                            break
                        }
                    }) { response in
                        XCTFail()
                    }.store(in: &cancellables)
                
                wait(for: [closureExpectation, combineExpectation], timeout: 3)
            }
        }
        
        XCTContext.runActivity(named: "when mock client given responseParseError") { _ in
            let request = MockRequest()
            let stubResponseResult: Result<MockRequest.Response, QiitaClientError> = .failure(.responseParseError(NSError(domain: "hicka04/QiitaAPIClientTests", code: -1, userInfo: nil)))
            let api = MockQiitaAPIClient<MockRequest>(result: stubResponseResult)
            
            XCTContext.runActivity(named: "return responseParseError response") { _ in
                let closureExpectation = self.expectation(description: "closure")
                api.send(request) { completion in
                    XCTAssertEqual(completion, stubResponseResult)
                    closureExpectation.fulfill()
                }
                
                let combineExpectation = self.expectation(description: "combine")
                api.send(request)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            switch stubResponseResult {
                            case .success:
                                XCTFail()
                            case .failure(let stubError):
                                XCTAssertEqual(error, stubError)
                                combineExpectation.fulfill()
                            }
                        case .finished:
                            break
                        }
                    }) { response in
                        XCTFail()
                    }.store(in: &cancellables)
                
                wait(for: [closureExpectation, combineExpectation], timeout: 3)
            }
        }
        
        XCTContext.runActivity(named: "when mock client given connectionError") { _ in
            let request = MockRequest()
            let stubResponseResult: Result<MockRequest.Response, QiitaClientError> = .failure(.apiError(ErrorResponse(message: "hoge", type: "fuga")))
            let api = MockQiitaAPIClient<MockRequest>(result: stubResponseResult)
            
            XCTContext.runActivity(named: "return connectionError response") { _ in
                let closureExpectation = self.expectation(description: "closure")
                api.send(request) { completion in
                    XCTAssertEqual(completion, stubResponseResult)
                    closureExpectation.fulfill()
                }
                
                let combineExpectation = self.expectation(description: "combine")
                api.send(request)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            switch stubResponseResult {
                            case .success:
                                XCTFail()
                            case .failure(let stubError):
                                XCTAssertEqual(error, stubError)
                                combineExpectation.fulfill()
                            }
                        case .finished:
                            break
                        }
                    }) { response in
                        XCTFail()
                    }.store(in: &cancellables)
                
                wait(for: [closureExpectation, combineExpectation], timeout: 3)
            }
        }
    }
}

private struct MockRequest: QiitaRequest {
    
    typealias Response = String
    
    let path: String = "a"
    
    let method: HTTPMethod = .get
    
    let parameters: [Parameter] = []
}
