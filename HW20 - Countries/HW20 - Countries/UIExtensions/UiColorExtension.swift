//
//  UiColorExtension.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 26.04.24.
//

import UIKit

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
}
