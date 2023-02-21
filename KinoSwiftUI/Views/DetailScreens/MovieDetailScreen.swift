//
//  MovieDetailScreen.swift
//  Kino
//
//  Created by Luka Lešić on 11.01.2023..
//
import SwiftUI

struct MovieDetailScreen: View {
    @ObservedObject var viewModel = DetailViewModel()
    
    let screen = UIScreen.main.bounds
    let photoURL: String
    let title: String
    let pgRating: Int
    let id: Int
    
    var body: some View {
        
        switch viewModel.loadingState {
        case .empty:
            ZStack{
                Color.clear
                ProgressView()
            }
            .task {
                await viewModel.loadData(id: id, type: .movieDetails)
            }
            
        case .loading:
            ZStack{
                Color.clear
                ProgressView()
            }
        case .error(let error):
            Text(error.localizedDescription)
            Button(action: {
                Task {
                    await viewModel.loadData(id: id, type: .movieDetails)
                }
            }, label: {
                Text("Retry")
            }).buttonStyle(.borderedProminent)
            
        case .populated:
            
            ZStack{
                Color.clear.overlay(
                    AsyncImage(url: URL(string: photoURL)) {image in
                        image
                            .resizable()
                            .frame(width: screen.width, height: screen.height)
                            .blur(radius: 40)
                            .brightness(-0.3)
                    }placeholder: {
                    }
                )
                
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
                    VStack(spacing: -3){
                        if viewModel.cinemas?.isEmpty == false {
                            HStack{
                                
                                Image(systemName: "popcorn.circle")
                                Text("Playing in movies:")
                                    .font(.system(size: 16, weight: .medium))
                            }.foregroundColor(.white)
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.cinemas?.prefix(10) ?? [], id: \.self) { cinema in
                                    VStack{
                                        Text(cinema.name)
                                        Text(cinema.city.rawValue)
                                            .font(.footnote)
                                    }.padding(.horizontal)
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 5))
                                }.font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.white)
                            }.padding()
                        }
                    }
                    
                    VStack(spacing: -10){
                        HStack{
                            Image(systemName: "person.circle")
                            Text("People:")
                                .font(.system(size: 16, weight: .medium))
                        }                            .foregroundColor(.white)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: -18){
                                ForEach(viewModel.people?.prefix(10) ?? [], id: \.self) { person in
                                    VStack{
                                        VStack(spacing: -16){
                                            AsyncImage(url: URL(string: person.photoURL)){ image in
                                                image
                                                    .resizable()
                                                    .cornerRadius(15)
                                                
                                                    .scaleEffect(0.7)
                                                    .cornerRadius(11)
                                                
                                            }placeholder: {
                                            }
                                            
                                            Text(person.name)
                                        }
                                        Text(person.role?.rawValue ?? "")
                                            .font(.footnote)
                                    }
                                }.font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
            }
            
        }
        
    }
    
}

