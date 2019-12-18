//
//  Parameter.swift
//  
//
//  Created by hicka04 on 2019/12/15.
//

import Foundation

public struct Parameter {

    let name: String
    let value: String?
    
    init<Value: LosslessStringConvertible>(name: String, value: Value?) {
        self.name = name
        if let value = value {
            self.value = String(value)
        } else {
            self.value = nil
        }
    }

    func convertToQueryItem() -> URLQueryItem? {
        guard let value = value else { return nil }
        return .init(name: name,
                     value: value.addingPercentEncoding(withAllowedCharacters: .alphanumerics))
    }
}
