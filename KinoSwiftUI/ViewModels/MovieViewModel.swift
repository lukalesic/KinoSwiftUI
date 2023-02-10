//
//  BaseViewModel.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

enum LoadingState {
  case empty
  case loading
  case error(error: Error)
  case populated
}

@MainActor
class MovieViewModel: ObservableObject {
    @Published var movieBaseItem: BaseResponse?
    
    var type: ServerAPI = {
        return ServerAPI.movies
    }()
    
    init(baseItem: BaseResponse? = nil, type: ServerAPI) {
        self.movieBaseItem = baseItem
        self.type = type
    }
    
    let repo = BaseRepository()
    
    @Published private(set) var loadingContent: LoadingState = .empty
    @Published var movies = [BaseItem]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [Category]()
    @Published var loadMore: String?
 
    func loadContent() async {
        Task{
            self.loadingContent = .loading
            do{
                self.movieBaseItem = try await self.repo.fetchContent(element: movieBaseItem, type: .movies)
                self.categories = self.movieBaseItem!.categories
                
                for movie in self.categories.first!.items {
                    self.movies.append(movie)
                }
                
                self.spotlight.removeAll()
                try self.spotlight.insert(self.movieBaseItem!.spotlight, at: 0)
                self.loadingContent = .populated
}
            catch{
                self.loadingContent = .error(error: error)
                print(error)
            }
        }
    }
    
    func loadMoreContent() async {
        Task {
            do{
                try await self.repo.loadMoreContent()
                self.movieBaseItem = try await self.repo.fetchContent(element: movieBaseItem, type: type)
                for movie in self.movieBaseItem!.categories.first!.items {
                    self.movies.append(movie as! Movie)
                }
                print(self.movies.count)
            }
        }
    }
    
}
