//
//  APICommon.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/24/21.
//

import Foundation

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw APIError.invalidSearchQuery(self) }
        return url
    }
}

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    var urlRequest: URLRequest? { try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest { self }
}

enum HTTPMethod: String {
    case get = "GET"
}

enum HTTPHeaderField: String {
    case rapidAPIHost = "x-rapidapi-host"
    case rapidAPIKey = "x-rapidapi-key"
}

enum ContentType: String {
    case host = "alpha-vantage.p.rapidapi.com"
    case key = "789e32879fmsh0a1cd2beb310871p19f76bjsn0b825284fdab"
}

public typealias Parameters = [String: Any]

enum RequestParams {
    case path(_:Parameters)
    case query(_:Parameters)
    case completeUrl(url: String)
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}
