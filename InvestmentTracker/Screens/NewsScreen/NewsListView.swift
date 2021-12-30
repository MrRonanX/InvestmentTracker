//
//  NewsListView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/19/21.
//

import SwiftUI

struct NewsListView: View {
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = NewsListViewModel()
    @State var selectedArticle: Article? = nil
    var query: String
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.filteredArticles) { article in
                    ArticleView(article: article)
                        .environmentObject(viewModel)
                        .padding(.bottom, 15)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture { selectedArticle = article }
                }
                
                if viewModel.showLoadMoreButton {
                    Button("Load More") {
                        Task.init(priority: .userInitiated) { await loadMore() }
                    }
                    .buttonStyle(YellowButtonStyle())
                }
            }
            .listStyle(PlainListStyle())
            .task           { await viewModel.loadArticles(with: query) }
            .refreshable    { await refresh()}
            .searchable(text: $viewModel.searchQuery)
            
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.emptyResult {
                EmptyStateView()
            }
        }
        .navigationTitle(query)
        .fullScreenCover(item: $selectedArticle) {
            SafariView(url: URL(string: $0.url) ?? URL(string: "apple.com")!)
                .ignoresSafeArea()
        }
       
        .alert(item: $viewModel.error) { $0.alert}
    }
    
    
    private func loadMore() async {
        guard viewModel.hasMorePages else { return }
        viewModel.page += 1
        await viewModel.loadArticles(with: query)
    }
    
    private func refresh() async {
        viewModel.page = 1
        viewModel.isRefreshing = true
        await viewModel.loadArticles(with: query)
    }
}



struct ArticleView: View {
    
    @EnvironmentObject var viewModel: NewsListViewModel
    var article: Article
    var publishedDate: String {
        article.publishedAt.toDate()?.toString() ?? ""
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(article.title)
                .font(.title3)
                .bold()
                .padding(.horizontal)
            ArticleImage(url: article.urlToImage)
            Text(publishedDate)
                .font(.caption2)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
            Text(article.description)
                .lineLimit(4)
                .padding(.horizontal)
            HStack(spacing: 0) {
                Text(article.source.name)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text(article.author)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }.frame(maxWidth: .infinity)
        
    }
}

struct ArticleImage: View {
    
    @EnvironmentObject var viewModel: NewsListViewModel
    var url: String
    
    @State var image = UIImage(named: Images.placeholder)!
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .task { await loadImage() }
    }
    
    func loadImage() async {
        image = await viewModel.downloadImage(fromURL: url) ?? UIImage(named: Images.placeholder)!
        
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(query: "Ukraine")
    }
}

