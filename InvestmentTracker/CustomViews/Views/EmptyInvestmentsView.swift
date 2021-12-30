//
//  EmptyInvestmentsView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/27/21.
//

import SwiftUI

struct EmptyInvestmentsView: View {
    
    @Binding var tab: Tabs
    
    var body: some View {
        ZStack() {
            Image(Images.emptyInvestment)
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea([.leading, .trailing])
                
                
               
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
                .opacity(0.9)
            VStack {
                Text("You haven't added anything yet.")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                ITButton(text: "Add", color: .cyan, action: openAddInvestments)
                    .padding(.bottom, 50)
            }
            .padding()
        }
    }
    
    func openAddInvestments() {
        tab = .add
    }
}

struct EmptyInvestmentsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyInvestmentsView(tab: .constant(.add))
    }
}
