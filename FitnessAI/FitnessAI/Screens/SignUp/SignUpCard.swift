//
//  SignUpCard.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 05.12.2024.
//

import SwiftUI

struct SignUpCard<Content: View>: View {

    var content: () -> Content

    var body: some View {
        content()
            .padding(.vertical, 32)
            .padding(.horizontal, 16.0)
            .background(
                Color.white
                    .opacity(0.08)
            )
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
    }
}
