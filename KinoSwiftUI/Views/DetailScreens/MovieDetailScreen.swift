//
//  MovieDetailScreen.swift
//  Kino
//
//  Created by Luka Lešić on 11.01.2023..
//

import SwiftUI

struct MovieDetailScreen: View {
    @ObservedObject var viewModel = MovieDetailViewModel()
    
    let photoURL: String
    let title: String
    let pgRating: Int
    //let summary: String
    
    
    var body: some View {
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
                
                Text("PG Rating: \(pgRating)")
                    .font(.system(.footnote))
                
               // Text(summary)
                Spacer()
            }
    }
}



