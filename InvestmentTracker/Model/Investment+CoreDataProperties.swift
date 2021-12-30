//
//  Investment+CoreDataProperties.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/24/21.
//
//

import Foundation
import CoreData
import SwiftUI


extension Investment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Investment> {
        return NSFetchRequest<Investment>(entityName: "Investment")
    }

    @NSManaged public var buyPrice: Double
    @NSManaged public var currencyCode: String?
    @NSManaged public var currencyName: String?
    @NSManaged public var exchangeCode: String?
    @NSManaged public var exchangeName: String?
    @NSManaged public var exchangeRate: Double
    @NSManaged public var lastRefreshed: String?
    @NSManaged public var id: UUID?
    @NSManaged public var shares: Double
    @NSManaged public var periods: Int16
    @NSManaged public var dayChangePrice: Double
    
    var code: String {
        currencyCode ?? "N/a"
    }
    
    var name: String {
        currencyName ?? "N/a"
    }
    
    var wrappedExchangeCode: String {
        exchangeCode ?? "N/a"
    }
    
    var wrappedExchangeName: String {
        exchangeName ?? "N/a"
    }
    
    var wrappedID: UUID {
        id!
    }
    
    var refreshed: Date {
        if let date = lastRefreshed?.toDate(.stock) {
            return date
        } else {
            return Date()
        }
    }
    
    var refreshedToday: Bool {
        refreshed.toString(.query) == Date().toString(.query)
    }

    
    var income: Double {
        let income = (exchangeRate - buyPrice) * shares
        let result = round(100 * income) / 100
        return result
    }
    
    func updatePrices(with stock: Stock) {
        exchangeRate = Double(stock.exchangeRate) ?? 0
        lastRefreshed = stock.lastRefreshed
    }
    
    var currentPriceString: String {
        String(exchangeRate).croppedPrice?.priceWithDollar ?? "N/a"
    }
    
    var buyPriceString: String {
        String(buyPrice).croppedPrice?.priceWithDollar ?? "N/a"
    }
    
    var sharesString: String {
        String(shares).croppedPrice ?? "N/a"
    }
    
    var incomeString: String {
        String(income).croppedPrice?.priceWithDollar ?? "N/a"
    }
    
    var dayChangePriceString: String {
        String(dayChangePrice).croppedPrice?.priceWithDollar ?? "N/a"
    }
}

extension Investment : Identifiable {

}

extension Investment {
    convenience init(from stock: Stock) {
        self.init(context: PersistenceManager.shared.viewContext)
        buyPrice = stock.buyPrice
        currencyCode = stock.currencyCode
        currencyName = stock.currencyName
        exchangeCode = stock.exchangeCode
        exchangeName = stock.exchangeName
        exchangeRate = Double(stock.exchangeRate) ?? 0
        lastRefreshed = stock.lastRefreshed
        id = stock.id
        shares = stock.shares
        periods = 1
        dayChangePrice = 0
    }
}
