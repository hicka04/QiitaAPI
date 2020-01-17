//
//  Dummying.swift
//  
//
//  Created by hicka04 on 2020/01/15.
//

import Foundation

#if DEBUG
public protocol Dummying {
    
    static func dummy() -> Self
}
#endif
