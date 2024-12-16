//
//  SignInModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI
import OSLog

@Observable
final class SignInViewModel {

    var email: String = ""
    var password: String = ""

    var emailError: String?
    var passwordError: String?

    func signIn() {
        let emailValidationResult = validate(email, validator: validateUsername(_:))
        let passwordValidationResult = validate(password, validator: passwordValidator(_:))

        emailError = emailValidationResult.1
        passwordError = passwordValidationResult.1

        guard emailError == nil, passwordError == nil else {
            return
        }

        Task {
            await makeSignIn(email: email, password: password)
        }
    }

    func resetErrors() {
        emailError = nil
        passwordError = nil
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

struct SignInModule: View {

    @State var viewModel = SignInViewModel()

    @FocusState
    private var emailFocusState

    @FocusState
    private var passwordFocusState

    var body: some View {
        VStack(spacing: 23) {
            contentView
            errors
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 16.0)
        .withAppBackground()
        .animation(.easeIn, value: viewModel.emailError)
        .animation(.easeIn, value: viewModel.passwordError)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NBackButton()
            }
        }
    }

    private var errors: some View {
        VStack {
            if let emailError = viewModel.emailError {
                MError(message: emailError)
                    .transition(.opacity)
            }

            if let passwordError = viewModel.passwordError {
                MError(message: passwordError)
                    .transition(.opacity)
            }
        }
    }

    private var contentView: some View {
        VStack(alignment: .center, spacing: .zero) {
            Text("signin.login")
                .font(.h2)
                .foregroundStyle(Color.Text.primaryWhite)
                .padding(.bottom, 24.0)

            formView
        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 32.0)
        .background(
            Color.white
                .opacity(0.08)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .onChange(of: emailFocusState) {
            if $1 {
                viewModel.resetErrors()
            }
        }
        .onChange(of: passwordFocusState) {
            if $1 {
                viewModel.resetErrors()
            }
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }

    private var formView: some View {
        VStack(spacing: 16.0) {
            MInput(value: $viewModel.email, placeholder: "signin.email".localized)
                .focused($emailFocusState)
                .keyboardType(.emailAddress)

            MInput(value: $viewModel.password, placeholder: "signin.password".localized)
                .focused($passwordFocusState)

            MButton(
                title: Text("signin.button.login"),
                icon: Image(.Icon.arrow)
            ) {
                withAnimation(nil) {
                    viewModel.signIn()
                }
            }
        }
    }
}

#Preview {
    SignInModule()
}
