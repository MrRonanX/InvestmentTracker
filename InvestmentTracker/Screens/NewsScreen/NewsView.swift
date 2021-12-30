//
//  NewsView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import SwiftUI

struct NewsView: View {
    
    @State var newsQuery = ""
    @State var showArticles = false
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(Images.logo)
                    .resizable()
                    .scaledToFit()
                    .padding()
                TextField("Type something", text: $newsQuery)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                ITButton(color: .yellow, action: executeQuery)
                Spacer()
               
                NavigationLink("", isActive: $showArticles) {
                    NewsListView(query: newsQuery.trimmingCharacters(in: .whitespaces))
                }
            }
            .padding()
            .navigationTitle("News")
        }
    }
    
    private func executeQuery() {
        showArticles = true
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
