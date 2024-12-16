//
//  ChatService.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 16.12.2024.
//

import Foundation

protocol ChatService {

    func create(title: String) async throws -> ChatCreateResponse

    func getList() async throws -> ChatListResponse

    func get(chatId: String) async throws -> Chat

    func messages(chatID: String) async throws -> [Message]
}

struct BaseChatService: ChatService {

    func create(title: String) async throws -> ChatCreateResponse {
        let result = try? await applicationRequest(ChatRoutes.createChat(title: title))

        guard let result, let response = result.1 as? HTTPURLResponse, response.statusCode == 201 else {
            throw ApiError(message: "NOT SUCCESS")
        }

        guard let data = try? JSONDecoder().decode(ChatCreateResponse.self, from: result.0) else {
            throw ApiError(message: "Parse error")
        }

        return data
    }
    
    func getList() async throws -> ChatListResponse {
        let result = try? await applicationRequest(ChatRoutes.getList())

        guard let result, let response = result.1 as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError(message: "NOT SUCCESS")
        }

        guard let data = try? JSONDecoder().decode(ChatListResponse.self, from: result.0) else {
            throw ApiError(message: "Parse error")
        }

        return data
    }
    
    func get(chatId: String) async throws -> Chat {
        let result = try? await applicationRequest(ChatRoutes.get(chatID: chatId))

        guard let result, let response = result.1 as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError(message: "NOT SUCCESS")
        }

        guard let data = try? JSONDecoder().decode(Chat.self, from: result.0) else {
            throw ApiError(message: "Parse error")
        }

        return data
    }
    
    func messages(chatID: String) async throws -> [Message] {
        let result = try? await applicationRequest(ChatRoutes.messages(chatID: chatID))

        guard let result, let response = result.1 as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError(message: "NOT SUCCESS")
        }

        guard let data = try? JSONDecoder().decode(ChatMessagesResponse.self, from: result.0) else {
            throw ApiError(message: "Parse error")
        }

        return data.messages
    }
}
