//
//  BaseRepository.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

class DetailRepo {
    
    let uuid = UUID()
    
    func fetchMovieDetailContent(id: Int) -> MovieDetail {

       let url = URL(string: "\(ServerAPI.movieDetail.baseURL)\(ServerAPI.movieDetail.path)\(id)?latitude=52.52&longitude=13.4")!

       let urlSession = URLSession.shared
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "GET"
       urlRequest.setValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")
       
       var movieDetail: MovieDetail?
       let semaphore = DispatchSemaphore(value: 0)
       
       urlSession.dataTask(with: urlRequest) { data, response, error in
          guard let data = data, error == nil else {
             print("error")
             semaphore.signal()
             return
          }
          
          do {
             movieDetail = try APIDecoder.decoder.decode(MovieDetail.self, from: data)
          } catch let decodingError {
             print("error decoding movie: \(decodingError)")
          }
          
          semaphore.signal()
       }.resume()
       
       semaphore.wait()
       return movieDetail!
    }
    
    
    func fetchShowDetailContent(id: Int) -> TvShowDetail {

     // id: 34643
     
       let url = URL(string: "\(ServerAPI.tvShowDetail.baseURL)\(ServerAPI.tvShowDetail.path)/\(id)")!
        print(url)

       let urlSession = URLSession.shared
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "GET"
       urlRequest.setValue("Token token=\(uuid)", forHTTPHeaderField: "Authorization")
       
       var tvShowDetail: TvShowDetail?
       let semaphore = DispatchSemaphore(value: 0)
       
       urlSession.dataTask(with: urlRequest) { data, response, error in
          guard let data = data, error == nil else {
             print("error")
             semaphore.signal()
             return
          }
          
          do {
             tvShowDetail = try APIDecoder.decoder.decode(TvShowDetail.self, from: data)
          } catch let decodingError {
             print("error decoding movie: \(decodingError)")
          }
          
          semaphore.signal()
       }.resume()
       
       semaphore.wait()
       return tvShowDetail!
    }
     
}
