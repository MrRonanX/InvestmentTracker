//
//  Date + ext.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/19/21.
//

import Foundation

extension Date {
    
    enum DateFormat: String {
        case query = "yyyy-MM-dd"
        case list  = "E, MMM d"
    }

    
    func toString(_ format: DateFormat = .list) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format.rawValue
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    
    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}
