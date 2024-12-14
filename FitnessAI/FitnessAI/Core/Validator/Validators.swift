//
//  Validators.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

import Foundation

// MARK: - Email Validation

func emailValidator(_ email: String) -> (Bool, String?) {

    // Email validation regex (RFC 5322 simplified)
    let emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/

    if email.wholeMatch(of: emailRegex) == nil {
        return (false, "Invalid email")
    }

    return (true, nil)
}

// MARK: - Password Validation

func passwordValidator(_ password: String) -> (Bool, String?) {
    // Регулярное выражение для пароля
    let passwordRegex = #/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/#

    let match = password.wholeMatch(of: passwordRegex)
    return  (
        match != nil,
        match != nil ? nil : "Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one digit and one special character"
    )
}

// MARK: - UserName Validation

func validateUsername(_ username: String) -> (Bool, String?) {
    let usernameRegex = #/^[a-zA-Z0-9]{3,15}$/#  // Регулярное выражение для имени пользователя
    let result = username.wholeMatch(of: usernameRegex) != nil
    return (result, result ? nil : "Username must contain at least 3 characters and no more than 15")
}

// MARK: - Weight Validation

func validateWeight(_ weight: String) -> (Bool, String?) {
    let weightRegex = #/^(?:[3-9][0-9]|[1-2][0-9]{2}|300)$/#  // Регулярное выражение для веса
    let result = weight.wholeMatch(of: weightRegex) != nil
    return (result, result ? nil : "Weight must be between 300 and 3000")
}

// MARK: - Height Validation

func validateHeight(_ height: String) -> (Bool, String?) {
    let heightRegex = #/^[0-9]*((0[0-9])|(1[01]))$/#  // Регулярное выражение для роста
    let result = height.wholeMatch(of: heightRegex) != nil
    return (result, result ? nil : "Height must be between 250 and 3000")
}

// MARK: - Confirm password Validator


func validateConfirmPassword(_ origin: String) -> (String) -> (Bool, String?) {
    { confirmPass in
        let result = confirmPass == origin
        return (result, result ? nil : "Пароли не совпадают")
    }
}
