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
    @Published var baseItem: BaseResponse?
    
    var type: ServerAPI = {
        return ServerAPI.movies
    }()
    
    init(baseItem: BaseResponse? = nil, type: ServerAPI) {
        self.baseItem = baseItem
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
                self.baseItem = try await self.repo.fetchContent(element: baseItem, type: type)
                self.categories = self.baseItem!.categories
                
                for movie in self.categories.first!.items {
                    self.movies.append(contentsOf: movies)
                }
                
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
