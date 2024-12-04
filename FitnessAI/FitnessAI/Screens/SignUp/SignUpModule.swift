//
//  SignUpModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 05.12.2024.
//

import SwiftUI

struct SignUpModule: View {

    @State
    private var signUpInfoBuilder = SignUpModelBuilder()

    @Environment(ContentNavigation.self) var navigation: ContentNavigation?

    var body: some View {
        VStack {
            nextFlow(
                nameCard,
                step: 1
            )
        }
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
    }

    private var nameCard: some View {
        SignUpCard {
            VStack(spacing: 16.0) {
                Text("signup.name.title")
                    .font(.h2)
                    .foregroundStyle(Color.Text.primaryWhite)
                    .multilineTextAlignment(.center)

                MInput(
                    value: $signUpInfoBuilder.name,
                    placeholder: "signup.name.input.placeholder".localized
                )

                MButton(
                    title: Text("signup.name.button.title"),
                    icon: Image(.Icon.arrow)
                ) {
                    navigation?.path.append(SignUpFlowScreens.step2)
                }
            }
        }
    }

    private var paramsView: some View {
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
                            signUpInfoBuilder.weight.map { String($0) } ?? ""
                        } set: { newValue in
                            guard let value = Double(newValue) else { return }
                            signUpInfoBuilder.weight = value
                        },
                        placeholder: "signup.params.weight.input.placeholder".localized
                    )

                    MInput(
                        value: Binding {
                            signUpInfoBuilder.height.map { String($0) } ?? ""
                        } set: { newValue in
                            guard let value = Double(newValue) else { return }
                            signUpInfoBuilder.height = value
                        },
                        placeholder: "signup.params.height.input.placeholder".localized
                    )
                }

                MButton(
                    title: Text("signup.params.button.titlen"),
                    icon: Image(.Icon.arrow)
                ) {
                    navigation?.path.append(SignUpFlowScreens.step3)
                }
            }
        }
    }

    private var finalView: some View {
        SignUpCard {
            VStack(spacing: 16.0) {
                Text("signup.final.title")
                    .font(.h2)
                    .foregroundStyle(Color.Text.primaryWhite)
                    .padding(.bottom, 8.0)
                    .multilineTextAlignment(.center)

                MInput(
                    value: $signUpInfoBuilder.email,
                    placeholder: "signup.final.email.placeholder".localized
                )

                MInput(
                    value: $signUpInfoBuilder.password,
                    placeholder: "signup.final.password.placeholder".localized
                )

                MInput(
                    value: $signUpInfoBuilder.confirmPassword,
                    placeholder: "signup.final.confirmpassword.placeholder".localized
                )

                MButton(
                    title: Text("signup.final.button.title"),
                    icon: Image(.Icon.check)
                ) {

                }
            }
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
    SignUpModule()
}
