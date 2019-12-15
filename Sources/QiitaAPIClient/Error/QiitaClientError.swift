//
//  QiitaAPIError.swift
//  
//
//  Created by hicka04 on 2019/12/15.
//

import Foundation

public enum QiitaClientError: Error {
    
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(ErrorResponse)
}
