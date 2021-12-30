//
//  StockModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/23/21.
//

import Foundation

struct ExchangeRate: Codable {
    let exchangeRate: Stock?

    enum CodingKeys: String, CodingKey {
        case exchangeRate = "Realtime Currency Exchange Rate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        exchangeRate = try values.decodeIfPresent(Stock.self, forKey: .exchangeRate)
    }
}

struct Stock: Codable, Identifiable {
    let id = UUID()
    let currencyCode: String
    let currencyName: String
    let exchangeCode: String
    let exchangeName: String
    var exchangeRate: String
    let lastRefreshed: String
    let timeZone: String
    let bidPrice: String
    let askPrice: String
    var buyDate = Date()
    var buyPrice = Double()
    var shares = Double()
    var action = "Query"
    
    var dolarPrice: String {
        exchangeRate.croppedPrice?.priceWithDollar ?? "N/a"
    }
}

// MARK: - Init Methods

extension Stock {
    enum CodingKeys: String, CodingKey {

        case currencyCode = "1. From_Currency Code"
        case currencyName = "2. From_Currency Name"
        case exchangeCode = "3. To_Currency Code"
        case exchangeName = "4. To_Currency Name"
        case exchangeRate = "5. Exchange Rate"
        case lastRefreshed = "6. Last Refreshed"
        case timeZone = "7. Time Zone"
        case bidPrice = "8. Bid Price"
        case askPrice = "9. Ask Price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode) ?? ""
        currencyName = try values.decodeIfPresent(String.self, forKey: .currencyName) ?? ""
        exchangeCode = try values.decodeIfPresent(String.self, forKey: .exchangeCode) ?? ""
        exchangeName = try values.decodeIfPresent(String.self, forKey: .exchangeName) ?? ""
        exchangeRate = try values.decodeIfPresent(String.self, forKey: .exchangeRate) ?? ""
        lastRefreshed = try values.decodeIfPresent(String.self, forKey: .lastRefreshed) ?? ""
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone) ?? ""
        bidPrice = try values.decodeIfPresent(String.self, forKey: .bidPrice) ?? ""
        askPrice = try values.decodeIfPresent(String.self, forKey: .askPrice) ?? ""
        action = "Add"
    }
    
    
    init(currencyCode: String = "",
         currencyName: String = "",
         exchangeCode: String = "USD",
         exchangeName: String = "",
         exchangeRate: String = "",
         lastRefreshed: String = "",
         timeZone: String = "",
         bidPrice: String = "",
         askPrice: String = "") {
        self.currencyCode = currencyCode
        self.currencyName = currencyName
        self.exchangeCode = exchangeCode
        self.exchangeName = exchangeName
        self.exchangeRate = exchangeRate
        self.lastRefreshed = lastRefreshed
        self.timeZone =  timeZone
        self.bidPrice = bidPrice
        self.askPrice = askPrice
    }
}
