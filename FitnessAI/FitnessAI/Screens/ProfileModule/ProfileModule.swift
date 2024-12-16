//
//  ProfileModule.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 16.12.2024.
//

import SwiftUI

struct ProfileModule: View {

    @State private var viewModel = ProfileModuleViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    contentView(user)
                } else {
                    ProgressView()
                        .tint(.white)
                }
            }
            .padding(.horizontal, 16.0)
            .withAppBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AIChat")
                        .foregroundColor(.white)
                }
            }
            .task {
                await viewModel.onAppear()
            }
        }
    }

    func contentView(_ user: User) -> some View {
        VStack(spacing: 8.0) {
            profileMain(user)
            email(user)

            Divider()
                .background(.white.opacity(0.5))
            Spacer()

            logoutButton
        }
        .padding(.top, 20)
    }

    func profileMain(_ user: User) -> some View {
        HStack() {
            avatar
                .padding(.trailing, 16.0)

            Text(user.fullName)
                .font(.leadText)
                .foregroundStyle(.white)

            Spacer(minLength: 16.0)

            Image(.Icon.setting)
                .resizable()
                .frame(width: 16.0, height: 16.0)
        }
        .padding(16.0)
        .background(
            Color.white
                .opacity(0.08)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }

    func email(_ user: User) -> some View {
        HStack() {
            Text(user.email)
                .font(.desktopLeadText)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8.0)
        .background(
            Color.white
                .opacity(0.08)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }

    var avatar: some View {
        Image(.Icon.person)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(.white)
            .padding(4.0)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.opacity(0.3))
            )
    }

    var logoutButton: some View {
        Button {
            viewModel.logout()
        } label: {
            Text("Выйти")
                .font(.desktopLeadText)
                .foregroundStyle(Color.Text.primaryBlack)
                .frame(maxWidth: .infinity)
                .padding(9.0)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.white)
                )
                .overlay(alignment: .trailing) {
                    Image(.Icon.logout)
                        .frame(width: 16, height: 16.0)
                        .padding(8.0)
                        .background {
                            Circle()
                                .fill(Color.Elements.red)
                        }
                        .padding(4.0)
                }
        }
        .buttonStyle(.plain)
        .padding(.bottom)
    }
}

@Observable
class ProfileModuleViewModel {

    var user: User? = .mock()

    func onAppear() async {
        await UserManager.shared.onLoad()
        user = UserManager.shared.user ?? .mock()
    }

    func logout() {
        UserManager.shared.logOut()
    }
}

#Preview {
    ProfileModule()
}
