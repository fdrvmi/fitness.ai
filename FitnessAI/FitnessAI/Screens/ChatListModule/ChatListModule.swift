//
//  ChatListModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import SwiftUI

struct ChatListModule: View {

    @State private var viewModel = ChatListViewModel()

    @State private var contentNavigation = ContentNavigation()

    var body: some View {
        NavigationStack(path: $contentNavigation.path) {
            VStack {
                if viewModel.showLoader {
                    ProgressView()
                        .tint(.white)
                } else if viewModel.chats.isEmpty {
                    MError(message: "Чатов нет, создай чат")
                } else {
                    List {
                        ForEach(viewModel.chats) { chat in
                            ChatListCell(
                                title: chat.title ?? "AI CHAT",
                                subtitle: chat.messages.last?.content ?? "Нет сообщений",
                                time: ""
                            ) {
                                contentNavigation.path.append(chat)
                            }
                            .listRowInsets(
                                EdgeInsets(
                                    top: 0,
                                    leading: 16.0,
                                    bottom: 0,
                                    trailing: 16.0
                                )
                            )
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .listRowSpacing(12.0)
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .withAppBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AIChat")
                        .foregroundColor(.white)
                }
            }
            .task {
                viewModel.showLoader = true
                await viewModel.fetchChats()
            }
            .navigationDestination(for: Chat.self) { chat in
                ChatModule(chatID: chat.id)
            }
        }
        .environment(contentNavigation)
    }
}

@Observable
class ChatListViewModel {

    var showLoader = true
    var chats: [Chat] = []

    private let service: any ChatService = BaseChatService()

    func refresh() async {
        await fetchChats()
    }

    func fetchChats() async {
        let chats = try? await service.getList()

        guard let chats else {
            self.showLoader = false
            return
        }

        self.chats = chats.chats

        self.showLoader = false
    }
}

#Preview {
    ChatListModule()
}
