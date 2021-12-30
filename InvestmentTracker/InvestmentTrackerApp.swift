//
//  InvestmentTrackerApp.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import SwiftUI

@main
struct InvestmentTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
