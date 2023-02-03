//
//  TVShowsResponse.swift
//  Kino
//
//  Created by Luka Lešić on 08.01.2023..
//

import Foundation

// MARK: - TvShow
struct TvShow: Codable, Hashable {
    static func == (lhs: TvShow, rhs: TvShow) -> Bool {
        return lhs.tvShowID == rhs.tvShowID
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(tvShowID)
    }
    
    let movieCacheDate: String
    let path: String
    let tvShowID: Int
    let originalTitle, title: String
    let genre: [String]
    let pgRating: Int
    let posterURL, photoURL: String
    let stats: Stats
    let ratings: Ratings
    let updatedAt: Int
    let updatedAtString: String

    enum CodingKeys: String, CodingKey {
        case movieCacheDate = "movie_cache_date"
        case path
        case tvShowID = "tv_show_id"
        case originalTitle = "original_title"
        case title, genre
        case pgRating = "pg_rating"
        case posterURL = "poster_url"
        case photoURL = "photo_url"
        case stats, ratings
        case updatedAt = "updated_at"
        case updatedAtString = "updated_at_string"
    }
    
    
}
