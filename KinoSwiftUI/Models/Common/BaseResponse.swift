//
//  BaseModel.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 06.02.2023..
//

import Foundation

class BaseResponse: Decodable {
    let spotlight: Spotlight
    let categories: [Category]
    let loadMore: String

    enum CodingKeys: String, CodingKey {
        case spotlight, categories
        case loadMore = "load_more"
    }
    
    required init(spotlight: Spotlight, categories: [Category], loadMore: String) {
        self.spotlight = spotlight
        self.categories = categories
        self.loadMore = loadMore
    }
    
}


