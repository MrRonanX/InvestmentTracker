//
//  AlertItem.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/20/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: dismissButton)
    }
    
    var alertWithSecondaryButton: Alert {
        Alert(title: title, message: message, primaryButton: dismissButton, secondaryButton: secondaryButton!)
    }
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    var secondaryButton: Alert.Button? = nil
}

struct AlertContext {
    static func alertWith(title: String = "Error", message: String) -> AlertItem{
        AlertItem(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
    }
    
    static func deleteConfirmation(action: @escaping () -> Void) -> AlertItem {
        AlertItem(title: Text("Delete Investment"),
                  message: Text("This action is irreversible."),
                  dismissButton: .cancel(Text("Back")),
                  secondaryButton: .destructive(Text("Delete"), action: action))
        
        
    }
}
