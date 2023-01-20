//
//  MovieRepository.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

class ComingSoonRepository {
    
    func fetchMovies() async throws -> Welcome {
        let url = URL(string: "\(ServerAPI.comingSoon.baseURL)\(ServerAPI.comingSoon.path)")!
        let urlSession = URLSession.shared
        
            let (data, _) = try await urlSession.data(from: url)
            return try APIDecoder.decoder.decode(Welcome.self, from: data)
      
    }
}
