//
//  MainModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 05.12.2024.
//

import SwiftUI

struct MainModule: View {

    @State private var index = 1

    var body: some View {
        TabView(selection: $index) {
            ChatListModule()
                .tabItem {
                    Image(.Icon.menu)
                }
                .tag(0)

            QuickChatModule()
                .tabItem {
                    Image(.Icon.health1)
                }
                .tag(1)

            ProfileModule()
                .tabItem {
                    Image(.Icon.person)
                }
                .tag(2)
        }
        .tint(.white)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(hex: "1C1C1C", alpha: 0.9)
            appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialDark)
            appearance.shadowColor = .white.withAlphaComponent(0.5)
            appearance.selectionIndicatorTintColor = .white

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainModule()
}
