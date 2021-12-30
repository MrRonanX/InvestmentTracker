//
//  StockDayData.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/25/21.
//

import SwiftUI

struct DayData: Codable {
    let metadata: Metadata?
    var daySeries: [String: DayCandle]
    
    enum CodingKeys: String, CodingKey {
        case metadata = "Meta Data"
        case daySeries = "Time Series (Digital Currency Daily)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metadata =  try container.decodeIfPresent(Metadata.self, forKey: .metadata)
        daySeries = try container.decode(Dictionary<String, DayCandle>.self, forKey: .daySeries)
    }
}

struct Metadata: Codable {
    let information:    String
    let currencyCode:   String
    let currencyName:   String
    let marketCode:     String
    let marketName:     String
    let lastRefreshed:  String
    let timeZone:       String

    enum CodingKeys: String, CodingKey {

        case information    = "1. Information"
        case currencyCode   = "2. Digital Currency Code"
        case currencyName   = "3. Digital Currency Name"
        case marketCode     = "4. Market Code"
        case marketName     = "5. Market Name"
        case lastRefreshed  = "6. Last Refreshed"
        case timeZone       = "7. Time Zone"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        information =   try container.decodeIfPresent(String.self, forKey: .information) ?? ""
        currencyCode =  try container.decodeIfPresent(String.self, forKey: .currencyCode) ?? ""
        currencyName =  try container.decodeIfPresent(String.self, forKey: .currencyName) ?? ""
        marketCode =    try container.decodeIfPresent(String.self, forKey: .marketCode) ?? ""
        marketName =    try container.decodeIfPresent(String.self, forKey: .marketName) ?? ""
        lastRefreshed = try container.decodeIfPresent(String.self, forKey: .lastRefreshed) ?? ""
        timeZone =      try container.decodeIfPresent(String.self, forKey: .timeZone) ?? ""
    }
}


struct DayCandle {
   
    let id =        UUID()
    let open:       String
    let high:       String
    let low:        String
    let close:      String
    let volume:     String
    let marketCap:  String
}

extension DayCandle {
    
    var openPrice: Double {
        Double(self.open) ?? 0
    }
    
    var closePrice: Double {
        Double(close) ?? 0
    }
    
    var highPrice: Double {
        Double(high) ?? 0
    }
    
    var lowPrice: Double {
        Double(low) ?? 0
    }
    
    var topBodyPrice: Double {
        max(openPrice, closePrice)
    }
    
    var bottomBodyPrice: Double {
        min(openPrice, closePrice)
    }
    
    var candleColor: Color {
        closePrice > openPrice ? .green : .red
    }
}

extension DayCandle: Identifiable, Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case open       = "1b. open (USD)"
        case high       = "2b. high (USD)"
        case low        = "3b. low (USD)"
        case close      = "4b. close (USD)"
        case volume     = "5. volume"
        case marketCap  = "6. market cap (USD)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        open        = try container.decodeIfPresent(String.self, forKey: .open) ?? ""
        high        = try container.decodeIfPresent(String.self, forKey: .high) ?? ""
        low         = try container.decodeIfPresent(String.self, forKey: .low) ?? ""
        close       = try container.decodeIfPresent(String.self, forKey: .close) ?? ""
        volume      = try container.decodeIfPresent(String.self, forKey: .volume) ?? ""
        marketCap   = try container.decodeIfPresent(String.self, forKey: .marketCap) ?? ""
    }
}
