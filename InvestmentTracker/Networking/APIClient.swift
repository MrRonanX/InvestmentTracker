//
//  APIClient.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/24/21.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ route: APIRouter) async -> (Result<T?, APIError>)
}

struct InvestmentsService: APIClientProtocol {

    static let shared = InvestmentsService()
    
    private init() {}
    
    private let session = URLSession.shared
    
    func request<T>(_ route: APIRouter) async -> (Result<T, APIError>) where T : Decodable {
        guard let urlRequest = route.urlRequest else {
            return .failure(.invalidURLRequest)
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.tooManyRequest)
            }
            
            let request = try JSONDecoder().decode(T.self, from: data)
            return .success(request)
        } catch {
            return .failure(.unableToComplete)
        }
    }
    
    func dataRequest(_ route: APIRouter) async -> (Result<Data, APIError>) {
        guard let urlRequest = route.urlRequest else {
            return .failure(.invalidURLRequest)
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.tooManyRequest)
            }
            
            return .success(data)
        } catch {
            return .failure(.unableToComplete)
        }
    }
}
