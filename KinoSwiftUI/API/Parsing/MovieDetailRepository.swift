//
//  MovieRepository.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

class MovieDetailRepository {
    let uuid = UUID()
    
    func fetchMovieDetails() async throws -> MovieDetail {
        let url = URL(string: "\(ServerAPI.movieDetail.baseURL)\(ServerAPI.movieDetail.path)")!
        let urlSession = URLSession.shared
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")

        
            let (data, _) = try await urlSession.data(for: urlRequest)
            return try APIDecoder.decoder.decode(MovieDetail.self, from: data)
      
    }
}
