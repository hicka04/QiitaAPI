//
//  ErrorResponse.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

struct ErrorResponse: Decodable {
    
    let message: String
    let type: String
}
