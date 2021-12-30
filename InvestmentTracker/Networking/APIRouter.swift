//
//  APIRouter.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/24/21.
//

import Foundation

enum APIRouter: APIConfiguration {
    
    case getNews(topic: String, date: String, page: Int)
    case getImage(url: String)
    case queryCrypto(asset: String)
    case getMonthlyData(asset: String)
    
    
    var baseURL: String {
        switch self {
        case .getNews:
            return "https://newsapi.org/"
        default: return "https://alpha-vantage.p.rapidapi.com/"
        }
    }
    
    
    var path: String {
        switch self {
        case .getNews:
            return "v2/everything"
        default: return "query"
        }
    }
    
    
    var method: HTTPMethod {
        .get
    }
    
    
    var parameters: RequestParams {
        switch self {
            
        case .getNews(let topic, let date, let page):
            return .query([
                "q": topic,
                "from": date,
                "sortBy": "popularity",
                "pageSize": "20",
                "page": String(page),
                "apiKey": "bc0556bf8d8a43d7806e669f113965c6"
            ])
        case .queryCrypto(asset: let asset):
            return .query([
                "from_currency": asset,
                "function": "CURRENCY_EXCHANGE_RATE",
                "to_currency": "USD"
            ])
        case .getMonthlyData(asset: let asset):
            return .query([
                "market": "USD",
                "symbol": asset,
                "function": "DIGITAL_CURRENCY_DAILY"
            ])
        case .getImage(let url):
            return .completeUrl(url: url)
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .queryCrypto, .getMonthlyData:
            urlRequest.setValue(ContentType.host.rawValue, forHTTPHeaderField: HTTPHeaderField.rapidAPIHost.rawValue)
            urlRequest.setValue(ContentType.key.rawValue, forHTTPHeaderField: HTTPHeaderField.rapidAPIKey.rawValue)
        default: break
        }
        
        switch parameters {
        case .path(let params):
            var queryUrl = urlRequest.url
            params.forEach { pair in
                queryUrl?.appendPathComponent("\(pair.value)")
            }
        case .query(let params):
            let queryParams = params.map { pair in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .completeUrl(let url):
            urlRequest.url = URL(string: url)
        }
        
        return urlRequest
    }
}

