//
//  StatsNew.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 07.02.2023..
//

import Foundation


// MARK: - Stats

class Stats: Codable{
    let premiereDate: Int?
    let premiereDateString: String?
    let duration: Int?
    let firstAirDate: Int?
    let firstAirDateString: String?
    let lastAirDate: Int?
    let lastAirDateString: String?

    enum CodingKeys: String, CodingKey {
        case premiereDate = "premiere_date"
        case premiereDateString = "premiere_date_string"
        case duration
        case firstAirDate = "first_air_date"
        case firstAirDateString = "first_air_date_string"
        case lastAirDate = "last_air_date"
        case lastAirDateString = "last_air_date_string"
    }
}
