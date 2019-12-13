//
//  QiitaRequest.swift
//  
//
//  Created by hicka04 on 2019/12/12.
//

import Foundation
import APIKit

public protocol QiitaRequest: Request {}

public extension QiitaRequest {
    
    var baseURL: URL {
        URL(string: "https://qiita.com/")!
    }
}

public extension QiitaRequest where Response: Decodable {
    
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        guard let response = try? decoder.decode(Response.self, from: data) else {
            throw ResponseError.unexpectedObject(try decoder.decode(ErrorResponse.self, from: data))
        }
        
        return response
    }
}

public final class DecodableDataParser: DataParser {
    public var contentType: String? {
        return "application/json"
    }

    public func parse(data: Data) throws -> Any {
        return data
    }
}
