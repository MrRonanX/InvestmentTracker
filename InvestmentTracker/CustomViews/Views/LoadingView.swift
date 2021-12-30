//
//  LoadingView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/20/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                .scaleEffect(1.5)
                
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
