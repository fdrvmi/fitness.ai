//
//  UIColor+Extensions.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 15.12.2024.
//

import UIKit
import SwiftUI

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        var alpha: Double = 0

        let red, green, blue: Double
        switch hexSanitized.count {
        case 6: // RGB (6 characters)
            red   = Double((rgb & 0xFF0000) >> 16) / 255.0
            green = Double((rgb & 0x00FF00) >> 8) / 255.0
            blue  = Double(rgb & 0x0000FF) / 255.0
        case 8: // ARGB (8 characters)
            alpha = Double((rgb & 0xFF000000) >> 24) / 255.0
            red   = Double((rgb & 0x00FF0000) >> 16) / 255.0
            green = Double((rgb & 0x0000FF00) >> 8) / 255.0
            blue  = Double(rgb & 0x000000FF) / 255.0
        default:
            red = 0
            green = 0
            blue = 0
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
