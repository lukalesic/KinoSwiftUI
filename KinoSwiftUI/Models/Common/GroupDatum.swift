//
//  GroupDatum.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

// MARK: - GroupDatum
struct GroupDatum: Codable {
    let cinemaID: Int
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case data
    }
}
