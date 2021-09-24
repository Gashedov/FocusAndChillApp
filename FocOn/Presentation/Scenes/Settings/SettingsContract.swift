//
//  SettingsContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit

protocol SettingsViewModel {
    var options: [SettingsOption] { get }
    func optionSelected(at: Int)
}

enum SettingsOption: Int {
    case changeCharacter
    case aboutUs
    case support
    case faq
    case terms
    case rateUs

    var title: String {
        switch self {
        case .aboutUs:
            return "About us"
        case .changeCharacter:
            return "Change cheracter"
        case .support:
            return "Support"
        case .faq:
            return "FAQ"
        case .terms:
            return "Terms & Conditions"
        case .rateUs:
            return "Rate us"
        }
    }
}

protocol SettingsBuilder {
    func build() -> UIViewController
}

protocol SettingsRouter {
    func openAboutUs()
    func openChangeCharacterView()
    func openRateUs()
}
