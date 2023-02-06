//
//  InCinemasViewModel.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
  //  let repo = BaseRepository()
    let repo = MovieDetailTestRepo()
    
    @Published var movieDetail: MovieDetailTest?
   // @Published var movieDetail = [MovieDetail]()

    @Published var movies = [Movie]()
    @Published var categories = [MovieCategory]()
    @Published var loadMore: String?
    @Published var summary: String?
    @Published var movieID: Int?

    
    func loadMovieData() async {
            Task{
                do{
                   // self.movieDetail = try await self.repo.fetchContent(element: movieDetail, type: .movieDetail)
                   self.movieDetail = try await self.repo.fetchMovieDetailContent()
                    self.movieID = try await self.repo.fetchMovieDetailContent().movieID

                    print("MOVIEID")
                    print(movieID)
                    self.summary = movieDetail?.summary
}
                catch{
                    print(error)
                }
            }
    }
}
