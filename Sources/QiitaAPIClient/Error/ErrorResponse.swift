//
//  ErrorResponse.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public struct ErrorResponse: Error, Codable, Equatable {
    
    public let message: String
    public let type: String
    
    init(message: String, type: String) {
        self.message = message
        self.type = type
    }
}
