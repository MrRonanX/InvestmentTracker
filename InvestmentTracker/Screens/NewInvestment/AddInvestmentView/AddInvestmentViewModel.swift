//
//  AddInvestmentViewModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/24/21.
//

import Foundation

final class AddInvestmentViewModel: ObservableObject {
    @Published var price: String {
        didSet {
            let formattedPrice = price.formattedPrice
            if formattedPrice.prefix(1) != "$" || price != formattedPrice {
                price = formattedPrice.prefix(1) == "$" ? formattedPrice : "$" + formattedPrice
            }
        }
    }
    
    @Published var shares = 0.0
    @Published var buyDate = Date()
    
    var stock: Stock
    var currencyName: String {
        "\(stock.currencyName) - \(stock.currencyCode)"
    }
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var priceWithoutDollarSign: Double? {
        var localPrice = price
        localPrice.removeFirst()
        return Double(localPrice.replacingOccurrences(of: ",", with: "."))
    }
    
    var validInput: Bool {
        guard priceWithoutDollarSign ?? 0 > 0, shares  > 0, buyDate < Date() else { return false }
        return true
    }
    
    init(stock: Stock) {
        price = stock.dolarPrice
        self.stock = stock
    }
    
    func createInvestmentRecord() -> Bool {
        guard let unwrappedPrice = priceWithoutDollarSign, shares > 0, let latestPrice = Double(stock.exchangeRate) else { return false }
        stock.buyPrice = unwrappedPrice
        stock.shares = shares
        stock.buyDate = buyDate
        let allInvestments = PersistenceManager.shared.getAllInvestments()
        for investment in allInvestments where investment.code == stock.currencyCode {
            investment.periods += 1
            investment.shares += shares
            investment.buyPrice = (investment.buyPrice + unwrappedPrice) / 2
            investment.exchangeRate = latestPrice
            PersistenceManager.shared.save()
            return true
        }
        
        let _ = Investment(from: stock)
        PersistenceManager.shared.save()
        return true
    }
}
