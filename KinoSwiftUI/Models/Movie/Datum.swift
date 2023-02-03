//
//  Datum.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation


// MARK: - Datum
struct Datum: Codable {
    let showtimeID, date: Int
    let dateString: String
    let inAppBooking: Bool
    let ticketLink: String
    let bookingLink: String
    let value: Value

    enum CodingKeys: String, CodingKey {
        case showtimeID = "showtime_id"
        case date
        case dateString = "date_string"
        case inAppBooking = "in_app_booking"
        case ticketLink = "ticket_link"
        case bookingLink = "booking_link"
        case value
    }
}

enum Value: String, Codable {
    case empty = ""
    case omu = "OMU"
}
