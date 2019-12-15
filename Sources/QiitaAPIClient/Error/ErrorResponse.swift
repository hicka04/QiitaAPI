//
//  ErrorResponse.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public struct ErrorResponse: Decodable, Error {
    
    let message: String
    let type: String
}
