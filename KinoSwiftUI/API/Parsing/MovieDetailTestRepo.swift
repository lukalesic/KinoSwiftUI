//
//  BaseRepository.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

class MovieDetailTestRepo {
    
    //let uuid = UUID()
    

 /*   func fetchMovieDetailContent() async throws -> MovieDetailTest {
 
        let url = URL(string: "\(ServerAPI.movieDetail.baseURL)\(ServerAPI.movieDetail.path)")!
        print(url)
        let urlSession = URLSession.shared
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        urlRequest.setValue("Token token=47C27369-A7F6-4B78-A6CB-14A138493B15", forHTTPHeaderField: "Authorization")
       // urlRequest.setValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await urlSession.data(from: url)
        return try APIDecoder.decoder.decode(MovieDetailTest.self, from: data)

    }*/
    
    
    
    func fetchMovieDetailContent() -> MovieDetailTest {
       let url = URL(string: "\(ServerAPI.movieDetail.baseURL)\(ServerAPI.movieDetail.path)")!
       print(url)
       let urlSession = URLSession.shared
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "GET"
       urlRequest.setValue("Token token=47C27369-A7F6-4B78-A6CB-14A138493B15", forHTTPHeaderField: "Authorization")
       
       var movieDetail: MovieDetailTest?
       let semaphore = DispatchSemaphore(value: 0)
       
       urlSession.dataTask(with: urlRequest) { data, response, error in
          guard let data = data, error == nil else {
             print("error fetching movie detail")
             semaphore.signal()
             return
          }
          
          do {
             movieDetail = try APIDecoder.decoder.decode(MovieDetailTest.self, from: data)
          } catch let decodingError {
             print("error decoding movie detail: \(decodingError)")
          }
          
          semaphore.signal()
       }.resume()
       
       semaphore.wait()
       return movieDetail!
    }
     
}
