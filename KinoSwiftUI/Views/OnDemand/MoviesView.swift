//
//  MoviesView.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//
/*
 */

import SwiftUI

struct MoviesView: View {
    
    @State private var selectedMovie: Movie?
    @ObservedObject var viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.loadingContent {
        case .empty:
            Color.clear
                .task {
                    await viewModel.loadContent()
                }
            
        case.loading:
            VStack{
                Spacer()
                ProgressView()
            }
            
        case .error(let error):
            Text(error.localizedDescription)
            Button(action: {
                Task {
                    await viewModel.loadContent()
                }
            }, label: {
                Text("Retry")
            }).buttonStyle(.borderedProminent)
            
        case .populated:
            VStack{
                ForEach($viewModel.spotlight, id: \.spotlightID) { $spotlight in
                    ZStack(alignment: .bottom){
                        AsyncImage(url: URL(string: spotlight.photoURL))  {image in
                            image.resizable()
                                .cornerRadius(12)
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 220)
                                .shadow(radius: 9)
                                .padding(.horizontal)
                        } placeholder: {
                        }
                        
                        VStack{
                            Spacer()
                            Text(spotlight.title)
                                .foregroundColor(.white)
                                .font(.system(size: 26, weight: .bold))
                                .shadow(radius: 12)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 20)
                                .padding()
                            Spacer()
                        }
                    }
                    ForEach($viewModel.categories, id: \.categoryID) { $category in
                        HStack{
                            Text(category.name)
                                .shadow(radius: 5)
                                .font(.system(size: 22, weight: .bold))
                                .padding(.horizontal)
                            Spacer()
                        }.padding(.vertical)
#if os(iOS)
                        
                        //iPhone and iPod specific:
                        if UIDevice.current.userInterfaceIdiom != .pad {
                            
                            ForEach(viewModel.movies, id: \.title)  { movieDetailBaseItem in
                                NavigationLink {
                                    MovieDetailScreen(photoURL: movieDetailBaseItem.posterURL, title: movieDetailBaseItem.title, pgRating: movieDetailBaseItem.pgRating, id: movieDetailBaseItem.itemID)
                                } label: {
                                    ZStack{
                                        AsyncImage(url: URL(string: movieDetailBaseItem.photoURL)){ image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .shadow(radius: 6)
                                            
                                        } placeholder: {
                                        }
                                        
                                        LinearGradient(colors: [.black.opacity(0), .black.opacity(0.55)],
                                                       startPoint: .top,
                                                       endPoint: .bottom)
                                        
                                        VStack{
                                            Spacer()
                                            Text(movieDetailBaseItem.title)
                                                .foregroundColor(.white)
                                                .fontWeight(.medium)
                                                .padding()
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                            HStack{
                                Button {
                                    Task {
                                        await viewModel.loadMoreContent()
                                    }
                                } label: {
                                    Text("Load more")
                                }
                                .onAppear {
                                        Task{
                                        await viewModel.loadMoreContent()
                                        }
                                }
                                .buttonStyle(.borderedProminent)
                                
                            }
                        }
                        
                        //iPadOS Specific:
                        else {
                            LazyVGrid(columns: adaptiveColumns) {
                                ForEach(category.items, id: \.itemID)  { movieDetailBaseItem in
                                    VStack{
                                        NavigationLink {
                                            MovieDetailScreen(photoURL: movieDetailBaseItem.posterURL, title: movieDetailBaseItem.title, pgRating: movieDetailBaseItem.pgRating, id: movieDetailBaseItem.itemID)
                                        } label: {
                                            AsyncImage(url: URL(string: movieDetailBaseItem.photoURL)){ image in
                                                image
                                                    .resizable()
                                                    .cornerRadius(9)
                                                    .shadow(radius: 9)
                                                    .aspectRatio(contentMode: .fit)
                                            } placeholder: {
                                            }
                                            Text(movieDetailBaseItem.title).lineLimit(1)
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }.padding()
                        }
                        
#else
                        //macOS specific:
                        LazyVGrid(columns: adaptiveColumns) {
                            ForEach(category.items, id: \.self)  { movieDetailBaseItem in
                                VStack{
                                    
                                    NavigationLink(destination: MovieDetailScreen(photoURL: movieDetailBaseItem.posterURL, title: movieDetailBaseItem.title, pgRating: movieDetailBaseItem.pgRating, id: movieDetailBaseItem.itemID), tag: movieDetailBaseItem, selection: $selectedMovie){
                                        AsyncImage(url: URL(string: movieDetailBaseItem.photoURL)){ image in
                                            image
                                                .resizable()
                                                .cornerRadius(9)
                                                .shadow(radius: 9)
                                                .aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            
                                        } }.buttonStyle(PlainButtonStyle())
                                    Text(movieDetailBaseItem.title).lineLimit(1)
                                }
                            }
                        }.padding()
#endif
                    }
                }
            }
        }
    }
}
