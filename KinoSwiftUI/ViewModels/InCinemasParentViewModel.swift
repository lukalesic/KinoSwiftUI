//
//  InCinemasParentViewModel.swift
//  Kino
//
//  Created by Luka Lešić on 17.01.2023..
//

import Foundation

class InCinemasParentViewModel: ObservableObject {
    @Published var selectedMovies = SelectedMovieContent.incinemas
}
