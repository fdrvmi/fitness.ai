//
//  MError.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import SwiftUI

struct MError: View {

    let message: String

    var body: some View {
        HStack(spacing: 8.0) {
            Image(.Icon.error)
            Text(message)
        }
        .foregroundStyle(.white)
        .font(.leadText)
        .padding(.vertical, 8.0)
        .padding(.horizontal, 22.0)
        .background(Color.Elements.red)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .transition(.opacity)
    }
}

#Preview {
    MError(message: "Потеряно соединение с сервером. Обновите страницу или попробуйте позже")
}
