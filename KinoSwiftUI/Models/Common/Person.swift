//
//  Person.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation


// MARK: - Person
struct Person: Codable, Hashable {
    let id: Int
    let name: String
    let role: Role?
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

enum Role: String, Codable {
    case actor = "actor"
    case director = "director"
    case producer = "producer"
    case writer = "writer"
    case creator = "creator"
}
