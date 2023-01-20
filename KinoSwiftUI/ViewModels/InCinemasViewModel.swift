//
//  InCinemasViewModel.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

enum InCinemasLoadingState {
  case empty
  case loading
  case error(error: Error)
  case populated
}

@MainActor
class CinemasViewModel: ObservableObject {
    @Published private(set) var loadingState: InCinemasLoadingState = .empty
    let repo = InCinemasRepository()
    
    @Published var welcome: Welcome?
    @Published var movies = [Movie]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [MovieCategory]()
    
    func loadMovieData() async {

            Task{
                self.loadingState = .loading
                do{
                    self.welcome = try await self.repo.fetchMovies()
                    self.categories = self.welcome!.categories
                    self.movies = self.categories.first!.movies
                    self.spotlight.removeAll()
                    try self.spotlight.insert(self.welcome!.spotlight, at: 0)
                    self.loadingState = .populated
}
                catch{
                    self.loadingState = .error(error: error)
                    print(error)
                }
            }
    }
}
