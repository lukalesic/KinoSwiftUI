//
//  Movie.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 10.02.2023..
//

import Foundation

class Movie: BaseItem {

    let contentURL: String
    let originalPosterURL: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contentURL = try container.decode(String.self, forKey: .contentURL)
        self.originalPosterURL = try container.decode(String.self, forKey: .originalPosterURL)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case contentURL = "content_url"
        case movieID = "movie_id"
        case originalPosterURL = "original_poster_url"
    }
}
