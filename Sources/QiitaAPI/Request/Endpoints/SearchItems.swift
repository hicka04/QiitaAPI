//
//  SearchItems.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation
import APIKit

public struct SearchItems: QiitaRequest {
    
    public typealias Response = [Item]
    
    public let method: HTTPMethod = .get
    
    public var path: String = "/api/v2/items"
    
    public init() {}
}
