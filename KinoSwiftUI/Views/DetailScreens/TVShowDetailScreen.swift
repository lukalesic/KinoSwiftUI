//
//  TVShowDetailScreen.swift
//  Kino
//
//  Created by Luka Lešić on 12.01.2023..
//

import SwiftUI

struct TVShowDetailScreen: View {
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
                await viewModel.loadData(id: id, type: .tvShowDetails)
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
                    await viewModel.loadData(id: id, type: .tvShowDetails)
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
                                .frame(maxWidth: 700)
                                .scaledToFit()
                                .shadow(radius: 6)
                                .padding()
                            
                        } placeholder: {
                        }
                        Spacer()
                        Text(title)
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.white)
                        Text("PG Rating: \(pgRating)")
                            .foregroundColor(.white)
                        Spacer()
                        
                        Text(viewModel.summary ?? "").foregroundColor(.white)
                            .padding()
                            .font(.footnote)
                    }
                }
            }
        }
        
    }
    
}
