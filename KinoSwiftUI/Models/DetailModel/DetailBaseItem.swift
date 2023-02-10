//
//  DetailBaseItem.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 10.02.2023..
//

import Foundation




class DetailBaseItem: Decodable, Hashable {
    static func == (lhs: DetailBaseItem, rhs: DetailBaseItem) -> Bool {
        return lhs.movieID == lhs.movieID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movieID)
    }
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.contentURL = try container.decode(String.self, forKey: .contentURL)
        self.movieID = try container.decode(Int.self, forKey: .movieID)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.title = try container.decode(String.self, forKey: .title)
        self.genre = try container.decode([String].self, forKey: .genre)
        self.pgRating = try container.decode(Int.self, forKey: .pgRating)
        self.posterURL = try container.decode(String.self, forKey: .posterURL)
        self.originalPosterURL = try container.decode(String.self, forKey: .originalPosterURL)
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.media = try container.decodeIfPresent([JSONAny].self, forKey: .media)
        self.movieDetailsCacheData = try container.decode(String.self, forKey: .movieDetailsCacheData)
        self.people = try container.decodeIfPresent([Person].self, forKey: .people)
        self.similarMovies = try container.decodeIfPresent([JSONAny].self, forKey: .similarMovies)
        self.services = try container.decode(Services.self, forKey: .services)
        self.cinemas = try container.decodeIfPresent([Cinema].self, forKey: .cinemas)
    }
    
}
