//
//  DummyingUser.swift
//  
//
//  Created by hicka04 on 2020/01/16.
//

import Foundation

#if DEBUG
extension User: Dummying {
    
    public static func dummy() -> User {
        User(id: ID.dummy(),
             name: "UserName",
             description: "description",
             location: "Japan",
             organization: "organization",
             profileImageUrl: URL(string: "https://qiita-image-store.s3.amazonaws.com/0/80832/profile-images/1540424506")!)
    }
}

extension User.ID: Dummying {
    
    public static func dummy() -> User.ID {
        User.ID(rawValue: "hicka04")
    }
}
#endif
