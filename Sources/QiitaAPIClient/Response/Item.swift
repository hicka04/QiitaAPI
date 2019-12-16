//
//  Item.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public struct Item: Decodable, Identifiable {
    
    public let id: ID
    public let title: String
    public let tags: [Tag]
    public let url: URL
    public let createdAt: Date
    public let updatedAt: Date
    public let likesCount: Int
    public let user: User
}

extension Item {
    
    public struct ID: RawRepresentable, Decodable, Hashable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    public struct Tag: Decodable {
        
        public let name: String
    }
}
