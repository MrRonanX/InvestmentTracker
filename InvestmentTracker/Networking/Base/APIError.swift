//
//  APIError.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/19/21.
//

import Foundation

enum APIError: Error {
    
    case invalidSearchQuery(String?)
    case invalidURLRequest
    case unableToComplete
    case invalidResponse
    case invalidData
    case errorFetchingData
    
    case tooManyRequest
    case wrongCurrency
}

extension APIError {
    var description: String {
        switch self {
        case .invalidSearchQuery: return "This search query created an invalid request. Please try again."
        case .invalidURLRequest: return "This request in invalid. Please try again"
        case .unableToComplete: return "Please check your internet connection."
        case .invalidResponse: return "Invalid response from server. Please try again."
        case .invalidData: return "The data received from the server was invalid. Please try again."
        case .errorFetchingData: return "There was an error fetching data"
        case .tooManyRequest: return "Current API plan allows only 5 requests in a minute. Please, wait a bit before making another one."
        case .wrongCurrency: return "Crypto with this query wasn't found. Try another one."
        }
    }
}
