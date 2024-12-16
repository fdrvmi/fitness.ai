//
//  NetworkCore.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import Foundation

// MARK: - Network Core

func network(
    _ baseURL: String,
    core: @escaping (URLRequest) async throws -> (Data, URLResponse)
) -> (Route) async throws -> (Data, URLResponse) {
    return { route in
        guard let urlRequest = route.urlRequest(baseURL: baseURL) else {
            throw ApiError(message: "Invalid URL request")
        }

        return try await core(urlRequest)
    }
}

func applicationNetwork(
    _ baseURL: String,
    core: @escaping (URLRequest) async throws -> (Data, URLResponse)
) -> (Route) async throws -> (Data, URLResponse) {
    return { route in
        guard let accessToken = KeychainManager.shared.loadToken(forKey: .accessToken) else {
            return try await network(baseURL, core: core)(route)
        }

        let newRoute = Route.authRoute(route, accessToken: accessToken)

        guard let urlRequest = newRoute.urlRequest(baseURL: baseURL) else {
            throw ApiError(message: "Invalid URL request")
        }

        return try await core(urlRequest)
    }
}

private let baseCore: (URLRequest) async throws -> (Data, URLResponse) = { request in
    try await URLSession.shared.data(for: request)
}

let request = network("http://localhost:5005/", core: baseCore)

private let applicationCore: (URLRequest) async throws -> (Data, URLResponse) = { request in
    do {
        // Пытаемся выполнить запрос
        let (data, response) = try await baseCore(request)

        // Проверяем код ответа
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
            // Если ошибка 401, пробуем обновить токен и повторить запрос
            try await refreshAuthToken()
            var retryRequest = request

            // Повторяем запрос с обновленным токеном
            return try await baseCore(request)
        }

        // Если все прошло успешно, возвращаем данные и ответ
        return (data, response)
    } catch {
        // Обрабатываем ошибку, если она произошла
        throw error
    }
}

func refreshAuthToken() async throws {
    guard let token = KeychainManager.shared.loadToken(forKey: .refreshToken) else {
        throw ApiError(message: "Refresh token not found")
    }

    let (data, response) = try await request(.refresh(refreshToken: token))

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        KeychainManager.shared.deleteToken(forKey: .accessToken)
        KeychainManager.shared.deleteToken(forKey: .refreshToken)
        return
    }

    guard
        let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
        let accessToken = data["accessToken"] as? String,
        let refreshToken = data["refreshToken"] as? String
    else {
        KeychainManager.shared.deleteToken(forKey: .accessToken)
        KeychainManager.shared.deleteToken(forKey: .refreshToken)
        return
    }

    UserManager.shared.update(accessToken, refreshToken: refreshToken)
}

let applicationRequest = applicationNetwork("http://localhost:5005", core: applicationCore)

