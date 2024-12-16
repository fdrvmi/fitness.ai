//
//  ContentView.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI

@Observable
final class ContentNavigation {
    var path: NavigationPath = NavigationPath()
}

struct ContentView: View {

    @State var navigation = ContentNavigation()

    var userManager = UserManager.shared

    var body: some View {
        contentView
            .animation(.easeInOut, value: userManager.user)
    }

    @ViewBuilder
    var contentView: some View {
        if KeychainManager.shared.loadToken(forKey: .refreshToken) != nil || KeychainManager.shared.loadToken(forKey: .accessToken) != nil || userManager.user != nil {
            MainModule()
                .task {
                    navigation.path.removeLast(navigation.path.count)
                    if userManager.user == nil {
                        await userManager.onLoad()
                    }
                }
        } else {
            NavigationStack(path: $navigation.path) {
                OnboardingModule()
            }
            .environment(navigation)
            .id(userManager.user?.id ?? "com.update")
        }
    }
}

#Preview {
    ContentView()
}
