//
//  QiitaAPIClient.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public final class QiitaAPIClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
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
}
