//
//  ComingSoonView.swift
//  Kino
//
//  Created by Luka Lešić on 11.01.2023..
//

import SwiftUI

struct ComingSoonView: View {
    @ObservedObject var viewModel: MovieBaseViewModel

    @State private var selectedMovie: Movie?
    
    init(viewModel: MovieBaseViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        switch viewModel.loadingContent {
        case .empty:
            Color.clear
                .task {
                    await viewModel.loadContent()
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
                    await viewModel.loadContent()
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
                                    
                                    NavigationLink(destination: MovieDetailScreen(photoURL: movie.posterURL, title: movie.title, pgRating: movie.pgRating), tag: movie, selection: $selectedMovie){
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
