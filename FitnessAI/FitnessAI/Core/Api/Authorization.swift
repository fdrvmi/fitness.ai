//
//  Authorization.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

protocol AuthorizationService {

    func login(_ userName: String, password: String) async -> Result<LoginResponse, ApiError>
    func singUp(_ userName: String, weight: Double, height: Double, email: String, password: String) -> Result<(Token, Token), ApiError>

    func refreshToken() -> String
}

struct BaseAuthorizationService: AuthorizationService {

    func login(_ userName: String, password: String) async -> Result<LoginResponse, ApiError> {
        guard let url = URL(string: "http://localhost:5005/auth/login") else { return .failure(.init(message: "Invalid URL")) }
        let request = URLRequest(url: url)

        let data = try? await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()

        let result = data.map { data, _ in
            try? decoder.decode(LoginResponse.self, from: data)
        }

        return result?.map { .success($0) } ?? .failure(ApiError(message: "Parse error"))
    }
    
    func singUp(_ userName: String, weight: Double, height: Double, email: String, password: String) -> Result<(Token, Token), ApiError> {
        .failure(.init())
    }

    func refreshToken() -> String {
        ""
    }
}

extension AuthorizationService {

    static var base: BaseAuthorizationService {
        BaseAuthorizationService()
    }
}
