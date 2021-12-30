//
//  InvestmentViewModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/29/21.
//

import SwiftUI

final class InvestmentsViewModel: ObservableObject {
    @Published var investments = [Investment]()
    @Published var selectedInvestmentID = UUID()
    @Published var alert: AlertItem?
    
    private var persistenceManager = PersistenceManager.shared
    
    init() {
        loadInvestments()
    }
    
    func loadInvestments() {
        investments = persistenceManager.getAllInvestments()
        guard !investments.isEmpty else { return }
        selectedInvestmentID = investments[0].wrappedID
    }
    
    func deleteTapped() {
        alert = AlertContext.deleteConfirmation(action: deleteInvestment)
    }
    
    func deleteInvestment() {
        guard let i = investments.firstIndex(where: { $0.wrappedID == selectedInvestmentID }) else { return }
        let investment = investments[i]
        
        investments.remove(at: i)
        persistenceManager.deleteInvestment(investment)
        
        
    }
}
