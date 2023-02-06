//
//  MovieDetail.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation
// MARK: - Show

struct MovieDetail: Codable {
    let path, contentURL: String
    let movieID: Int
    let originalTitle, title: String
    let genre: [String]
    let pgRating: Int
    let posterURL, originalPosterURL, photoURL: String
    let summary: String
    let ratings: RatingDetails
    let media: [JSONAny]?
    let movieDetailsCacheData: String
    let people: [Person]?
    let similarMovies: [JSONAny]?
    let updatedAt: Int
    let updatedAtString, servicesCacheDate: String
    let services: Services
    let cinemas: [Cinema]?
    let showtimes: [Showtime]?

    enum CodingKeys: String, CodingKey {
        case path
        case contentURL = "content_url"
        case movieID = "movie_id"
        case originalTitle = "original_title"
        case title, genre
        case pgRating = "pg_rating"
        case posterURL = "poster_url"
        case originalPosterURL = "original_poster_url"
        case photoURL = "photo_url"
        case summary, ratings, media
        case movieDetailsCacheData = "movie_details_cache_data"
        case people = "people"
        case similarMovies = "similar_movies"
        case updatedAt = "updated_at"
        case updatedAtString = "updated_at_string"
        case servicesCacheDate = "services_cache_date"
        case services, cinemas, showtimes
    }
}
