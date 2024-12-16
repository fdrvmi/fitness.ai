//
//  UserModels.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import Foundation

struct User: Codable, Equatable {
    let id: String
    let email: String
    let fullName: String
    let lastOnlineTime: Date?
    let gender: String?
    let avatarUrl: String?
    let phoneNumber: String?
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}

struct BackendTokens: Codable, Equatable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Int
}

struct LoginResponse: Codable, Equatable {
    let user: User
    let backendTokens: BackendTokens
}

extension User {
    static func mock(
        id: String = UUID().uuidString,
        email: String = "mock_email@example.com",
        fullName: String = "Mock User",
        lastOnlineTime: Date? = Date(),
        gender: String? = "male",
        avatarUrl: String? = "https://example.com/avatar.png",
        phoneNumber: String? = "+1234567890",
        createdAt: String = ISO8601DateFormatter().string(from: Date()),
        updatedAt: String = ISO8601DateFormatter().string(from: Date()),
        deletedAt: String? = nil
    ) -> User {
        return User(
            id: id,
            email: email,
            fullName: fullName,
            lastOnlineTime: lastOnlineTime,
            gender: gender,
            avatarUrl: avatarUrl,
            phoneNumber: phoneNumber,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt
        )
    }
}
