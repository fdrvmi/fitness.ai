//
//  MButton.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 20.11.2024.
//

import SwiftUI

struct MButton: View {

    enum Style {
        case `default`
        case secondary
        case primary
    }

    enum Size {
        case `default`
        case small
    }

    var title: Text
    var size: Size = .default
    var type: Style = .default
    var icon: Image?
    var onlyIcon = false
    var isDisabled = false
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            if icon != nil, onlyIcon {

            }
            else {
                ZStack {
                    HStack {
                        Spacer()

                        if type != .default {
                            icon?
                                .foregroundStyle(.white)
                                .padding(.trailing, 10)
                                .padding(.vertical, 8.0)
                        }

                        title
                            .foregroundStyle(fontColor)
                            .font(.custom("PTSans-Regular", size: 16))
                            .padding(.vertical, size == .small ? 4.5 : 9.5)

                        Spacer()
                    }

                    HStack {
                        Spacer()
                        if type == .default {
                            iconView
                                .padding(4.0)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
    }

    private var backgroundColor: Color {

        if isDisabled {
            return Color.Elements.secondaryBlack
        }

        return switch type {
        case .default:
            Color.Text.primaryWhite
        case .secondary:
            Color.Elements.secondaryBlack
        case .primary:
            Color.Elements.secondaryBlack
        }
    }

    private var fontColor: Color {
        if isDisabled {
            return Color.Elements.secondaryBlack
        }

        return switch type {
        case .default:
            Color.Text.primaryBlack
        case .secondary:
            Color.Text.primaryWhite
        case .primary:
            Color.Text.primaryWhite
        }
    }

    private var iconBackground: Color {
        switch type {
        case .default:
            Color.Elements.primaryBlack
        case .secondary:
            Color.Elements.secondaryBlack
        case .primary:
            Color.Elements.secondaryBlack
        }
    }

    @ViewBuilder
    private var iconView: some View {
        icon?
            .frame(width: 40, height: 40)
            .foregroundStyle(.white)
            .background(
                Circle()
                    .fill(iconBackground)
            )
    }
}

#Preview {
    MButton(title: Text("Кнопка"), type: .default, icon: Image(.Icon.arrow)) {

    }
    .padding()
    .background(.red)
}
