//
//  ApiError.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

enum ApiErrorType {
    case another
    case unathorized
}

struct ApiError: Error {
    var message = "API Error"
    var type = ApiErrorType.another
}
