//
//  SignUpModeBuilder.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 21.11.2024.
//

import Foundation

@Observable
final class SignUpModelBuilder {

    var name: String = ""
    var weight: Double?
    var height: Double?
    var email: String = ""
    var password: String = ""

    var confirmPassword: String = ""
}
