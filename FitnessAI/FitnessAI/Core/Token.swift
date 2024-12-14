//
//  Token.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

struct TokenKey: Equatable {
    let key: String
}

struct Token {
    let key: TokenKey
    let value: String

    init(key: TokenKey, value: String) {
        self.key = key
        self.value = value
    }
}

extension TokenKey {

    static let accessToken = TokenKey(key: "access_token")

    static let refreshToken = TokenKey(key: "refresh_token")
}
