//  JSONDecoder.swift
//  Kino
//  Created by Luka Lešić on 08.01.2023..


import Foundation
import Combine
import SwiftUI

enum TvShowLoadingState {
    case empty
    case loading
    case error(error: Error)
    case populated
}

@MainActor
class ShowsViewModel: ObservableObject {
    @Published private(set) var loadingState: TvShowLoadingState = .empty
    let repo = BaseRepository()
    
    @Published var tvShows = [TvShow]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [Category]()
    @Published var show : Show?
    private var cancellable: AnyCancellable?
    var selectedOption: TvShow?
    
    @Published var hasShownProgressView = false

    
    
    func loadData() async {
        
        Task{
            self.loadingState = .loading
            do{
                self.show = try await self.repo.fetchAllContent(element: show, type: .tvShows)
                self.categories = self.show!.categories
                for show in self.categories.first!.tvShows {
                    self.tvShows.append(show)
                }
                self.spotlight.removeAll()
                try self.spotlight.insert(self.show!.spotlight, at: 0)
                
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
                    self.show = try await self.repo.fetchAllContent(element: show, type: .tvShows)
                    for show in self.show!.categories.first!.tvShows {
                        self.tvShows.append(show)
                    }

                }
            }
        }
    }
