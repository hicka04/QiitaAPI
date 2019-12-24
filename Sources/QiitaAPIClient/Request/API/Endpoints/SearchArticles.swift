//
//  SearchArticles.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public extension QiitaAPI {

    struct SearchArticles: QiitaRequest, Paginatable {
        
        public typealias Response = [Article]
        
        public let method: HTTPMethod = .get
        
        public let path: String = "api/v2/items"
        
        public var parameters: [Parameter] {
            [
                Parameter(name: "query", value: query),
                pageParameter,
                perPageParameter
            ]
        }
        
        let query: String?
        let page: Int?
        let perPage: Int?
        
        public init(query: String? = nil,
                    page: Int? = nil,
                    perPage: Int? = nil) {
            self.query = query
            self.page = page
            self.perPage = perPage
        }
    }
}
