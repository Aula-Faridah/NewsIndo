//
//  ZetizenView.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import SwiftUI
import SafariServices

struct ZetizenView: View {
    @StateObject private var zetizenVM = ZetizenVM()
    
    @State private var searchText: String =  ""
    @State private var isRedacted: Bool = true
    
    var movieSearchResults : [Movies]
    {
        guard !searchText.isEmpty else {
            return zetizenVM.articles
        }
        return zetizenVM.articles.filter { article in
            article.title.lowercased()
                .contains(searchText
                    .lowercased())
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(movieSearchResults){ article in
                    HStack(alignment:.center, spacing: 16) {
                        AsyncImage(url: URL(string: article.image)) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width:80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            ProgressView()
                        }
                        
//                        Text(article.isoDate.relativeToCurrentDate())
                        
                        VStack(alignment:.leading, spacing: 8) {
                            Text(article.title)
                                .font(.headline)
                                .lineLimit(2)
                            
                            Text(article.creator)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            HStack{
                                Text(article.isoDate.relativeToCurrentDate())
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Button{
                                    let vc = SFSafariViewController(url: URL(string: article.link)!)
                                    
                                    UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                                    
                                } label: {
                                    Text("Selengkapnya")
                                        .font(.caption)
                                        .foregroundStyle(.link)
                                }
                            }
                        }
                    }
                }
                
            }
            .listStyle(.plain)
            .navigationTitle(Constant.zetizenTitle)
            .task {
                await zetizenVM.fetchNews()
            }
            .refreshable {
                isRedacted = true
                await zetizenVM.fetchNews()
                isRedacted = false
            }
            .searchable(text: $searchText,
                        placement:
                    .navigationBarDrawer(displayMode: .always),
                        prompt: "What movie's that you're looking for?")
            .overlay{
                if movieSearchResults.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
        }
    }
}

#Preview {
    ZetizenView()
}
