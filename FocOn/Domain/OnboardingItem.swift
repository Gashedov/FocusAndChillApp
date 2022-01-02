//
//  OnboardingItem.swift
//  FocOn
//
//  Created by Artem Gorshkov on 26.12.21.
//

import UIKit

enum OnboardingOption: Int {
    case rain
    case forest
    case sea
    case fire

    case jazz
    case loFi
    case classic

    var title: String {
        switch self {
        case .rain:
            return "Rain"
        case .forest:
            return "Forest"
        case .sea:
            return "Sea"
        case .fire:
            return "Fire"
        case .jazz:
            return "Jazz"
        case .loFi:
            return "Lo-Fi"
        case .classic:
            return "Classic"
        }
    }

    var image: UIImage? {
        switch self {
        case .rain:
            return R.image.colorlessRain()
        case .forest:
            return R.image.colorlessForest()
        case .sea:
            return R.image.colorlessSea()
        case .fire:
            return R.image.colorlessFire()
        case .jazz:
            return R.image.jazzIcon()
        case .loFi:
            return R.image.loFiImage()
        case .classic:
            return R.image.classicImage()
        }
    }

    var highlightedImage: UIImage? {
        switch self {
        case .rain:
            return R.image.colorfullRain()
        case .forest:
            return R.image.colorfullForest()
        case .sea:
            return R.image.colorfullSea()
        case .fire:
            return R.image.colorfullFire()
        default:
            return nil
        }
    }

}
