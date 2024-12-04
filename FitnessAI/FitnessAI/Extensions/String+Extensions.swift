//
//  String+Extensions.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 21.11.2024.
//

import Foundation

extension String {

    var localized: String {
        String(localized: LocalizedStringResource(stringLiteral: self))
    }
}
