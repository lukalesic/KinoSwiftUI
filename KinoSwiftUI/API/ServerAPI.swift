//
//  ServerAPI.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

enum ServerAPI {
    case tvShows
    case movies
    case inCinemas
    case comingSoon
    case movieDetail
    case tvShowDetail
}

extension ServerAPI {
    
    var baseURL: URL {
        return URL(string: "https://kinode-api.herokuapp.com/1.1.0")!
    }
    
    var path: String {
        switch self {
        case .tvShows:
            return "/services/tv_shows"
        case .inCinemas:
            return "/cinemas/in_cinemas?latitude=52.52&longitude=13.4"
        case .movies:
            return "/services/movies"
        case .comingSoon:
            return "/cinemas/coming_soon?latitude=52.52&longitude=13.4"
        case .movieDetail:
            return "/data/movies/"
        case .tvShowDetail:
            return "/data/tv_shows/"

        }
        
    }
}
