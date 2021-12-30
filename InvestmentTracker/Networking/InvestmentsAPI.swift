//
//  InvestmentsAPI.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/24/21.
//

import Foundation



protocol InvestmentsAPI {
    func news(_ route: APIRouter) async -> (Result<Request, APIError>)
    func getImage(_ route: APIRouter) async -> (Result<Data, APIError>)
    func cryptoQuery(_ route: APIRouter) async -> (Result<ExchangeRate, APIError>)
    func getDayCandles(_ route: APIRouter) async -> (Result<DayData, APIError>)
}

extension InvestmentsAPI {
    func news(_ route: APIRouter) async -> (Result<Request, APIError>) {
        await news(route)
    }
    
    func cryptoQuery(_ route: APIRouter) async -> (Result<ExchangeRate, APIError>) {
        await cryptoQuery(route)
    }
    
    func getDayCandles(_ route: APIRouter) async -> (Result<DayData, APIError>) {
        await getDayCandles(route)
    }
    
    func getImage(_ route: APIRouter) async -> (Result<Data, APIError>) {
        await getImage(route)
    }
}


extension InvestmentsService: InvestmentsAPI {
    func getImage(_ route: APIRouter) async -> (Result<Data, APIError>) {
        await dataRequest(route)
    }
    
    func news(_ route: APIRouter) async -> (Result<Request, APIError>)  {
        await request(route)
    }
    
    func cryptoQuery(_ route: APIRouter) async -> (Result<ExchangeRate, APIError>) {
        await request(route)
    }
    
    func getDayCandles(_ route: APIRouter) async -> (Result<DayData, APIError>) {
        await request(route)
    }
}
