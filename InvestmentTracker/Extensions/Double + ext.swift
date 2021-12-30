//
//  Double + ext.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import Foundation

extension Double {
    func string(maximumFractionDigits: Int = 7) -> String {
            let s = String(format: "%.\(maximumFractionDigits)f", self)
            var offset = -maximumFractionDigits - 1
            for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
                if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                    offset = i
                    break
                }
            }
            return String(s[..<s.index(s.endIndex, offsetBy: offset)])
        }
}
