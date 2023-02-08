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
    
    @Published var tvShowDetail: TvShowDetail?
    @Published var summary: String?
    var id: Int?
    
    func loadShowData(id: Int) async {
        Task{
            do{
                self.tvShowDetail = try await self.repo.fetchDetailContent(element: tvShowDetail, type: .tvShows, id: id)
                self.summary = tvShowDetail?.summary
            }
            catch{
                print(error)
            }
        }
    }
}
