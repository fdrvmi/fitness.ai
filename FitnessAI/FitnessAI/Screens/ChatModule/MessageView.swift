//
//  MessageView.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 17.12.2024.
//

import SwiftUI

struct MessageView: View {

    let message: Message
    var isInvalid = false

    var body: some View {
        HStack(alignment: .top, spacing: 12.0) {
            Text(message.content)
                .font(.default)

            if message.isAi {
                Button {
                    UIPasteboard.general.string = message.content
                } label: {
                    Image(.Icon.copy)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .buttonStyle(.plain)
            }
        }
        .foregroundStyle(Color.Text.primaryWhite)
        .padding(.top, 13)
        .padding(.bottom, 29)
        .padding(.horizontal, 16.0)
        .background {
            if isInvalid {
                RoundedRectangle(
                    cornerRadius: 8.0
                )
                .stroke(Color.Elements.red, lineWidth: 1.0)
            }
        }
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#Preview {
    MessageView(
        message: Message(
            id: "",
            content: "Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. Текст сообщения в несколько строк. ",
            isAi: true,
            createdAt: ""
        ),
        isInvalid: true
    )
    .withAppBackground()
}
