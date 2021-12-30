//
//  SearchButton.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/19/21.
//

import SwiftUI

struct ITButton: View {
    
    var text = "Search"
    var color: Color = .blue
    var action: () -> ()
    
    var body: some View {
        Button(action: executeQuery) {
            Text(text)
                .font(.headline)
                .foregroundColor(Color(UIColor.systemBackground))
                .frame(width: 280, height: 44)
                .background(color)
                .cornerRadius(10)
        }
    }
    
    func executeQuery() {
        action()
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        ITButton { print("Search executed")}
    }
}
