//
//  Paginatable.swift
//  
//
//  Created by hicka04 on 2019/12/17.
//

import Foundation

protocol Paginatable {
    
    var page: Int? { get }
    var perPage: Int? { get }
}

extension Paginatable {
    
    var pageParameter: Parameter {
        Parameter(name: "page", value: page)
    }
    
    var perPageParameter: Parameter {
        Parameter(name: "per_page", value: perPage)
    }
}
