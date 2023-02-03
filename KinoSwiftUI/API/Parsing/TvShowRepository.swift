//
//  TvShowRepository.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

class TvShowRepository {
    var offset = 0
    let limit = 30
    let uuid = UUID()
    
    func fetchShows() async throws -> Show {
        let url = URL(string: "\(ServerAPI.tvShows.baseURL)\(ServerAPI.tvShows.path)?offset=\(offset)&limit=\(limit)")!
        let urlSession = URLSession.shared
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        
        return try APIDecoder.decoder.decode(Show.self, from: data)
    }
    
    func loadNext() async throws {
        offset += limit
    }
    
    func loadPrevious() async throws  {
        if offset - limit >= 0
        {
            offset -= limit
        }
     //   return try await self.fetchShows()
    }
}
