//
//  InvestmentsView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import SwiftUI

struct InvestmentsView: View {
    
    @ObservedObject var viewModel: InvestmentsViewModel
    @Binding var selectedTab: Tabs
    
    var body: some View {
        NavigationView {
            TabView(selection: $viewModel.selectedInvestmentID) {
                ForEach(viewModel.investments) { investment in
                    CardView(investment: investment)
                        .navigationTitle(createTitle(for: investment))
                        .tag(investment.wrappedID)
                }
            }
            .tabViewStyle(viewModel.investments.isEmpty ? .page(indexDisplayMode: .never) : .page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .navigationBarTitleDisplayMode(DeviceTypes.isiPhone8Standard ? .inline : .large)
            .navigationTitle("Investments")
            .alert(item: $viewModel.alert) { $0.alertWithSecondaryButton }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Your Wallet")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: deleteInvestment) {
                        Label("Delete", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        
    }
    
    func createTitle(for investment: Investment) -> String {
        "\(investment.code)/\(investment.wrappedExchangeCode)"
    }
    
    func deleteInvestment() {
        viewModel.deleteTapped()
    }
}


struct InvestmentsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentsView(viewModel: InvestmentsViewModel(), selectedTab: .constant(.overview))
    }
}










