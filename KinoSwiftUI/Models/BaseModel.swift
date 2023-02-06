//
//  BaseModel.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 06.02.2023..
//

import Foundation

class BaseModel: Codable, Hashable {
    let movieCacheDate: String
      let path: String
      let originalTitle, title: String
      let genre: [String]
      let pgRating: Int
      let posterURL, photoURL: String
      let stats: Stats
      let ratings: Ratings
      let updatedAt: Int
      let updatedAtString: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieCacheDate = try container.decode(String.self, forKey: .movieCacheDate)
        self.path = try container.decode(String.self, forKey: .path)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.title = try container.decode(String.self, forKey: .title)
        self.genre = try container.decode([String].self, forKey: .genre)
        self.pgRating = try container.decode(Int.self, forKey: .pgRating)
        self.posterURL = try container.decode(String.self, forKey: .posterURL)
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
        self.stats = try container.decode(Stats.self, forKey: .stats)
        self.ratings = try container.decode(Ratings.self, forKey: .ratings)
        self.updatedAt = try container.decode(Int.self, forKey: .updatedAt)
        self.updatedAtString = try container.decode(String.self, forKey: .updatedAtString)
    }
    
    enum CodingKeys: String, CodingKey {
           case movieCacheDate = "movie_cache_date"
           case path
           case originalTitle = "original_title"
           case title, genre
           case pgRating = "pg_rating"
           case posterURL = "poster_url"
           case photoURL = "photo_url"
           case stats, ratings
           case updatedAt = "updated_at"
           case updatedAtString = "updated_at_string"
       }

    
    static func == (lhs: BaseModel, rhs: BaseModel) -> Bool {
          return lhs.hashValue == rhs.hashValue
      }
      
      func hash(into hasher: inout Hasher) {
          hasher.combine(hashValue)
      }
}


class MovieNew: BaseModel {
    
}
