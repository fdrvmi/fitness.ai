//
//  SignInModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI

@Observable
final class SignInViewModel {

    var email: String = ""
    var password: String = ""
}

struct SignInModule: View {

    @State var viewModel = SignInViewModel()

    var body: some View {
        VStack {
            contentView
                .padding(.horizontal, 16.0)
        }
        .withAppBackground()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NBackButton()
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
    }

    private var formView: some View {
        VStack(spacing: 16.0) {
            MInput(value: $viewModel.email, placeholder: "signin.email".localized)

            MInput(value: $viewModel.password, placeholder: "signin.password".localized)

            MButton(
                title: Text("signin.button.login"),
                icon: Image(.Icon.arrow)
            ) {

            }
        }
    }
}

#Preview {
    SignInModule()
}
