//
//  TVShowDetailScreen.swift
//  Kino
//
//  Created by Luka Lešić on 12.01.2023..
//

import SwiftUI

struct TVShowDetailScreen: View {
    let photoURL: String
    let title: String
    let pgRating: Int

    var body: some View {
            ScrollView{
                VStack(spacing: 0){
                    
                    AsyncImage(url: URL(string: photoURL)) { image in
                        image
                            .resizable()
                        //.frame(width: screen.width / 1.3)
                            .cornerRadius(12)
                           .frame(maxWidth: 700)
                            .scaledToFit()
                        //   .scaleEffect(0.4)
                            .shadow(radius: 6)
                            .padding()
                        
                    } placeholder: {
                    }
                    Spacer()
                    Text(title)
                        .font(.system(size: 23, weight: .medium))
                    Text("PG Rating: \(pgRating)")
                    Spacer()
                }
            }
    }

}

