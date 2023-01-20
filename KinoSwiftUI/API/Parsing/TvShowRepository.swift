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
    
    func fetchShows() async throws -> Show {
        let url = URL(string: "\(ServerAPI.tvShows.baseURL)\(ServerAPI.tvShows.path)?offset=\(offset)&limit=\(limit)")!
        let urlSession = URLSession.shared
        
        let (data, _) = try await urlSession.data(from: url)
        return try APIDecoder.decoder.decode(Show.self, from: data)
    }
    
    func loadNext() async throws {
        offset += limit
       // return try await self.fetchShows()
    }
    
    func loadPrevious() async throws  {
        if offset - limit >= 0
        {
            offset -= limit
        }
     //   return try await self.fetchShows()
    }
}
