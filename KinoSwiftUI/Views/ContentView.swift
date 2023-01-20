//
//  ContentView.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
            TabView{
               
                OnDemandView()

                    .tabItem() {
                        Label("On demand", systemImage: "tv")
                    }
                InCinemasParentView()

                    .tabItem {
                        Label("In Cinemas", systemImage: "popcorn")
                    }
                
        }

    }
}
