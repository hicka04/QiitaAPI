//
//  SearchItemsTests.swift
//  
//
//  Created by hicka04 on 2019/12/13.
//

import Quick
import Nimble
import QiitaAPI

class SearchItemsTests: QuickSpec {
    
    override func spec() {
        describe("SearchItems") {
            context("when response OK") {
                it("items.count > 0") {
                    waitUntil { done in
                        QiitaAPI().send(SearchItems()) { result in
                            switch result {
                            case .success(let items):
                                expect(items.count) > 0
                                done()
                            case .failure:
                                fail()
                            }
                        }
                    }
                }
            }
        }
    }
}
