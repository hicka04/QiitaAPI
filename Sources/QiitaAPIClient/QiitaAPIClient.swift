//
//  QiitaAPIClient.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation
import Combine

public final class QiitaAPIClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    public func send<Request: QiitaRequest>(_ request: Request) -> AnyPublisher<Request.Response, QiitaClientError> {
        let urlRequest = request.buildURLRequest()
        print(urlRequest.url ?? "")
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { QiitaClientError.connectionError($0) }
            .tryMap { try request.response(from: $0.data, urlResponse: $0.response) }
            .mapError {
                if let errorResponse = $0 as? ErrorResponse {
                    return QiitaClientError.apiError(errorResponse)
                } else {
                    return QiitaClientError.responseParseError($0)
                }
            }
            .eraseToAnyPublisher()
    }
}
