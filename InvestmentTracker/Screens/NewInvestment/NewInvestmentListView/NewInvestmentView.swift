//
//  NewInvestmentView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import SwiftUI

struct NewInvestmentView: View {

    @StateObject var viewModel = NewInvestmentViewModel()
    @State var query = ""

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    TextField("Crypto/stock", text: $query)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    ITButton(color: .orange) {
                        Task.init(priority: .userInitiated) {
                            await executeQuery()
                        }
                    }
                    
                    Text("Popular Cryptos")
                        .font(.title3)
                        .bold()
                        .padding(.vertical)
                        .offset(y: 5)
                    
                    CryptosTitle()
                    
                    ForEach(viewModel.stocks) { stock in
                        StockOption(stock: stock)
                            .environmentObject(viewModel)
                    }
                    .navigationTitle("New Investment")
                }
                if viewModel.loading {
                    LoadingView()
                }
            }
            .sheet(item: $viewModel.addedStock, onDismiss: showConfirmationAlert) { AddInvestmentView(stock: $0, result: $viewModel.addStatus) }
        }
        .alert(item: $viewModel.alert) { $0.alert }
    }
    
    private func executeQuery() async {
        await viewModel.queryStock(Stock(currencyCode: query.trimmingCharacters(in: .whitespaces)))
    }
    
    private func showConfirmationAlert() {
        viewModel.createConfirmationAlert()
    }
}

struct CryptosTitle: View {
    
    var body: some View {
        HStack {
            Text("Name")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.leading)
           
            Spacer()

            Text("Last Price")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.trailing)
                .padding(.trailing)
        }
        .padding(.leading)
        .padding(.trailing, 90)
        .frame(maxWidth: .infinity)
    }
}

struct StockOption: View {
    @EnvironmentObject var viewModel: NewInvestmentViewModel
   
    var stock: Stock
    
    var body: some View {
        HStack(alignment: .top) {
            Text(stock.currencyCode)
                .font(.headline)
            +
            Text("/\(stock.exchangeCode)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(stock.dolarPrice)
                .font(.headline)
                .fontWeight(.medium)
                .minimumScaleFactor(0.75)
                .lineLimit(1)
                .padding(.trailing)
            Button {
                Task.init(priority: .userInitiated) { await queryStock(stock) }
            } label: {
                Text(stock.action)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 70, height: 25)
                    .background(Color.orange)
                    .cornerRadius(10)
                    
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    
   
    
    private func queryStock(_ stock: Stock) async {
        guard stock.action == "Query" else {
            viewModel.addCrypto(stock)
            return
        }
        await viewModel.queryStock(stock)
    }
}

struct NewInvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        NewInvestmentView()
    }
}
