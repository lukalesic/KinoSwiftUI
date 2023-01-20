//
//  Stats.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

// MARK: - Stats
struct MovieStats: Codable {
    let premiereDate: Int
    let premiereDateString: String
    let duration: Int

    enum CodingKeys: String, CodingKey {
        case premiereDate = "premiere_date"
        case premiereDateString = "premiere_date_string"
        case duration
    }
}
