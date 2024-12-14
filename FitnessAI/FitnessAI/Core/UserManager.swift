//
//  UserManager.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

struct UserManager {

    func logOut() {
        KeychainManager.shared.deleteToken(forKey: .accessToken)
        KeychainManager.shared.deleteToken(forKey: .refreshToken)
    }
}
