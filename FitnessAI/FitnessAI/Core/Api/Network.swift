//
//  Network.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

protocol Network {

    func make(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

struct SharedNetwork: Network {

    func make(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse

        guard let httpResponse else {
            throw ApiError(message: "CANT PARSE HTTP RESPONSE")
        }

        return (data, httpResponse)
    }
}

extension Network {

    static var shared: SharedNetwork {
        SharedNetwork()
    }
}

struct AuthNetwork: Network {
    

    func make(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let result = try await fetch(request)

        if result.1.statusCode == 401 {
            return try await refresh {
                try await fetch(request)
            }
        }

        return result
    }

    private func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse

        guard let httpResponse else {
            throw ApiError(message: "CANT PARSE HTTP RESPONSE")
        }

        return (data, httpResponse)
    }

    private func refresh(_ ifRefreshed: () async throws -> (Data, HTTPURLResponse)) async throws -> (Data, HTTPURLResponse) {
        let accessToken = KeychainManager.shared.loadToken(forKey: .accessToken)
        let refreshToken = KeychainManager.shared.loadToken(forKey: .refreshToken)

        guard let url = URL(string: "http://localhost:5005/auth/refresh") else {
            throw ApiError(message: "CANT CREATE URL")
        }

        let request = URLRequest(url: url)
        let refresh = try await fetch(request)


    }
}
