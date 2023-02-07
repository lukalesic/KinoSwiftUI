//
//  CategoryNew.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 06.02.2023..
//

import Foundation

class Category: Decodable, Hashable {
    let name, categoryID: String
    let items: [BaseItem]
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.categoryID == rhs.categoryID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.categoryID)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case categoryID = "category_id"
        case movies = "movies"
        case tvShows = "tv_shows"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.categoryID = try container.decode(String.self, forKey: .categoryID)
        
        do {
            self.items = try container.decode([TvShow].self, forKey: .tvShows)
        } catch {
            self.items = try container.decode([Movie].self, forKey: .movies)

        }
    }
}
