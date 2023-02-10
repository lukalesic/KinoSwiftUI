//
//  MovieDetailew.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 10.02.2023..
//

import Foundation

class MovieDetail: DetailBaseItem {

    let contentURL: String
    let services: Services?
    let cinemas: [Cinema]?


    enum CodingKeys: String, CodingKey {
        case contentURL = "content_url"
        case services, cinemas

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contentURL = try container.decode(String.self, forKey: .contentURL)
        self.services = try container.decode(Services.self, forKey: .services)
        self.cinemas = try container.decodeIfPresent([Cinema].self, forKey: .cinemas)

        try super.init(from: decoder)
    }
}
