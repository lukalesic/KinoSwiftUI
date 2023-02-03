//
//  InCinemasViewModel.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    let repo = MovieDetailRepository()
    
    @Published var movieDetail: MovieDetail?
    @Published var movies = [Movie]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [MovieCategory]()
    @Published var loadMore: String?
    @Published var summary: String?
    
    func loadMovieData() async {
            Task{
                do{
                    self.movieDetail = try await self.repo.fetchMovieDetails()
}
                catch{
                    print(error)
                }
            }
    }
}
