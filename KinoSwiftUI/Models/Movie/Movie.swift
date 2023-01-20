//
//  Movie.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let movieCacheDate: String
    let path, contentURL: String
    let movieID: Int
    let originalTitle, title: String
    let genre: [String]
    let pgRating: Int
    let posterURL, originalPosterURL, photoURL: String
    let stats: MovieStats
    let ratings: Ratings
    let media: [JSONAny]?
    let updatedAt: Int
    let updatedAtString: String

    enum CodingKeys: String, CodingKey {
        case movieCacheDate = "movie_cache_date"
        case path
        case contentURL = "content_url"
        case movieID = "movie_id"
        case originalTitle = "original_title"
        case title, genre
        case pgRating = "pg_rating"
        case posterURL = "poster_url"
        case originalPosterURL = "original_poster_url"
        case photoURL = "photo_url"
        case stats, ratings, media
        case updatedAt = "updated_at"
        case updatedAtString = "updated_at_string"
    }
}

