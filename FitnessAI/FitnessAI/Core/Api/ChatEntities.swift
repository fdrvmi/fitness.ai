//
//  ChatEntities.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 16.12.2024.
//

import Foundation

struct Chat: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let createdAt: String
    var messages: [Message]
}

struct Message: Codable, Hashable, Identifiable {
    let id: String
    let content: String
    let isAi: Bool
    let createdAt: String
}

struct ChatCreateResponse: Codable {
    let id: String
    let title: String
    let createdAt: String
}

struct ChatListResponse: Codable {
    let chats: [Chat]

    init(from decoder: any Decoder) throws {
        var container = try decoder.singleValueContainer()
        self.chats = try container.decode([Chat].self)
    }
}

struct ChatMessagesResponse: Codable {
    let messages: [Message]

    init(messages: [Message]) {
        self.messages = messages
    }

    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.messages = try container.decode([Message].self)
    }
}
