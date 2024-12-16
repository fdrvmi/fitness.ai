//
//  SignUpModeBuilder.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 21.11.2024.
//

import Foundation

@Observable
final class SignUpViewModel {

    var name: String = ""
    var weight: Double?
    var height: Double?
    var email: String = ""
    var password: String = ""

    var confirmPassword: String = ""

    var nameError: String?
    var weightError: String?
    var heightError: String?
    var emailError: String?
    var passwordError: String?
    var confirmPasswordError: String?

    var showLoader = false

    func step1Next() -> Bool {
        let nameResult = validate(name, validator: validateUsername(_:))

        nameError = nameResult.1

        guard nameError == nil else { return false }

        return true
    }

    func step2Next() -> Bool {
        guard weight != nil else {
            weightError = "Неправильный вес"
            return false
        }

        guard height != nil else {
            weightError = "Неправильный рост"
            return false
        }

        return true
    }

    func signUp() {
        let emailResult = validate(email, validator: emailValidator(_:))

        emailError = emailResult.1
        
        guard emailError == nil else { return }
        
        let passwordResult = validate(password, validator: passwordValidator(_:))

        passwordError = passwordResult.1

        guard passwordError == nil else { return }

        let confirmPasswordResult = validate(confirmPassword, validator: validateConfirmPassword(password))

        confirmPasswordError = confirmPasswordResult.1

        guard confirmPasswordError == nil else { return }

        showLoader = true

        Task {
            await trySignUp()
        }
    }

    func trySignUp() async {
        let route = Route.jsonRoute(
            AuthRoutes.signUp(
                username: name,
                email: email,
                password: password
            )
        )

        let result = try? await request(route)

        guard let result, let data = try? JSONDecoder().decode(User.self, from: result.0) else {
            emailError = "Something went wrong"
            return
        }

        await makeSignIn(email: name, password: password)

        showLoader = false
    }

    private func makeSignIn(email: String, password: String) async {
        let result = try? await request(
            AuthRoutes.login(username: email, password: password)
        )

        guard let result, let data = try? JSONDecoder().decode(LoginResponse.self, from: result.0) else {
            emailError = "Something went wrong"
            return
        }

        UserManager.shared.handleSignIn(data)
    }
}
