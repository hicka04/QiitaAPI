//
//  ParameterTests.swift
//  
//
//  Created by hicka04 on 2019/12/17.
//

import XCTest
@testable import QiitaAPIClient

class ParameterTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testConvertToQueryItem() {
        XCTContext.runActivity(named: "when value == nil") { _ in
            let parameter = Parameter(name: "test", value: Optional<String>.none)
            
            XCTContext.runActivity(named: "return nil") { _ in
                XCTAssertNil(parameter.convertToQueryItem())
            }
        }
        
        XCTContext.runActivity(named: "when value != nil") { _ in
            let parameter = Parameter(name: "test", value: "test")
            
            XCTContext.runActivity(named: "return not nil") { _ in
                XCTAssertNotNil(parameter.convertToQueryItem())
            }
        }
    }
}
