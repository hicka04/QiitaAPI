//
//  QiitaRequest.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation

public protocol QiitaRequest {
    
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [Parameter] { get }
}

public extension QiitaRequest {
    
    var baseURL: URL {
        URL(string: "https://qiita.com/")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var urlRequest = URLRequest(url: url)
        switch method {
        case .get:
        components?.percentEncodedQueryItems = parameters.compactMap { $0.convertToQueryItem() }
        //      case .post:
        //        urlRequest.httpBody = parameters.convertToHttpBody()
        }

        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
            (200..<300).contains(statusCode) else {
          throw try decoder.decode(ErrorResponse.self, from: data)
        }

        return try decoder.decode(Response.self, from: data)
    }
}

private extension Parameter {
    
    func convertToQueryItem() -> URLQueryItem? {
        guard let value = value else { return nil }
        return .init(name: name,
                     value: value.addingPercentEncoding(withAllowedCharacters: .alphanumerics))
    }
}

//private extension Array where Element == Parameter {
//    
//    func convertToHttpBody() -> Data? {
//        self.map({ "\($0.name)=\($0.value)" }).joined(separator: "&").data(using: .utf8)
//    }
//}
