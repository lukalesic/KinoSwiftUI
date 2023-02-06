//
//  Welcome.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let spotlight: Spotlight
    let categories: [MovieCategory]
    let presaleIDS: [Int]?
    let loadMore: String

    enum CodingKeys: String, CodingKey {
        case spotlight, categories
        case presaleIDS = "presale_ids"
        case loadMore = "load_more"
    }
}


