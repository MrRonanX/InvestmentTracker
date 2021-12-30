//
//  String + ext.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/19/21.
//

import Foundation

extension String {
    
    enum DateFormat: String {
        case news = "yyyy-MM-dd'T'HH:mm:ssZ"
        case stock = "yyyy-MM-dd HH:mm:ss"
    }

    func toDate(_ format: DateFormat = .news) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
    
    var priceWithDollar: String {
        guard self != "0" && self != "" else { return "" }
        return "$"+self
    }
    
    var croppedPrice: String? {
        guard let num = Double(self) else { return "0" }
        
        guard num > 1 else {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 7
            numberFormatter.minimumIntegerDigits = 1
            return numberFormatter.string(for: num)
        }
        
        return String(format: "%.2f", num)
    }
    
    var formattedPrice: String {
        var formattedPrice = self.replacingOccurrences(of: ",", with: ".")
        let numberOfDots = formattedPrice.components(separatedBy: ".").count - 1
        if numberOfDots > 1 {
            guard let i = formattedPrice.endIndex(of: ".") else { return formattedPrice }
            formattedPrice.remove(at: i)
            return formattedPrice
        }
        return formattedPrice
    }
}
