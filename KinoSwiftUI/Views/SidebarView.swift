//
//  SideBarView.swift
//  Kino
//
//  Created by Luka Lešić on 09.01.2023..
//

import Foundation
import SwiftUI


#if os(macOS)
struct SidebarView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Services")
                Group{
                    NavigationLink(destination: OnDemandView()) {
                        Label("On demand", systemImage: "tv")
                    }
                    NavigationLink(destination: InCinemasParentView()) {
                        Label("In cinemas", systemImage: "popcorn")
                    }
            
                }
                Spacer()
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Explore")
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 300)
            .toolbar{
                ToolbarItem(placement: .navigation){
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            OnDemandView()
        }
    }
}


// Toggle Sidebar Function
func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

#endif

