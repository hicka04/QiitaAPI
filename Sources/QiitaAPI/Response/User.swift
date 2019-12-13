//
//  User.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public struct User: Decodable {
    
    let id: ID
    let profileImageUrl: URL
}

extension User {
    
    public struct ID: RawRepresentable, Decodable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
