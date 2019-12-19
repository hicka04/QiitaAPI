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
    private var cancellables: Set<AnyCancellable> = []
    
    public init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    public func send<Request: QiitaRequest>(_ request: Request) -> Deferred<Future<Request.Response, QiitaClientError>> {
        let urlRequest = request.buildURLRequest()
        print(urlRequest.url ?? "")
        
        let qiitaResponsePublisher = session.dataTaskPublisher(for: urlRequest)
            .mapError { QiitaClientError.connectionError($0) }
            .tryMap { try request.response(from: $0.data, urlResponse: $0.response)}
            .mapError { error -> QiitaClientError in
                if let errorResponse = error as? ErrorResponse {
                    return QiitaClientError.apiError(errorResponse)
                } else {
                    return QiitaClientError.responseParseError(error)
                }
            }
        
        return Deferred {
            Future { promise in
                qiitaResponsePublisher.sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    promise(.success(response))
                })
                .store(in: &self.cancellables)
            }
        }
    }
}
