//
//  ChatListModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import SwiftUI

struct ChatListModule: View {

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(0..<20) { i in
                        ChatListCell(
                            title: "Title",
                            subtitle: "Subtitle",
                            time: "14:40"
                        ) {

                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0))
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .listRowSpacing(12.0)
            }
            .withAppBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AIChat")
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(
                Color.Background.primary,
                for: .navigationBar
            )
        }
    }
}

#Preview {
    ChatListModule()
}
