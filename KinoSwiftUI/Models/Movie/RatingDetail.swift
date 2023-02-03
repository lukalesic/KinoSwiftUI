//
//  RatingDetail.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

// MARK: - Ratings
struct RatingDetails: Codable {
    let popularity: Double
    let imdbID: String
    let imdbRating: Double
    let watchlistCount, starsCount: Int
    let starsAverage, tmdbPopularity: Double

    enum CodingKeys: String, CodingKey {
        case popularity
        case imdbID = "imdb_id"
        case imdbRating = "imdb_rating"
        case watchlistCount = "watchlist_count"
        case starsCount = "stars_count"
        case starsAverage = "stars_average"
        case tmdbPopularity = "tmdb_popularity"
    }
}
