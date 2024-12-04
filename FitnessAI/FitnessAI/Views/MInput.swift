//
//  MInput.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI

struct MInput: View {

    @Binding var value: String

    @FocusState var isFocused: Bool

    var placeholder: String?

    var body: some View {
        TextField(
            "",
            text: $value,
            prompt: Text(placeholder ?? "").foregroundStyle(Color.Text.secondaryWhite)
        )
        .foregroundStyle(isFocused ? Color.Text.primaryWhite : Color.Text.secondaryWhite)
        .padding(.horizontal, 24.0)
        .padding(.vertical, 11.0)
        .focused($isFocused)
        .onTapGesture {
            if !isFocused {
                isFocused.toggle()
            }
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.white.opacity(0.08))

                if isFocused {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.Text.primaryWhite, lineWidth: 1)
                }
            }
        )
    }
}

#Preview {
    MInput(value: .constant(""), placeholder: "Email")
        .padding()
        .background(Color.Background.primary)
}
