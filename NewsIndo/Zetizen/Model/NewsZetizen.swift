//
//  File.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import Foundation
// MARK: - NewsZetizen
struct NewsZetizen: Codable {
    let message: String
    let total: Int
    let data: [Movies]
}

// MARK: - Movies
struct Movies: Codable {
    let creator, title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: String
}
