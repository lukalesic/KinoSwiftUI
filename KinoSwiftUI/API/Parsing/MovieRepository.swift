//
//  MovieRepository.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

class MovieRepository {
    let uuid = UUID()
    
    func fetchMovies() async throws -> Welcome {
        let url = URL(string: "\(ServerAPI.movies.baseURL)\(ServerAPI.movies.path)")!
        let urlSession = URLSession.shared
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")

        
            let (data, _) = try await urlSession.data(for: urlRequest)
            return try APIDecoder.decoder.decode(Welcome.self, from: data)
      
    }
}
