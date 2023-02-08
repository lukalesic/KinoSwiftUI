//
//  BaseRepository.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

class DetailRepo {
    
    let uuid = UUID()
    var url = URL(string: "")
    
    func fetchDetailContent<T: Decodable>(element: T, type: ServerAPI, id: Int) -> T {
        if type == .tvShows {
             url = URL(string: "\(ServerAPI.tvShowDetail.baseURL)\(ServerAPI.tvShowDetail.path)/\(id)")!
            print(url)
        }
        else {
             url = URL(string: "\(ServerAPI.movieDetail.baseURL)\(ServerAPI.movieDetail.path)\(id)?latitude=52.52&longitude=13.4")!
        }
        
        let urlSession = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")

        let semaphore = DispatchSemaphore(value: 0)
        var result: T?
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
           guard let data = data, error == nil else {
              print("error")
              semaphore.signal()
              return
           }
           
           do {
              result = try APIDecoder.decoder.decode(T.self, from: data)
           } catch let decodingError {
              print("error decoding: \(decodingError)")
           }
           
           semaphore.signal()
        }.resume()
        
        semaphore.wait()
        return result!
    }
}
