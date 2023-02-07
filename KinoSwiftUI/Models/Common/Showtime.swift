//
//  Showtime.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation
// MARK: - Showtime
struct Showtime: Codable {
    let groupID: String
    let groupData: [GroupDatum]

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case groupData = "group_data"
    }
}
