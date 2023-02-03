//
//  StatsDetail.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

// MARK: - Stats
struct StatsDetail: Codable {
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
