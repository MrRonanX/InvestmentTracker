//
//  CardViewModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/29/21.
//

import SwiftUI

@MainActor
final class CardViewModel: ObservableObject {
    
    @Published var investment: Investment
    @Published var isLoading = false
    @Published var showNews = false
    @Published var alert: AlertItem?
    
    private var service = InvestmentsService.shared
    
    init(investment: Investment) {
        self.investment = investment
    }
    
    func updateInvestment() async {
        guard !investment.refreshedToday else { return }
        await updateRequest()
    }
    
    func updateRequest() async {
        isLoading = true
        let route = APIRouter.queryCrypto(asset: investment.code)
        let result = await service.cryptoQuery(route)
        isLoading = false
        switch result {
        case .success(let response):
            guard let stock = response.exchangeRate else {
                alert = AlertContext.alertWith(message: "Something went wrong. Try again please.")
                return
            }
            updateSavedInvestment(with: stock)
            
            
        case .failure(let error):
            alert = AlertContext.alertWith(message: error.description)
        }
    }
    
    private func updateSavedInvestment(with stock: Stock) {
        investment.updatePrices(with: stock)
        PersistenceManager.shared.save()
    }
}
