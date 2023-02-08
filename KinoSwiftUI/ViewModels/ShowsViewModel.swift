//  JSONDecoder.swift
//  Kino
//  Created by Luka Lešić on 08.01.2023..


import Foundation
import Combine
import SwiftUI

@MainActor
class ShowsViewModel: ObservableObject {
    @Published private(set) var loadingState: LoadingState = .empty
    let repo = BaseRepository()
    
    @Published var tvShows = [BaseItem]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [Category]()
    @Published var showBaseItem : BaseResponse?
    private var cancellable: AnyCancellable?
    var selectedOption: TvShow?
    
    @Published var hasShownProgressView = false

    func loadData() async {
        Task{
            self.loadingState = .loading
            do{
                self.showBaseItem = try await self.repo.fetchContent(element: showBaseItem, type: .tvShows)
                self.categories = self.showBaseItem!.categories
                
                for show in self.categories.first!.items {
                    self.tvShows.append(show)
                }
                
                self.spotlight.removeAll()
                try self.spotlight.insert(self.showBaseItem!.spotlight, at: 0)
                
                self.loadingState = .populated
            }
                catch{
                    self.loadingState = .error(error: error)
                    print(error)
                }
            }
        }
        
        
        func loadNext() async {
            Task {
                do{
                    self.hasShownProgressView = true

                    try await self.repo.loadMoreContent()
                    self.showBaseItem = try await self.repo.fetchContent(element: showBaseItem, type: .tvShows)
                    for show in self.showBaseItem!.categories.first!.items {
                        self.tvShows.append(show as! TvShow)
                    }

                }
            }
        }
    }
