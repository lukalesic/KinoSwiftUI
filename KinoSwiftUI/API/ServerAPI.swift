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
            return "/data/movies/658032?latitude=52.52&longitude=13.4"
        }
    }
    
    //example generic fetch data function - for testing
/*
    static func fetchData<T: Decodable>(element: T) async throws -> T {
        let url = URL(string: "https://kinode-api.herokuapp.com/1.1.0/services/tv_shows")!
        let urlSession = URLSession.shared
        
        let (data, _) = try await urlSession.data(from: url)
        return try APIDecoder.decoder.decode(T.self, from: data)
    }
    
    */
}
