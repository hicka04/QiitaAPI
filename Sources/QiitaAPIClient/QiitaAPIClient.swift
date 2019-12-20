//
//  QiitaAPIClient.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation
import Combine

public protocol QiitaAPIRequestable: AnyObject {
    
    @available(iOS, deprecated: 13.0, renamed: "send")
    @available(OSX, deprecated: 10.15, renamed: "send")
    func send<Request: QiitaRequest>(_ request: Request,
                                     completion: @escaping (Result<Request.Response, QiitaClientError>) -> Void)
    
    @available(OSX 10.15, iOS 13.0, *)
    func send<Request: QiitaRequest>(_ request: Request) -> Deferred<Future<Request.Response, QiitaClientError>>
}

public final class QiitaAPIClient: QiitaAPIRequestable {
    
    private let session: URLSession
    private var cancellables: Set<AnyCancellable> = []
    
    public init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    @available(iOS, deprecated: 13.0, renamed: "send")
    @available(OSX, deprecated: 10.15, renamed: "send")
    public func send<Request: QiitaRequest>(_ request: Request,
                                            completion: @escaping (Result<Request.Response, QiitaClientError>) -> Void) {
        let urlRequest = request.buildURLRequest()
        print(urlRequest.url ?? "")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            switch (data, response, error) {
            case (_, _, let error?):
                completion(.failure(.connectionError(error)))
                
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(.success(response))
                } catch let error as ErrorResponse {
                    completion(.failure(.apiError(error)))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
                
            default:
                fatalError("Invalid response combination")
            }
        }
        
        task.resume()
    }
    
    @available(OSX 10.15, iOS 13.0, *)
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
