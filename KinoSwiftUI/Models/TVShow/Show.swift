//
//  ShowsResponse.swift
//  Kino
//
//  Created by Luka Lešić on 08.01.2023..
//

import Foundation

// MARK: - Show
struct Show: Codable {
    let spotlight: Spotlight
    let categories: [Category]
    let loadMore: String

    enum CodingKeys: String, CodingKey {
        case spotlight, categories
        case loadMore = "load_more"
    }
}
