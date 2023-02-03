//
//  OnDemandView.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//

import SwiftUI
struct OnDemandView: View {
    @ObservedObject var viewModel = OnDemandViewModel()
    @ObservedObject var showsViewModel = ShowsViewModel()
    @ObservedObject var moviesViewModel = MovieBaseViewModel(type: ServerAPI.movies)


    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $viewModel.selectedContent) {
                    ForEach(SelectedContent.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.top, 4)
                .padding(.bottom, 4)
                .padding(.horizontal)
                
                ScrollView{
                    ActiveView(viewModel: viewModel, showsViewModel: showsViewModel, moviesViewModel: moviesViewModel)
                }
            }
        }
#if os(iOS)
.navigationViewStyle(StackNavigationViewStyle())
#endif

    }
}

struct ActiveView: View {
    @ObservedObject var viewModel: OnDemandViewModel
    @ObservedObject var showsViewModel: ShowsViewModel
    @ObservedObject var moviesViewModel: MovieBaseViewModel


    var body: some View {
        switch viewModel.selectedContent {
        case .shows:
            ShowsView(viewModel: showsViewModel)
        case .movies:
            MoviesView(viewModel: moviesViewModel)
        }
    }
}

enum SelectedContent: String, CaseIterable {
    case shows = "Shows"
    case movies = "Movies"
}
