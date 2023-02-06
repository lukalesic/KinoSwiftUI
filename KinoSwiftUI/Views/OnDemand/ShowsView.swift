//
//  ShowsView.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//

import SwiftUI
import Combine

struct ShowsView: View {
    
    @ObservedObject var viewModel: ShowsViewModel
    @State var selectedShow: TvShow?

    
    init(viewModel: ShowsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        switch viewModel.loadingState {
        case .empty:
            Color.clear
                .task {
                    await viewModel.loadData()
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
                    await viewModel.loadData()
                }
            }, label: {
                Text("Retry")
            }).buttonStyle(.borderedProminent)
            
        case .populated:
            
            ScrollView{
                VStack(spacing: 0.6){
                    ForEach($viewModel.spotlight, id: \.spotlightID) { $spotlight in
                        ZStack(alignment: .bottom){
                            AsyncImage(url: URL(string: spotlight.photoURL))  {image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 220)
                            } placeholder: {
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
                    }.padding(.top, 7)
                    
                    ForEach($viewModel.categories, id: \.categoryID) { $category in
                        HStack{
                            Text(category.name)
                                .shadow(radius: 5)
                                .font(.system(size: 22, weight: .bold))
                                .padding(.horizontal)
                            Spacer()
                        }.padding(.vertical)
                        
                        
#if os(iOS)
                        //iPhone and iPod specific
                        if UIDevice.current.userInterfaceIdiom != .pad {
                            ForEach(viewModel.tvShows, id: \.title)  { show in
                                NavigationLink {
                                    TVShowDetailScreen(photoURL: show.photoURL, title: show.title, pgRating: show.pgRating, id: show.tvShowID)
                                } label: {
                                    ZStack{
                                        AsyncImage(url: URL(string: show.photoURL)){ image in
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
                                            Text(show.title)
                                                .foregroundColor(.white)
                                                .fontWeight(.medium)
                                                .padding()
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                            
                            
                        }
                        //iPadOS specific
                        else {
                            LazyVGrid(columns: adaptiveColumns) {
                                ForEach(category.tvShows, id: \.title)  { show in
                                    VStack{
                                        NavigationLink {
                                            TVShowDetailScreen(photoURL: show.photoURL, title: show.title, pgRating: show.pgRating, id: show.tvShowID)
                                        } label: {
                                            AsyncImage(url: URL(string: show.photoURL)){ image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(9)
                                                    .shadow(radius: 9)
                                                 
                                            } placeholder: {
                                            }
                                        }.buttonStyle(PlainButtonStyle())
                                        Text(show.title).lineLimit(1)

                                    }
                                }
                            }.padding()
                        }
                        
#else
                        //macOS specific
                        LazyVGrid(columns: adaptiveColumns) {
                            ForEach(category.tvShows, id: \.self)  { show in
                                
                                VStack{

                                    NavigationLink(destination: TVShowDetailScreen(photoURL: show.photoURL, title: show.title, pgRating: show.pgRating, id: show.tvShowID), tag: show, selection: $selectedShow) {
                       
                                        AsyncImage(url: URL(string: show.photoURL)){ image in
                                            image
                                                .resizable()
                                                .cornerRadius(9)
                                                .shadow(radius: 9)
                                                .aspectRatio(contentMode: .fit)
                                        } placeholder: {

                                        }
                                       
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                   
                                 
                                    Text(show.title).lineLimit(1)
                                }
                                .onTapGesture {
                                         self.selectedShow = show
                                    print(selectedShow!.title)
                                  }

                            }
                        }.padding()
#endif
                    }
                    HStack{
                        Button {
                            Task{
                                await viewModel.loadNext()
                            }
                        } label: {
                            Text("Load more")
                        }.buttonStyle(BorderedProminentButtonStyle())
                    }.padding()
                    
                }
            }
            
        }
    }
}
