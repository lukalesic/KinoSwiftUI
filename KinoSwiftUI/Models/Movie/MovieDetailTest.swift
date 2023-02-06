// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let show = try? JSONDecoder().decode(Show.self, from: jsonData)

import Foundation

// MARK: - Show
struct MovieDetailTest: Codable {
    let movieCacheDate: String
    let path, contentURL: String
    let movieID: Int
    let originalTitle, title: String
    let genre: [String]
    let pgRating: Int
    let posterURL, originalPosterURL, photoURL: String
    let summary: String
    let stats: StatsTest
    let ratings: RatingsTest
    let media: [JSONAny]
    let movieDetailsCacheData: String
    let people: [PersonTest]
    let similarMovies: [JSONAny]
    let updatedAt: Int
    let updatedAtString, servicesCacheDate: String
    let services: ServicesTest
    let cinemas: [CinemaTest]
    let showtimes: [ShowtimeTest]

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
        case summary, stats, ratings, media
        case movieDetailsCacheData = "movie_details_cache_data"
        case people
        case similarMovies = "similar_movies"
        case updatedAt = "updated_at"
        case updatedAtString = "updated_at_string"
        case servicesCacheDate = "services_cache_date"
        case services, cinemas, showtimes
    }
}

// MARK: - Cinema
struct CinemaTest: Codable {
    let cinemaID, chainID: Int
    let name, shortName, address: String
    let city: CityTest
    let phone: String
    let latitude, longitude: Double
    let web: String
    let zone: ZoneTest

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case chainID = "chain_id"
        case name
        case shortName = "short_name"
        case address, city, phone, latitude, longitude, web, zone
    }
}

enum CityTest: String, Codable {
    case berlin = "Berlin"
    case bernau = "Bernau"
    case düsseldorf = "Düsseldorf"
    case hennigsdorf = "Hennigsdorf"
    case kleinmachnow = "Kleinmachnow"
}

enum ZoneTest: String, Codable {
    case europeBerlin = "Europe/Berlin"
}

// MARK: - Person
struct PersonTest: Codable {
    let id: Int
    let name: String
    let role: RoleTest
    let photoURL: String
    let order: Int
    let characterName: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, role
        case photoURL = "photo_url"
        case order
        case characterName = "character_name"
    }
}

enum RoleTest: String, Codable {
    case actor = "actor"
    case director = "director"
    case producer = "producer"
}

// MARK: - Ratings
struct RatingsTest: Codable {
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

// MARK: - Services
struct ServicesTest: Codable {
    let rent, buy, flat: [JSONAny]
}

// MARK: - Showtime
struct ShowtimeTest: Codable {
    let groupID: String
    let groupData: [GroupDatumTest]

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case groupData = "group_data"
    }
}

// MARK: - GroupDatum
struct GroupDatumTest: Codable {
    let cinemaID: Int
    let data: [DatumTest]

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case data
    }
}

// MARK: - Datum
struct DatumTest: Codable {
    let showtimeID, date: Int
    let dateString: String
    let inAppBooking: Bool
    let ticketLink: String
    let bookingLink: String
    let value: ValueTest

    enum CodingKeys: String, CodingKey {
        case showtimeID = "showtime_id"
        case date
        case dateString = "date_string"
        case inAppBooking = "in_app_booking"
        case ticketLink = "ticket_link"
        case bookingLink = "booking_link"
        case value
    }
}

enum ValueTest: String, Codable {
    case empty = ""
    case omu = "OMU"
}

// MARK: - Stats
struct StatsTest: Codable {
    let premiereDate: Int
    let premiereDateString: String
    let duration: Int
    let distributor, country, languages: String
    let revenue, budget: Int

    enum CodingKeys: String, CodingKey {
        case premiereDate = "premiere_date"
        case premiereDateString = "premiere_date_string"
        case duration, distributor, country, languages, revenue, budget
    }
}
