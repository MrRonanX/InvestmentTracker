//
//  TabBarView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import SwiftUI


enum Tabs {
    case overview, add, news
    
    var selectionColor: Color {
        switch self {
        case .overview: return .blue
        case .add:      return .orange
        case .news:     return .yellow
        }
    }
}

struct TabBarView: View {
    
    @State var selectedTab: Tabs = .overview
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            InvestmentContainer(selectedTab: $selectedTab)
                .tabItem {
                    Label("Active Investments", systemImage: "chart.bar.xaxis")
                }
                .tag(Tabs.overview)

            
            NewInvestmentView()
                .tabItem {
                    Label("New Investment", systemImage: "plus.diamond.fill")
                }
                .tag(Tabs.add)

            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper.fill")
                }
                .tag(Tabs.news)
        }
        .accentColor(selectedTab.selectionColor)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


