//
//  Theme.swift
//  FocOn
//
//  Created by Artem Gorshkov on 30.12.21.
//

import UIKit

enum Theme: Int {
    case rain
    case forest
    case sea
    case fire

    static let shared = Theme(rawValue: UserDefaultsService.shared.currentThemeCode) ?? .rain

    var primaryColor: UIColor? {
        switch self {
        case .fire:
            return R.color.firePrimaryColor()
        case .sea:
            return R.color.seaPrimaryColor()
        case .forest:
            return R.color.forestPrimaryColor()
        case .rain:
            return R.color.rainPrimaryColor()
        }
    }

    var animationFolderName: String {
        switch self {
        case .rain:
            return "Rain"
        case .forest:
            return "Forest"
        case .sea:
            return "Sea"
        case .fire:
            return "Fire"
        }
    }
}


