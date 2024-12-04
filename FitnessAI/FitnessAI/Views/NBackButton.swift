//
//  NBackButton.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 21.11.2024.
//

import SwiftUI

struct NBackButton: View {

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(.Icon.arrow)
                    .rotationEffect(.degrees(180))

                Text("navbar.back")
            }
            .foregroundStyle(Color.Text.primaryWhite)
        }
    }
}

#Preview {
    NBackButton()
        .withAppBackground()
}
