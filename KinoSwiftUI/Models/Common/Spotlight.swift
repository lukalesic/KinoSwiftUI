//
//  SpotlightResponse.swift
//  Kino
//
//  Created by Luka Lešić on 08.01.2023..
//

import Foundation

// MARK: - Spotlight
struct Spotlight: Codable {
    let spotlightID: Int
    let spotlightType: String
    let targetID: Int
    let targetLink: String
    let position: Int
    let title, subtitle, video56_Portrait: String
    let photoURL: String

    enum CodingKeys: String, CodingKey {
        case spotlightID = "spotlight_id"
        case spotlightType = "spotlight_type"
        case targetID = "target_id"
        case targetLink = "target_link"
        case position, title, subtitle
        case video56_Portrait = "video_56_portrait"
        case photoURL = "photo_url"
    }
}
