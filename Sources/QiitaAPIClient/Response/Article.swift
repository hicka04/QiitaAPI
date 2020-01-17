//
//  Article.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public struct Article: Codable, Identifiable, Equatable {
    
    public let id: ID
    public let title: String
    public let tags: [Tag]
    public let body: String
    public let renderedBody: String
    public let url: URL
    public let createdAt: Date
    public let updatedAt: Date
    public let likesCount: Int
    public let user: User
}

extension Article {
    
    public struct ID: RawRepresentable, Codable, Hashable, Equatable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    public struct Tag: Codable, Equatable {
        
        public let name: String
    }
}
