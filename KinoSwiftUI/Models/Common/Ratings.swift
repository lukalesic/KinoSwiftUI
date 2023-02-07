//
//  RatingsResponse.swift
//  Kino
//
//  Created by Luka Lešić on 08.01.2023..
//

import Foundation

// MARK: - Ratings
struct Ratings: Codable {
    let popularity: Double
    let imdbID: String
    let imdbRating: Double
    let watchlistCount: Int


    enum CodingKeys: String, CodingKey {
        case popularity
        case imdbID = "imdb_id"
        case imdbRating = "imdb_rating"
        case watchlistCount = "watchlist_count"
    }
}
