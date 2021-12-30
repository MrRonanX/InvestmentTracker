//
//  EmptyStateView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/20/21.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(Images.notFound)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                Text("Nothing Found")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
            .offset(y: -100)
        }
    }
}



struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
