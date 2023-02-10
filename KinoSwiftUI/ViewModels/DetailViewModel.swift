//
//  DetailViewModel.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 10.02.2023..
//

import Foundation

enum DetailType {
    case tvShowDetails
    case movieDetails
}

@MainActor
class DetailViewModel: ObservableObject {
    let repo = DetailRepo()
    
    @Published var movieDetailBaseItem: MovieDetail?
    @Published var tvShowDetailBaseItem : TvShowDetail?
    @Published var summary: String?
    @Published var cinemas: [Cinema]?
    @Published var people: [Person]?
    var id: Int?
    
    func loadData(id: Int, type: DetailType) async {
        Task{
            do{
                switch type {
                    
                case .movieDetails:
                    self.movieDetailBaseItem = try await self.repo.fetchDetailContent(element: movieDetailBaseItem, type: .movies, id: id)
                    self.summary = movieDetailBaseItem?.summary
                    self.cinemas = self.movieDetailBaseItem?.cinemas
                    self.people = self.movieDetailBaseItem?.people
                    
                case .tvShowDetails:
                    self.tvShowDetailBaseItem = try await self.repo.fetchDetailContent(element: tvShowDetailBaseItem, type: .tvShows, id: id)
                    self.summary = tvShowDetailBaseItem?.summary
                }
            }
            catch{
                print(error)
            }
        }
    }
}
