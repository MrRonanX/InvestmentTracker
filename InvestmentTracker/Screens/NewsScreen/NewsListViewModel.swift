//
//  NewsListViewModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/20/21.
//

import SwiftUI

@MainActor
final class NewsListViewModel: ObservableObject {
    
    @Published var articles         = [Article]()
    @Published var isLoading        = false
    @Published var error: AlertItem? = nil
    @Published var searchQuery      = ""
    
    var service = InvestmentsService.shared
    
    var filteredArticles            : [Article] {
        guard searchQuery != "" else { return articles}
        return articles.filter { $0.title.lowercased().contains(searchQuery.lowercased())}
    }
    
    var showLoadMoreButton: Bool {
        !filteredArticles.isEmpty && hasMorePages && searchQuery != ""
    }
    
    var hasMorePages                = true
    var isRefreshing                = false
    var emptyResult                 = false
    var page                        = 1
    
    
    func loadArticles(with query: String) async {
        isLoading = true
        hasMorePages = true
        let route = APIRouter.getNews(topic: query, date: Date().toString(.query), page: page)
        let result = await service.news(route)
        isLoading = false
        switch result {
        case .success(let request):
            updateUI(with: request.articles)
        case .failure(let error):
            self.error = AlertContext.alertWith(message: error.description)
        }
    }
    
    
    func updateUI(with articles: [Article]) {
        handleRefreshing()
        hasMorePages = articles.count == 20
        emptyResult = articles.isEmpty
        
        withAnimation {
            self.articles.append(contentsOf: articles)
        }
    }
    
    private func handleRefreshing() {
        if !isRefreshing { return }
        articles.removeAll()
        isRefreshing = false
        
    }
    
    func downloadImage(fromURL url: String) async -> UIImage? {
        let route = APIRouter.getImage(url: url)
        let result = await service.getImage(route)
        switch result {
        case .success(let data):
            let image = UIImage(data: data)
            return image
        case .failure(_):
            return nil
        }

    }
}
