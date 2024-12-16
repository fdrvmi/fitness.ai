//
//  QuickChatModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import SwiftUI

struct QuickChatModule: View {

    @State private var viewModel = QuickChatViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                contentView
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16.0)
                    .background(
                        Color.white
                            .opacity(0.08)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    .padding(.horizontal, 16.0)
            }
            .withAppBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AIChat")
                        .foregroundColor(.white)
                }
            }
        }
    }

    private var contentView: some View {
        VStack {
            Text("Чем я могу Вам помочь? ")
                .font(.h2)
                .foregroundStyle(Color.Text.primaryWhite)

            cards

            MInput(value: $viewModel.query, placeholder: "Напишите запрос")
        }
    }

    private var cards: some View {
        VStack {

            HStack {
                card(for: "План питания", icon: Image(.Icon.food)) {

                }

                card(for: "План тренировок", icon: Image(.Icon.sport)) {

                }
            }

            HStack {
                card(for: "Советы по здоровью", icon: Image(.Icon.health)) {

                }

                card(for: "Чеклисты привычек", icon: Image(.Icon.checklist)) {

                }
            }
        }
        .padding(.vertical, 32.0)
    }

    private func card(for text: String, icon: Image, action: () -> Void) -> some View {
        HStack {
            icon
                .resizable()
                .frame(width: 16, height: 16.0)
            Text(text)
                .font(.default)
        }
        .padding(.vertical, 6.0)
        .padding(.horizontal, 8.0)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.Elements.borderGreen, lineWidth: 1.0)
        }
        .foregroundStyle(Color.Text.primaryWhite)
    }
}

@Observable
class QuickChatViewModel {
    var query = ""

}

#Preview {
    QuickChatModule()
}
