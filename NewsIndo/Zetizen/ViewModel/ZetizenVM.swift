//
//  ZetizenVM.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import Foundation

class ZetizenVM: ObservableObject {
    @Published var articles = [Movies]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNews() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            articles = try await APIZetizenService.shared.fetchNews()
        } catch {
            errorMessage = "⚠️ \(error.localizedDescription). Failed to fetch Zetizen's News from API! ⚠️"
            print(errorMessage ?? "N/A")
        }
    }
}
