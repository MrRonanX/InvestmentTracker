//
//  YellowButtonStyle.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/19/21.
//

import SwiftUI

struct YellowButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(width: 280, height: 44, alignment: .center)
            .frame(maxWidth: .infinity)
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
            .background(configuration.isPressed ? Color.yellow.opacity(0.5) : Color.yellow)
            .cornerRadius(10)
    }
}
