//
//  ChatModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 16.12.2024.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct ChatModule: View {

    @State private var viewModel = ChatViewModel()

    let chatID: String?
    let initialMessage: String?

    init(chatID: String) {
        self.initialMessage = nil
        self.chatID = chatID
    }

    init(initialMessage: String) {
        self.chatID = nil
        self.initialMessage = initialMessage
    }

    var body: some View {
        VStack {
            if viewModel.showLoader {
                ProgressView()
                    .tint(.white)
            } else {
                contentView
            }
        }
        .padding(.horizontal, 16.0)
        .navigationTitle("AIChat")
        .navigationBarTitleDisplayMode(.inline)
        .withAppBackground()
        .task {
            if let chatID {
                await viewModel.fetch(id: chatID)
            }

            if let initialMessage {
                await viewModel.fetch(init: initialMessage)
            }
        }
    }

    private var contentView: some View {
        VStack {
            messages
            if viewModel.showMessageLoader {
                LoadingIndicator(animation: .threeBallsTriangle, color: .white)
            } else {
                MInput(value: $viewModel.inputValue, placeholder: "Напишите запрос...")
                    .onSubmit {

                        if viewModel.chat != nil {
                            Task {
                                await viewModel.sendMessage(viewModel.inputValue)
                            }
                        }
                    }
            }
        }
        .padding(.bottom, 16.0)
    }

    private var messages: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .trailing) {
                    ForEach(viewModel.messages) { message in
                        let isInvalid = viewModel.sendMessageError && viewModel.messages.last(where: { $0.content == viewModel.lastMessage }) == message
                        if isInvalid {
                            Menu {
                                Button("Повторить") {
                                    Task {
                                        await viewModel.sendMessage(message.content)
                                    }
                                }
                                Button("Удалить") {
                                    viewModel.messages.removeLast()
                                }
                            } label: {
                                MessageView(message: message, isInvalid: isInvalid)
                            }
                            .id(message.id)

                        } else {
                            MessageView(message: message, isInvalid: isInvalid)
                                .id(message.id)
                        }
                    }
                }
                .padding(.bottom, 16.0)
            }
            .defaultScrollAnchor(.bottom)
        }
    }
}

@Observable
class ChatViewModel {

    var inputValue = ""

    var lastMessage: String?

    var chat: Chat?
    var messages: [Message] = []
    var showLoader = false

    var showMessageLoader = false
    var sendMessageError = false

    let service = BaseChatService()
    let aiService = AIService()


    func fetch(init message: String) async {
        let chatID = await createChat(title: String(message.prefix(30)))

        guard let chatID else {
            return
        }

        await fetch(id: chatID)
    }

    func fetch(id chatID: String) async {
        chat = try? await service.get(chatId: chatID)
        messages = chat?.messages ?? messages

        if chat == nil {
            print("Chat load error")
        }
    }

    private func createChat(title: String) async -> String? {
        let result = try? await service.create(title: title)

        guard let result else {
            return nil
        }

        return result.id
    }

    func sendMessage(_ message: String) async {
        guard let chat, !message.isEmpty else {
            return
        }

        inputValue = ""
        self.sendMessageError = false
        self.showMessageLoader = false
        self.lastMessage = message

        messages.append(
            Message(
                id: UUID().uuidString,
                content: message,
                isAi: false,
                createdAt: Date.now.ISO8601Format()
            )
        )

        self.showMessageLoader = true

        let aiAnswer = await aiService.answer(for: message, chatID: chat.id)

        guard let aiAnswer else {
            showMessageLoader = false
            sendMessageError = true
            return
        }

        messages.append(
            Message(
                id: UUID().uuidString,
                content: aiAnswer,
                isAi: true,
                createdAt: Date.now.ISO8601Format()
            )
        )

        showMessageLoader = false
        sendMessageError = false
    }
}

