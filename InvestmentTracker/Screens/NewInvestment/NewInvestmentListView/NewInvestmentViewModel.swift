//
//  NewInvestmentViewModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/23/21.
//

import SwiftUI

@MainActor
final class NewInvestmentViewModel: ObservableObject {
    @Published var stocks = StartData.stocks
    @Published var loading = false
    @Published var alert: AlertItem? = nil
    @Published var addedStock: Stock? = nil
    @Published var addStatus = false
    
    var service = InvestmentsService.shared
    
    func queryStock(_ stock: Stock) async {
        loading = true
        let route = APIRouter.queryCrypto(asset: stock.currencyCode)
        let result = await service.cryptoQuery(route)
        loading = false
        switch result {
        case .success(let result):
            guard let queriedStock = result.exchangeRate else { return }
            guard let index = stocks.firstIndex(where:{ $0.currencyCode.lowercased() == stock.currencyCode.lowercased() }) else {
                stocks.insert(queriedStock, at: 0)
                return
            }
            withAnimation {
                stocks.remove(at: index)
                stocks.insert(queriedStock, at: index)
            }
        case .failure(let error):
            self.alert = AlertContext.alertWith(title: "Error", message: error.description)
        }
    }
    
    
    func addCrypto(_ stock: Stock) {
        addedStock = stock
    }
    
    func createConfirmationAlert() {
        guard addStatus else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alert = AlertContext.alertWith(title: "Success", message: "The new investment has been added. Go to the Investments screen to track it.")
        }
    }
}
