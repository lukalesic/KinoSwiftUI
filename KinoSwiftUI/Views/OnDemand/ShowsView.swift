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
                LazyVStack(spacing: 0.6){
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
                            
                            ForEach(viewModel.tvShows, id: \.title)  { showBaseItem in
                                NavigationLink {
                                    TVShowDetailScreen(photoURL: showBaseItem.photoURL, title: showBaseItem.title, pgRating: showBaseItem.pgRating, id: showBaseItem.itemID)
                                } label: {
                                    ZStack{
                                        AsyncImage(url: URL(string: showBaseItem.photoURL)){ image in
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
                                            Text(showBaseItem.title)
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
                                ForEach(category.items, id: \.title)  { showBaseItem in
                                    VStack{
                                        NavigationLink {
                                            TVShowDetailScreen(photoURL: showBaseItem.photoURL, title: showBaseItem.title, pgRating: showBaseItem.pgRating, id: showBaseItem.itemID)
                                        } label: {
                                            AsyncImage(url: URL(string: showBaseItem.photoURL)){ image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(9)
                                                    .shadow(radius: 9)
                                                
                                            } placeholder: {
                                            }
                                        }.buttonStyle(PlainButtonStyle())
                                        Text(showBaseItem.title).lineLimit(1)
                                    }
                                }
                            }.padding()
                        }
                        
#else
                        //macOS specific
                        LazyVGrid(columns: adaptiveColumns) {
                            ForEach(category.items, id: \.self)  { showBaseItem in
                                
                                VStack{
                                    
                                    NavigationLink(destination: TVShowDetailScreen(photoURL: showBaseItem.photoURL, title: showBaseItem.title, pgRating: showBaseItem.pgRating, id: showBaseItem.itemID), tag: showBaseItem , selection: $selectedShow) {
                                        
                                        AsyncImage(url: URL(string: showBaseItem.photoURL)){ image in
                                            image
                                                .resizable()
                                                .cornerRadius(9)
                                                .shadow(radius: 9)
                                                .aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            
                                        }
                                        
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    
                                    Text(showBaseItem.title).lineLimit(1)
                                }
                                .onTapGesture {
                                    self.selectedShow = showBaseItem
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
                            .onAppear {
                                    Task{
                                    await viewModel.loadNext()
                                    }
                            }.padding()
                        
                    }
                }
            }
        }
    }
}
