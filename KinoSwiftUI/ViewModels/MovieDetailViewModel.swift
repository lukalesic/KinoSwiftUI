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
    
    @Published var movieDetailBaseItem: MovieDetail?
    @Published var loadMore: String?
    @Published var summary: String?
    @Published var cinemas: [Cinema]?
    @Published var people: [Person]?
    var id: Int?
    
    func loadMovieData(id: Int) async {
        Task{
            do{
                self.movieDetailBaseItem = try await self.repo.fetchDetailContent(element: movieDetailBaseItem, type: .movies, id: id)
                self.summary = movieDetailBaseItem?.summary
                self.cinemas = self.movieDetailBaseItem?.cinemas
                self.people = self.movieDetailBaseItem?.people
            }
            catch{
                print(error)
            }
        }
    }
}
