//
//  ImageBlurView.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import SwiftUI

struct ImageBlurView: View {
    var body: some View {
        Rectangle()
               .fill(.thinMaterial)
               .frame(height: 70)
               .mask {
                   VStack(spacing: 0) {
                       LinearGradient(colors: [Color.black.opacity(0),
                                               Color.black.opacity(0.383),
                                               Color.black.opacity(0.707),
                                               Color.black.opacity(0.924),
                                               Color.black],
                                      startPoint: .top,
                                      endPoint: .bottom)
                           .frame(height: 40)
                       Rectangle()
                   }
               }
    }
}
