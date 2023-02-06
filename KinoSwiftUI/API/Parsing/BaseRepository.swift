//
//  BaseRepository.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

class BaseRepository {
    
    var offset = 0
    let limit = 30
    let uuid = UUID()
    var url = URL(string: "")
    
    func fetchContent<T: Decodable>(element: T, type: ServerAPI) async throws -> T {
        
        if type == .tvShows {
            url = URL(string: "\(type.baseURL)\(type.path)?offset=\(offset)&limit=\(limit)")!
        } else {
            url = URL(string: "\(type.baseURL)\(type.path)")!
        }
        
        let urlSession = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"

        urlRequest.setValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")
        print(uuid)
        
        let (data, _) = try await urlSession.data(from: url!)
        return try APIDecoder.decoder.decode(T.self, from: data)
    }
        
    func loadMoreContent() async throws {
        offset += limit
    }
    
}
