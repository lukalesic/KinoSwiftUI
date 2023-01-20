//
//  Category.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation


// MARK: - Category
struct MovieCategory: Codable {
    let name, categoryID: String
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case name
        case categoryID = "category_id"
        case movies
    }
}
