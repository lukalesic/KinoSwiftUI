//
//  BaseViewModel.swift
//  KinoSwiftUI
//
//  Created by Luka Lešić on 31.01.2023..
//

import Foundation

enum MoviesLoadingState {
  case empty
  case loading
  case error(error: Error)
  case populated
}

@MainActor
class MovieBaseViewModel: ObservableObject {
    @Published var baseItem: Welcome?
    
    var type: ServerAPI = {
        return ServerAPI.movies
    }()
    
    init(baseItem: Welcome? = nil, type: ServerAPI) {
        self.baseItem = baseItem
        self.type = type
    }
    
    let repo = BaseRepository()
    
    @Published private(set) var loadingContent: MoviesLoadingState = .empty

    
    @Published var movies = [Movie]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [MovieCategory]()
    @Published var loadMore: String?

    
    func loadContent() async {
        Task{
            self.loadingContent = .loading
            do{
                self.baseItem = try await self.repo.fetchContent(element: baseItem, type: type)
                self.categories = self.baseItem!.categories
                self.movies = self.categories.first!.movies
                self.spotlight.removeAll()
                try self.spotlight.insert(self.baseItem!.spotlight, at: 0)
                self.loadingContent = .populated
}
            catch{
                self.loadingContent = .error(error: error)
                print(error)
            }
        }
    }
    
    func loadMoreContent() {}
    
}
