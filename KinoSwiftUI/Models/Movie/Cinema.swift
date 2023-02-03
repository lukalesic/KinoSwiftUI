//
//  Cinema.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

// MARK: - Cinema
struct Cinema: Codable {
    let cinemaID, chainID: Int
    let name, shortName, address: String
    let city: City
    let phone: String
    let latitude, longitude: Double
    let web: String
    let zone: Zone

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case chainID = "chain_id"
        case name
        case shortName = "short_name"
        case address, city, phone, latitude, longitude, web, zone
    }
}

enum City: String, Codable {
    case berlin = "Berlin"
    case bernau = "Bernau"
    case düsseldorf = "Düsseldorf"
    case hennigsdorf = "Hennigsdorf"
    case kleinmachnow = "Kleinmachnow"
}

enum Zone: String, Codable {
    case europeBerlin = "Europe/Berlin"
}
