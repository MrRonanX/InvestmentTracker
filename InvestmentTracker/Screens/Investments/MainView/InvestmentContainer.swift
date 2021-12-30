//
//  InvestmentContainer.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/31/21.
//

import SwiftUI

struct InvestmentContainer: View {
    
    @StateObject var viewModel = InvestmentsViewModel()
    @Binding var selectedTab: Tabs
    
    var body: some View {
        if viewModel.investments.isEmpty {
            EmptyInvestmentsView(tab: $selectedTab)
                .onAppear(perform: viewModel.loadInvestments)
        } else {
            InvestmentsView(viewModel: viewModel, selectedTab: $selectedTab)
                .onAppear(perform: viewModel.loadInvestments)
        }
    }

}

struct InvestmentContainer_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentContainer(selectedTab: .constant(.overview))
    }
}
