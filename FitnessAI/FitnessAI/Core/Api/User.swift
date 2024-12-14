//
//  User.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
    let email: String
    let fullName: String
    let lastOnlineTime: Date?
    let gender: String?
    let avatarUrl: String?
    let phoneNumber: String?
    let createdAt: Date
    let updatedAt: Date
    let deletedAt: Date?
    let id: String
}

struct BackendTokens: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Int
}

struct LoginResponse: Codable {
    let user: User
    let backendTokens: BackendTokens
}

