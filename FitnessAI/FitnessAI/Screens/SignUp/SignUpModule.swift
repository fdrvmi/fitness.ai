//
//  SignUpModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 05.12.2024.
//

import SwiftUI

struct SignUpModule: View {

    @State
    private var signUpViewModel = SignUpViewModel()

    @Environment(ContentNavigation.self) var navigation: ContentNavigation?

    var body: some View {
        VStack {
            nextFlow(
                nameCard,
                step: 1
            )
        }
        .animation(.easeIn, value: signUpViewModel.nameError)
        .animation(.easeIn, value: signUpViewModel.emailError)
        .animation(.easeIn, value: signUpViewModel.weightError)
        .animation(.easeIn, value: signUpViewModel.heightError)
        .animation(.easeIn, value: signUpViewModel.passwordError)
        .animation(.easeIn, value: signUpViewModel.confirmPasswordError)
        .withAppBackground()
        .navigationDestination(for: SignUpFlowScreens.self) { view in
            switch view {
            case .step1:
                nextFlow(
                    nameCard,
                    step: 1
                )
            case .step2:
                nextFlow(
                    paramsView,
                    step: 2
                )
            case .step3:
                nextFlow(
                    finalView,
                    step: 3
                )
            }
        }
        .overlay {
            if signUpViewModel.showLoader {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.5)
                    .overlay {
                        ProgressView()
                            .tint(.white)
                    }
            }
        }
    }

    private var nameCard: some View {
        VStack {
            SignUpCard {
                VStack(spacing: 16.0) {
                    Text("signup.name.title")
                        .font(.h2)
                        .foregroundStyle(Color.Text.primaryWhite)
                        .multilineTextAlignment(.center)

                    MInput(
                        value: $signUpViewModel.name,
                        placeholder: "signup.name.input.placeholder".localized
                    )

                    MButton(
                        title: Text("signup.name.button.title"),
                        icon: Image(.Icon.arrow)
                    ) {
                        if signUpViewModel.step1Next() {
                            navigation?.path.append(SignUpFlowScreens.step2)
                        }
                    }
                }
            }

            if let error = signUpViewModel.nameError {
                MError(message: error)
            }
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }

    private var paramsView: some View {
        VStack {
            SignUpCard {
                VStack(spacing: 16.0) {
                    Text("signup.params.title")
                        .font(.h2)
                        .foregroundStyle(Color.Text.primaryWhite)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8.0)

                    HStack(spacing: 16.0) {
                        MInput(
                            value: Binding {
                                signUpViewModel.weight.map { String($0) } ?? ""
                            } set: { newValue in
                                guard let value = Double(newValue) else { return }
                                signUpViewModel.weight = value
                            },
                            placeholder: "signup.params.weight.input.placeholder".localized
                        )
                        .keyboardType(.numberPad)

                        MInput(
                            value: Binding {
                                signUpViewModel.height.map { String($0) } ?? ""
                            } set: { newValue in
                                guard let value = Double(newValue) else { return }
                                signUpViewModel.height = value
                            },
                            placeholder: "signup.params.height.input.placeholder".localized
                        )
                        .keyboardType(.numberPad)
                    }

                    MButton(
                        title: Text("signup.params.button.titlen"),
                        icon: Image(.Icon.arrow)
                    ) {
                        if signUpViewModel.step2Next() {
                            navigation?.path.append(SignUpFlowScreens.step3)
                        }
                    }
                }
            }

            if let error = signUpViewModel.weightError {
                MError(message: error)
            }

            if let error = signUpViewModel.heightError {
                MError(message: error)
            }
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }

    private var finalView: some View {
        VStack {
            SignUpCard {
                VStack(spacing: 16.0) {
                    Text("signup.final.title")
                        .font(.h2)
                        .foregroundStyle(Color.Text.primaryWhite)
                        .padding(.bottom, 8.0)
                        .multilineTextAlignment(.center)

                    MInput(
                        value: $signUpViewModel.email,
                        placeholder: "signup.final.email.placeholder".localized
                    )
                    .keyboardType(.emailAddress)

                    MInput(
                        value: $signUpViewModel.password,
                        placeholder: "signup.final.password.placeholder".localized
                    )

                    MInput(
                        value: $signUpViewModel.confirmPassword,
                        placeholder: "signup.final.confirmpassword.placeholder".localized
                    )

                    MButton(
                        title: Text("signup.final.button.title"),
                        icon: Image(.Icon.check)
                    ) {
                        signUpViewModel.signUp()
                    }
                }
            }

            if let error = signUpViewModel.emailError {
                MError(message: error)
            }

            if let error = signUpViewModel.passwordError {
                MError(message: error)
            }

            if let error = signUpViewModel.confirmPasswordError {
                MError(message: error)
            }
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .onDisappear {
            signUpViewModel.showLoader = false
        }
    }

    private func nextFlow<T: View>(_ view: T, step: Int, of: Int = 3) -> some View {
        VStack {
            Text("Шаг \(step)/\(of)")
                .font(.leadText)
                .foregroundStyle(Color.Text.secondaryWhite)
                .padding(.bottom, 24)

            view
        }
        .padding(.horizontal, 16.0)
        .withAppBackground()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NBackButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignUpModule()
    }
}
