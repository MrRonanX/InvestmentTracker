//
//  CardView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/29/21.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel: CardViewModel
    
    init(investment: Investment) {
        _viewModel = StateObject(wrappedValue: CardViewModel(investment: investment))
    }
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(alignment: .center, spacing: 0) {
                    NewsAndReloadView(viewModel: viewModel)
                    ChartView(height: geo.size.height / 2, asset: viewModel.investment)
                        .frame(height: geo.size.height / 2)

                    StatsView(asset: viewModel.investment)
                        .padding(.horizontal)
                    reloadButton
                    Spacer()
                }
                NavigationLink("", isActive: $viewModel.showNews) {
                    NewsListView(query: viewModel.investment.code)
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .task {
                await viewModel.updateInvestment()
            }
        }

    }
    
    var reloadButton: some View {
        Button { Task(priority: .userInitiated) {
               await viewModel.updateRequest()
           }} label: {
            Label("Reload", systemImage: "arrow.counterclockwise")
                .foregroundColor(Color(UIColor.systemBackground))
                .frame(width: 130, height: 30)
                .background(.blue)
                .cornerRadius(10)
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(investment: Investment(from: Stock()))
    }
}

struct StatsView: View {

    @ObservedObject var asset: Investment
    
    var body: some View {
        VStack(spacing: 10) {
            StatsTitle(title: "Bought at", description: asset.buyPriceString)
            StatsTitle(title: "Current Price", description: asset.currentPriceString)
            StatsTitle(title: "Own shares", description: asset.sharesString)
            StatsTitle(title: "Income", description: asset.incomeString)
                .foregroundColor(colorForItem(item: asset.income))
            StatsTitle(title: "24 hour chage", description: asset.dayChangePriceString)
                .foregroundColor(colorForItem(item: asset.dayChangePrice))
        }
        .padding()
    }
    
    func colorForItem(item: Double) -> Color {
        if item > 0 { return .green }
        else if item < 0 { return .red }
        else { return Color(uiColor: .label)}
    }
}

struct StatsTitle: View {
    
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(description)
        }
    }
}

struct NewsAndReloadView: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        HStack {
            Button(action: openNews) {
                Label("Get News", systemImage: "newspaper")
                    
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func openNews() {
        viewModel.showNews = true
    }
}
