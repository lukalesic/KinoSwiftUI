//
//  MovieDetailScreen.swift
//  Kino
//
//  Created by Luka Lešić on 11.01.2023..
//
import SwiftUI

struct MovieDetailScreen: View {
    @ObservedObject var viewModel = MovieDetailViewModel()
    
    let screen = UIScreen.main.bounds
    let photoURL: String
    let title: String
    let pgRating: Int
   // let summary: String? = ""
    
    var body: some View {
        
        ZStack{
            Color.clear.overlay(
            AsyncImage(url: URL(string: photoURL)) {image in
                image
                    .resizable()
                    .frame(width: screen.width, height: screen.height)
                    .blur(radius: 40)
                    .brightness(-0.3)
                    //.edgesIgnoringSafeArea(.all)
            }placeholder: {
            }
            )

                .task {
                    await viewModel.loadMovieData()
                }
            
            ScrollView{
                VStack(spacing: 0){
                    
                    AsyncImage(url: URL(string: photoURL)) { image in
                        image
                            .resizable()
                            .cornerRadius(12)
                            .frame(minWidth: 100.0, idealWidth: 120, maxWidth: 200, minHeight: 140, idealHeight: 200, maxHeight: 300, alignment: .center)
                            .scaledToFit()
                            .padding(.top, 8)
                            .shadow(radius: 6)
                    } placeholder: {
                    }
                    
                }
                Text(title)
                    .font(.system(size: 23, weight: .medium))
                    .foregroundColor(.white)
                
                Text("PG Rating: \(pgRating)")
                    .font(.system(.footnote))
                    .foregroundColor(.white)
                
                Text(viewModel.summary ?? " ")
                    .font(.footnote)
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
        }

    }
   
}



