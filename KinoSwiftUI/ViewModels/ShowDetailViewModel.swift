//
//  InCinemasViewModel.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation

@MainActor
class TvShowDetailViewModel: ObservableObject {
    let repo = DetailRepo()
    @Published var tvShowDetailBaseItem : TvShowDetail?
        @Published var summary: String?
    var id: Int?
    
    func loadShowData(id: Int) async {
        Task{
            do{
                self.tvShowDetailBaseItem = try await self.repo.fetchDetailContent(element: tvShowDetailBaseItem, type: .tvShows, id: id)
                
                self.summary = tvShowDetailBaseItem?.summary
            }
            catch{
                print(error)
            }
        }
    }
}
