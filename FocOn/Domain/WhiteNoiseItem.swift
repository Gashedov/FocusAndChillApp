//
//  WhiteNoiseItem.swift
//  FocOn
//
//  Created by Artem Gorshkov on 4.01.22.
//

import UIKit

enum WhiteNoizeItem: Int, SoundModel, CaseIterable {
    case rain
    case forest
    case sea
    case fire

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
        }
    }

    var onboardingImage: UIImage? {
        switch self {
        case .rain:
            return R.image.colorlessRain()
        case .forest:
            return R.image.colorlessForest()
        case .sea:
            return R.image.colorlessSea()
        case .fire:
            return R.image.colorlessFire()
        }
    }

    var selectedOnboardingImage: UIImage? {
        switch self {
        case .rain:
            return R.image.colorfullRain()
        case .forest:
            return R.image.colorfullForest()
        case .sea:
            return R.image.colorfullSea()
        case .fire:
            return R.image.colorfullFire()
        }
    }

    var icon: UIImage? {
        switch self {
        case .rain:
            return R.image.rainIcon()
        case .forest:
            return R.image.forestIcon()
        case .sea:
            return R.image.seaIcon()
        case .fire:
            return R.image.fireIcon()
        }
    }

    var soundUrlString: String {
        switch self {
        case .rain:
            return "Res/Sounds/WhiteNoizes/Rain/Rain.mp3"
        case .forest:
            return ""
        case .sea:
            return "Res/Sounds/WhiteNoizes/Ocean/Ocean.mp3"
        case .fire:
            return "Res/Sounds/WhiteNoizes/Fire/Fire.mp3"
        }
    }
}
