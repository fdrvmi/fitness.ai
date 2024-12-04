//
//  AppBackground.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI

struct AppBackground: View {
    var body: some View {
        Color.Background.primary
            .overlay(alignment: .top) {
                Circle()
                    .fill(Color.Background.elipse)
                    .alignmentGuide(.top) { dims in
                        dims.height / 3
                    }
                    .blur(radius: 146.3)
            }
            .ignoresSafeArea()
    }
}

extension View {

    func withAppBackground() -> some View {
        ZStack {
            AppBackground()
            self
        }
    }
}

#Preview {
    AppBackground()
}
