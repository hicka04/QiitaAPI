//
//  User.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public struct User: Decodable, Identifiable, Equatable {
    
    public let id: ID
    public let name: String
    public let description: String?
    public let location: String?
    public let organization: String?
    public let profileImageUrl: URL
}

extension User {
    
    public struct ID: RawRepresentable, Decodable, Hashable, Equatable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
