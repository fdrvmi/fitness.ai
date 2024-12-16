//
//  UserManager.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

@Observable
final class UserManager {

    static let shared = UserManager()

    var user: User?

    func handleSignIn(_ resp: LoginResponse) {
        user = resp.user
        KeychainManager.shared.saveToken(Token(key: .accessToken, value: resp.backendTokens.accessToken))
        KeychainManager.shared.saveToken(Token(key: .refreshToken, value: resp.backendTokens.refreshToken))
    }

    func update(_ accessToken: String, refreshToken: String) {
        KeychainManager.shared.saveToken(Token(key: .accessToken, value: accessToken))
        KeychainManager.shared.saveToken(Token(key: .refreshToken, value: refreshToken))
    }

    func logOut() {
        user = nil
        KeychainManager.shared.deleteToken(forKey: .accessToken)
        KeychainManager.shared.deleteToken(forKey: .refreshToken)
    }

    func onLoad() async {
        let route = Route.jsonRoute(AuthRoutes.me())
        let result = try? await applicationRequest(route)

        guard let result, let resp = result.1 as? HTTPURLResponse, resp.statusCode == 200 else {
            return logOut()
        }

        guard let user = try? JSONDecoder().decode(User.self, from: result.0) else {
            return logOut()
        }

        self.user = user
    }
}
