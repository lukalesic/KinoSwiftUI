//
//  KinoApp.swift
//  Kino
//
//  Created by Luka Lešić on 06.01.2023..
//

import SwiftUI
import UserNotifications

@main
struct KinoApp: App {
    let center = UNUserNotificationCenter.current()
    
    init() {
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if let error = error {
                // Handle the error here.
            }
            // Enable or disable features based on the authorization.
        })
    }
    var body: some Scene {
        WindowGroup {
        #if os(macOS)
            SidebarView()
        #else
            ContentView()
        #endif
        }
    }
}
