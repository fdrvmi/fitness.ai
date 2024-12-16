//
//  AIService.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 16.12.2024.
//

import Foundation

struct AIAnswer: Codable {

    let text: String
}

struct AIService {

    func answer(for query: String, chatID: String) async -> String? {
        let route = AIRoutes.answer(query, chatID: chatID)

        let result = try? await applicationRequest(route)

        guard let result, let response = result.1 as? HTTPURLResponse, response.statusCode == 200 else {
            return nil
        }

        return try? JSONDecoder().decode(AIAnswer.self, from: result.0).text
    }
}
