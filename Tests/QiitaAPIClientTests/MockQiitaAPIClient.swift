//
//  MockQiitaAPIClient.swift
//  
//
//  Created by hicka04 on 2019/12/20.
//

import Foundation
import Combine
import QiitaAPIClient

final class MockQiitaAPIClient<T: QiitaRequest>: QiitaAPIRequestable {
    
    let result: Result<T.Response, QiitaClientError>
    
    init(result: Result<T.Response, QiitaClientError>) {
        self.result = result
    }
    
    func send<Request: QiitaRequest>(_ request: Request,
                                     completion: @escaping (Result<Request.Response, QiitaClientError>) -> Void) {
        completion(result as! Result<Request.Response, QiitaClientError>)
    }
    
    func send<Request: QiitaRequest>(_ request: Request) -> Deferred<Future<Request.Response, QiitaClientError>> {
        Deferred {
            Future { promise in
                switch self.result {
                case .success(let response):
                    promise(.success(response as! Request.Response))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}
