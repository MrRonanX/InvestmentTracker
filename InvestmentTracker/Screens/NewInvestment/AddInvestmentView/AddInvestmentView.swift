//
//  AddInvestmentView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/23/21.
//

import SwiftUI

struct AddInvestmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: AddInvestmentViewModel
    @Binding var result: Bool
    
    init(stock: Stock, result: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: AddInvestmentViewModel(stock: stock))
        _result = result
    }

    var body: some View {
        NavigationView {
            Form {
                Section(viewModel.currencyName) {
                    TextField("Currency Price", text: $viewModel.price)
                        .keyboardType(.decimalPad)
                        .accentColor(.orange)
                }
                
                Section("Amount Bought") {
                    TextField("0.02", value: $viewModel.shares, format: .number)
                        .keyboardType(.decimalPad)
                        .accentColor(.orange)
                }
                
                Section("Buy Date") {
                    DatePicker("Date", selection: $viewModel.buyDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .accentColor(.orange)
                }
                
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back", action: dismissView)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: saveInvestment)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func saveInvestment() {
        guard viewModel.validInput, viewModel.createInvestmentRecord() else { return }
        result = true
        presentationMode.wrappedValue.dismiss()
        
    }
    
    func dismissView () {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddInvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockStock = Stock(currencyCode: "BTC", currencyName: "Bitcoin", exchangeCode: "USD", exchangeName: "United States Dollar", exchangeRate: "48000", lastRefreshed: "23-12-2021", timeZone: "Hanoi Viewtnam", bidPrice: "48100", askPrice: "48200")
        AddInvestmentView(stock: mockStock, result: .constant(false))
    }
}
