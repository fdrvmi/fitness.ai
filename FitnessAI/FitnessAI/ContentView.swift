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

    var body: some View {
        NavigationStack(path: $navigation.path) {
            OnboardingModule()
        }
        .environment(navigation)
    }
}

#Preview {
    ContentView()
}
