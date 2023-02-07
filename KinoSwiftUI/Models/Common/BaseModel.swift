//
//  BaseModel.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 06.02.2023..
//

import Foundation

class BaseResponse: Decodable {
    let spotlight: Spotlight
    let categories: [Category]
    let loadMore: String

    enum CodingKeys: String, CodingKey {
        case spotlight, categories
        case loadMore = "load_more"
    }
    
    required init(spotlight: Spotlight, categories: [Category], loadMore: String) {
        self.spotlight = spotlight
        self.categories = categories
        self.loadMore = loadMore
    }
    
}

class BaseItem: Decodable, Hashable {
    static func == (lhs: BaseItem, rhs: BaseItem) -> Bool {
        return lhs.itemID == lhs.itemID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemID)
    }
    let movieCacheDate: String
    let path: String
    let originalTitle, title: String
    let genre: [String]
    let pgRating: Int
    let posterURL, photoURL: String
    let ratings: Ratings
    let updatedAt: Int
    let updatedAtString: String
    let stats: Stats
    let itemID: Int

    enum CodingKeys: String, CodingKey {
        case movieCacheDate = "movie_cache_date"
        case path
        case originalTitle = "original_title"
        case title, genre
        case pgRating = "pg_rating"
        case posterURL = "poster_url"
        case photoURL = "photo_url"
        case ratings
        case updatedAt = "updated_at"
        case updatedAtString = "updated_at_string"
        case stats
        case tvShowID = "tv_show_id"
        case movieID = "movie_id"
    }
    
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
        self.ratings = try container.decode(Ratings.self, forKey: .ratings)
        self.updatedAt = try container.decode(Int.self, forKey: .updatedAt)
        self.updatedAtString = try container.decode(String.self, forKey: .updatedAtString)
        self.stats = try container.decode(Stats.self, forKey: .stats)
        
        do {
            self.itemID = try container.decode(Int.self, forKey: .movieID)
        }
        catch {
            self.itemID = try container.decode(Int.self, forKey: .tvShowID)
        }
    }
}


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

class TvShow: BaseItem {
 
}
