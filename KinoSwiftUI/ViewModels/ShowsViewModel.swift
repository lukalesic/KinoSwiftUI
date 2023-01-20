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
  //  @Published var shouldShowLoading: Bool = false
    @Published private(set) var loadingState: TvShowLoadingState = .empty
    let repo = TvShowRepository()
    
    @Published var tvShows = [TvShow]()
    @Published var spotlight = [Spotlight]()
    @Published var categories = [Category]()
    @Published var show : Show?
    private var cancellable: AnyCancellable?
    
    @Published var hasShownProgressView = false

    
    
    func loadData() async {
        
        Task{
            self.loadingState = .loading
         //   shouldShowLoading = true
            do{
                self.show = try await self.repo.fetchShows()
                self.categories = self.show!.categories
               // self.tvShows = self.categories.first?.tvShows ?? []
             //   self.tvShows.append(contentsOf: self.categories.first!.tvShows)
                for show in self.categories.first!.tvShows {
                    self.tvShows.append(show)
                }
             //   dataArray.append(contentsOf: self.tvShows)
                self.spotlight.removeAll()
                try self.spotlight.insert(self.show!.spotlight, at: 0)
                
                self.loadingState = .populated
            //    self.shouldShowLoading = false
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

                    try await self.repo.loadNext()
             //       shouldShowLoading = true
                    self.show = try await self.repo.fetchShows()
                   // await self.loadData()
                    for show in self.show!.categories.first!.tvShows {
                        self.tvShows.append(show)
                    }
                //    self.shouldShowLoading = false

                }
            }
        }
        
        func loadPrevious() async {
            Task {
                do{
                    try await self.repo.loadPrevious()
                    await self.loadData()
                }
            }
        }
    }
