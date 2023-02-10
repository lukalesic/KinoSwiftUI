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
    let media: [JSONAny]?
    let movieDetailsCacheData: String
    let people: [Person]?
    let similarMovies: [JSONAny]?
    let services: Services
    let cinemas: [Cinema]?

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
        case summary, media
        case movieDetailsCacheData = "movie_details_cache_data"
        case people = "people"
        case similarMovies = "similar_movies"
        case services, cinemas
    }
}
