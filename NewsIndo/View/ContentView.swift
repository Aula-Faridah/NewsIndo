//
//  ContentView.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @StateObject private var newsVM = NewsVM()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(newsVM.articles) {article in
                    VStack(alignment: .leading, spacing: 16){
                        AsyncImage(url: URL(string: article.image.medium)) { image in
                            image.resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } placeholder: {
                            //                            ProgressView()
                            ZStack {
                                Color.teal
                                WaitingView()
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Text(article.title)
                            .font(.headline)
                        
                        Text(article.author)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            Text(article.isoDate.relativeToCurrentDate())
                            
                            Button{
                                let vc = SFSafariViewController(url: URL(string: article.link)!)
                                
                                UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                                
                            } label: {
                                Text("Selengkapnya")
                                    .foregroundStyle(.link)
                            }
                        }
                        
                        //                        if let timeAgo = timeAgoSinceDate(article.isoDate) {
                        //                            Text(timeAgo)
                        //                                .font(.caption)
                        //                        }
                        
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Constant.newsTitle)
            .task {
                await newsVM.fetchNews()
            }
            .overlay(newsVM.isLoading ? ProgressView() : nil)
        }
    }
}

#Preview {
    ContentView()
}

@ViewBuilder
func WaitingView() -> some View {
    VStack(spacing: 16){
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.pink)
        
        Text("Fetch image...")
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { scene in
                scene as? UIWindowScene
            }
            .filter{ filter in
                filter.activationState == .foregroundActive
            }
            .first?.keyWindow
    }
}



//func timeAgoSinceDate(_ isoDate: String) -> String? {
//    let dateFormatter = ISO8601DateFormatter()
//    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//
//    if let date = dateFormatter.date(from: isoDate) {
//        let interval = Calendar.current.dateComponents([.minute], from: date, to: Date())
//
//        if let minutes = interval.minute, minutes > 0 {
//            return "\(minutes) menit yang lalu"
//        } else {
//            return "Baru saja"
//        }
//    }
//
//    return nil
//}
