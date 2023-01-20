//
//  CinemasView.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//

import SwiftUI

struct CinemasView: View {
    @ObservedObject var viewModel: CinemasViewModel
    
    init(viewModel: CinemasViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.loadingState {
        case .empty:
            Color.clear
                .task {
                    await viewModel.loadMovieData()
                }
            
        case .loading:
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
            ScrollView{
                VStack{
                    
                    ForEach($viewModel.spotlight, id: \.spotlightID) { $spotlight in
                        ZStack(alignment: .bottom){
                            AsyncImage(url: URL(string: spotlight.photoURL))  {image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 220)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 220)
                            }
                            ImageBlurView()
                            
                            VStack{
                                Spacer()
                                Text(spotlight.title)
                                    .foregroundColor(.white)
                                    .font(.system(size: 26, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 20)
                            }    .shadow(radius: 11)
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
                        
                        
                        LazyVGrid(columns: adaptiveColumns) {
                            ForEach(category.movies, id: \.movieID)  { movie in
                                VStack{
                                    NavigationLink(destination: MovieDetailScreen(photoURL: movie.posterURL, title: movie.title, pgRating: movie.pgRating)){
                                        AsyncImage(url: URL(string: movie.posterURL)){ image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .cornerRadius(9)
                                                .shadow(radius: 6)
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                    
                                    Text(movie.title)
                                        .lineLimit(1)
                                        .font(.system(size: 12))
                                    
                                    HStack{
                                        //  ForEach(movie.genre, id: \.self) {genre in
                                        Text(movie.genre.first ?? "")
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                            .font(.system(size: 10))
                                    }
                                    
                                    
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
}
