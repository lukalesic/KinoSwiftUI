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
    
    @ObservedObject var viewModel: MoviesViewModel
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        switch viewModel.loadingState {
        case .empty:
            Color.clear
                .task {
                    await viewModel.loadMovieData()
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
                    await viewModel.loadMovieData()
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
                            ProgressView()
                                .frame(width: 100, height: 220)
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
                            
                            ForEach(category.movies, id: \.movieID)  { movie in
                                NavigationLink {
                                    MovieDetailScreen(photoURL: movie.posterURL, title: movie.title, pgRating: movie.pgRating)
                                } label: {
                                    ZStack{
                                        AsyncImage(url: URL(string: movie.photoURL)){ image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .shadow(radius: 6)
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        LinearGradient(colors: [.black.opacity(0), .black.opacity(0.55)],
                                                       startPoint: .top,
                                                       endPoint: .bottom)
                                        
                                        VStack{
                                            Spacer()
                                            Text(movie.title)
                                                .foregroundColor(.white)
                                                .fontWeight(.medium)
                                                .padding()
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                            Button {
                                
                            } label: {
                                Text("Load more")
                            }.buttonStyle(.borderedProminent)
                        }
                        
                        //iPadOS Specific:
                        else {
                            LazyVGrid(columns: adaptiveColumns) {
                                ForEach(category.movies, id: \.movieID)  { movie in
                                    VStack{
                                        NavigationLink {
                                            MovieDetailScreen(photoURL: movie.posterURL, title: movie.title, pgRating: movie.pgRating)
                                        } label: {
                                            AsyncImage(url: URL(string: movie.photoURL)){ image in
                                                image
                                                    .resizable()
                                                    .cornerRadius(9)
                                                    .shadow(radius: 9)
                                                    .aspectRatio(contentMode: .fit)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            Text(movie.title).lineLimit(1)
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }.padding()
                        }
                        
#else
                        //macOS specific:
                        LazyVGrid(columns: adaptiveColumns) {
                            ForEach(category.movies, id: \.movieID)  { movie in
                                VStack{
                                    NavigationLink {
                                        MovieDetailScreen(photoURL: movie.posterURL, title: movie.title, pgRating: movie.pgRating)
                                    } label: {
                                        AsyncImage(url: URL(string: movie.photoURL)){ image in
                                            image
                                                .resizable()
                                                .cornerRadius(9)
                                                .shadow(radius: 9)
                                                .aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                    Text(movie.title).lineLimit(1)
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
