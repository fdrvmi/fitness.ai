//
//  Logger.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import OSLog

extension Logger {

    static let common = Logger(subsystem: "com.fitnessai.network", category: "common")
    static let network = Logger(subsystem: "com.fitnessai.network", category: "network")
}
