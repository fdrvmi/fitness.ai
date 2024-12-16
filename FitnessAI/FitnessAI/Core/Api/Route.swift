//
//  Route.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import Foundation

// MARK: - Route

struct Route {
    // URL path for the route
    var path: String

    // HTTP method (e.g., GET, POST, etc.)
    var method: String = "GET"

    // Query parameters to be appended to the URL
    var queryParameters: [String: String]?

    // HTTP headers
    var headers: [String: String]?

    // HTTP body (e.g., for POST or PUT requests)
    var body: Data?

    // Full URL generation
    func url(baseURL: String) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path

        if let queryParameters = queryParameters {
            components?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return components?.url
    }

    func urlRequest(baseURL: String) -> URLRequest? {
        url(baseURL: baseURL).map {
            var request = URLRequest(url: $0)
            request.httpMethod = method
            request.httpBody = body

            headers?.forEach { (key: String, value: String) in
                request.setValue(value, forHTTPHeaderField: key)
            }

            return request
        }
    }
}

extension Route {

    static func jsonRoute(_ route: Route) -> Route {
        var headers = route.headers ?? [:]
        headers["Content-Type"] = "application/json"

        return Route(
            path: route.path,
            method: route.method,
            queryParameters: route.queryParameters,
            headers: headers,
            body: route.body
        )
    }

    static func authRoute(_ route: Route, accessToken: String) -> Route {
        var headers = route.headers
        headers?["Authorization"] = "Bearer \(accessToken)"

        return jsonRoute(
            Route(
                path: route.path,
                method: route.method,
                queryParameters: route.queryParameters,
                headers: headers
            )
        )
    }

    static func refresh(refreshToken: String) -> Route {
        jsonRoute(
            Route(
                path: "auth/refresh",
                method: "POST",
                headers: [
                    "Authorization": "Refresh \(refreshToken)"
                ]
            )
        )
    }
}


enum AuthRoutes {

    static func login(username: String, password: String) -> Route {
        Route.jsonRoute(
            Route(
                path: "/auth/login",
                method: "POST",
                body: try? JSONSerialization.data(
                    withJSONObject: [
                        "username": username,
                        "password": password
                    ]
                )
            )
        )
    }

    static func signUp(
        username: String,
        email: String,
        password: String
    ) -> Route {
        Route.jsonRoute(
            Route(
                path: "/auth/signup",
                method: "POST",
                body: try? JSONSerialization.data(
                    withJSONObject: [
                        "username": username,
                        "password": password,
                        "email": email,
                        "fullName": username
                    ]
                )
            )
        )
    }

    static func me() -> Route {
        Route.authRoute(
            Route(
                path: "/auth/me",
                method: "GET"
            ),
            accessToken: KeychainManager.shared.loadToken(forKey: .accessToken) ?? ""
        )
    }
}
