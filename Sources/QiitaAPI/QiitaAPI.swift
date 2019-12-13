//
//  QiitaAPI.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation
import APIKit

public final class QiitaAPI {
    
    public init () {}
    
    public func send<Request: QiitaRequest>(_ request: Request,
                                            completion: @escaping (Result<Request.Response, SessionTaskError>) -> Void) {
        Session.send(request) { result in
            completion(result)
        }
    }
}
