//
//  NewsVM.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import Foundation

class NewsVM: ObservableObject {
    @Published var articles = [NewsArticle]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNews() async {
        isLoading = true
        defer {
            isLoading = false
        }
        errorMessage = nil
        
        do {
            articles = try await APIService.shared.fetchNews()
//            isLoading = false
        } catch  {
            errorMessage = "🔥 \(error.localizedDescription). Failed to fetch News from APII!!! 🔥"
            print(errorMessage ?? "N/A")
//            isLoading = false
        }
    }
}
