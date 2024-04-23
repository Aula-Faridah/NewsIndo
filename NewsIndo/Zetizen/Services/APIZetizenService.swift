//
//  APIZetizenService.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import Foundation
import Alamofire

class APIZetizenService {
    static let shared = APIZetizenService()
    private init(){}
    
    func fetchNews() async throws -> [Movies] {
        guard let url = URL(string: Constant.zetizenUrl) else {
            print("😡 ERROR: Could not convert \(String(describing: URL(string: Constant.zetizenUrl))) to a URL")
            throw URLError(.badURL)}
        
        let news = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: NewsZetizen.self) { response in
                switch response.result{
                case.success(let newResponse):
                    continuation.resume(returning: newResponse.data)
                case.failure(let err):
                    continuation.resume(throwing: err)
                }
            }
        }
        return news
    }
}
