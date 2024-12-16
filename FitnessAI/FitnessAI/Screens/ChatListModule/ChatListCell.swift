//
//  ChatCell.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import SwiftUI

struct ChatListCell: View {

    var title: String
    var subtitle: String
    var time: String

    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            contentView
        }
        .buttonStyle(.plain)
    }

    private var contentView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.leadText)
                    .foregroundStyle(Color.Text.primaryWhite)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.Text.secondaryWhite)
            }

            Spacer()

            Text(time)
                .font(.caption)
                .foregroundStyle(Color.Text.secondaryWhite)
        }
        .padding(.vertical, 8.0)
        .padding(.horizontal, 12.0)
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#Preview {
    ChatListCell(
        title: "Тема чата",
        subtitle: "Последнее сообщение",
        time: "14:40"
    ) {

    }
    .padding()
    .withAppBackground()
}
