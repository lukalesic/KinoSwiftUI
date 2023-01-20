//
//  StatsResponse.swift
//  Kino
//
//  Created by Luka Lešić on 08.01.2023..
//

import Foundation

// MARK: - Stats
struct Stats: Codable {
    let firstAirDate: Int
    let firstAirDateString: String
    let lastAirDate: Int
    let lastAirDateString: String

    enum CodingKeys: String, CodingKey {
        case firstAirDate = "first_air_date"
        case firstAirDateString = "first_air_date_string"
        case lastAirDate = "last_air_date"
        case lastAirDateString = "last_air_date_string"
    }
}
