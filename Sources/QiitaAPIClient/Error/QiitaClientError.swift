//
//  QiitaAPIError.swift
//  
//
//  Created by hicka04 on 2019/12/15.
//

import Foundation

public enum QiitaClientError: Error, Equatable {
    
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(ErrorResponse)
    
    public static func == (lhs: QiitaClientError, rhs: QiitaClientError) -> Bool {
        switch (lhs, rhs) {
        case (.connectionError(let lhsError), .connectionError(let rhsError)),
             (.responseParseError(let lhsError), .responseParseError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.apiError(let lhsErrorResponse), .apiError(let rhsErrorResponse)):
            return lhsErrorResponse == rhsErrorResponse
        default:
            return false
        }
    }
}
