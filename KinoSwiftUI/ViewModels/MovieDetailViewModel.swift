//
//  InCinemasViewModel.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    let repo = DetailRepo()
    
    @Published var movieDetail: MovieDetail?
    
    @Published var movies = [Movie]()
    @Published var loadMore: String?
    @Published var summary: String?
    @Published var cinemas: [Cinema]?
    @Published var people: [Person]?
    
    var id: Int?
    
    func loadMovieData(id: Int) async {
        Task{
            do{
                self.movieDetail = try await self.repo.fetchMovieDetailContent(id: id)
                self.summary = movieDetail?.summary
                self.cinemas = self.movieDetail?.cinemas
                self.people = self.movieDetail?.people
                
            }
            catch{
                print(error)
            }
        }
    }
}
