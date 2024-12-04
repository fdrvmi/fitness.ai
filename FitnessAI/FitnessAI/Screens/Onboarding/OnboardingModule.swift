//
//  OnboardingModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI

struct OnboardingModule: View {

    @State var viewModel = OnboardingViewModel()

    @Environment(ContentNavigation.self) var navigation: ContentNavigation?

    var body: some View {
        VStack(spacing: 16.0) {
            HStack {
                Image(.Buble.vector)
                    .padding(.leading, 17.0)
                Spacer()
            }

            Spacer()

            contentView

            Spacer()

            HStack {
                Spacer()
                Image(.Buble.vector)
                    .scaleEffect(x: -1, y: 1)
                    .padding(.trailing, 17.0)
            }

        }
        .padding(.horizontal, 16.0)
        .multilineTextAlignment(.center)
        .withAppBackground()
        .navigationDestination(for: OnboardingScreens.self) { view in
            switch view {
            case .onboarding:
                OnboardingModule()
            case .signIn:
                SignInModule()
            case .signUp:
                SignUpModule()
            }
        }
    }

    private var contentView: some View {
        VStack(spacing: 16.0) {
            Image(.Icon.health1)
                .resizable()
                .foregroundStyle(Color.Text.primaryWhite)
                .frame(width: 30, height: 30)
                .padding(7.0)
                .background(
                    RoundedRectangle(cornerRadius: 8.0)
                        .fill(.white.opacity(0.3))
                )

            Text("onboarding.title")
                .font(.h1)
                .foregroundStyle(Color.Text.primaryWhite)

            Text("onboarding.description")
                .font(.leadText)
                .foregroundStyle(Color.Text.secondaryWhite)

            MButton(
                title: Text("onboarding.signin")
            ) {
                navigation?.path.append(OnboardingScreens.signIn)
            }

            MButton(
                title: Text("onboarding.signup"),
                type: .primary
            ) {
                navigation?.path.append(OnboardingScreens.signUp)
            }
        }
    }
}

#Preview {
    OnboardingModule()
}
