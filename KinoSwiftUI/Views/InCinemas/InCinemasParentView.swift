//
//  OnDemandView.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//

import SwiftUI

enum SelectedMovieContent: String, CaseIterable {
    case incinemas = "In Cinemas"
    case comingsoon = "Coming Soon"
}

struct InCinemasParentView: View {
    @ObservedObject var viewModel = InCinemasParentViewModel()
    @ObservedObject var cinemasVM = MovieBaseViewModel(type: ServerAPI.inCinemas)
    @ObservedObject var comingSoonVM = MovieBaseViewModel(type: ServerAPI.comingSoon)
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                Picker("", selection: $viewModel.selectedMovies) {
                    ForEach(SelectedMovieContent.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.top, 4)
                .padding(.bottom, 4)
                .padding(.horizontal)
                
                ScrollView{
                    ActiveMovieView(viewModel: viewModel, cinemasViewModel: cinemasVM, comingSoonViewModel: comingSoonVM)                }
            }
        }
#if os(iOS)
        .navigationViewStyle(StackNavigationViewStyle())
#endif
        
    }
}

struct ActiveMovieView: View {
    @ObservedObject var viewModel: InCinemasParentViewModel
    @ObservedObject var cinemasViewModel: MovieBaseViewModel
    @ObservedObject var comingSoonViewModel: MovieBaseViewModel
    
    
    var body: some View {
        switch viewModel.selectedMovies {
        case .incinemas:
            CinemasView(viewModel: cinemasViewModel)
        case .comingsoon:
            ComingSoonView(viewModel: comingSoonViewModel)
        }
    }
}
