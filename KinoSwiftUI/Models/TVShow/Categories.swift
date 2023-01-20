//
//  CategoriesResponse.swift
//  Kino
//
//  Created by Luka Lešić on 08.01.2023..
//

import Foundation

struct Category: Codable, Hashable {
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.categoryID == rhs.categoryID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.categoryID)
    }
    
    let name, categoryID: String
    let tvShows: [TvShow]

    enum CodingKeys: String, CodingKey {
        case name
        case categoryID = "category_id"
        case tvShows = "tv_shows"
    }
}
