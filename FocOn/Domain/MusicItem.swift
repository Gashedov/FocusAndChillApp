//
//  MusicItem.swift
//  FocOn
//
//  Created by Artem Gorshkov on 4.01.22.
//

import UIKit

enum MusicItem: Int, SoundModel, CaseIterable {
    case jazz
    case loFi
    case classic

    var title: String {
        switch self {
        case .jazz:
            return "Jazz"
        case .loFi:
            return "Lo-Fi"
        case .classic:
            return "Classic"
        }
    }

    var onboardingImage: UIImage? {
        switch self {
        case .jazz:
            return R.image.jazzIcon()
        case .loFi:
            return R.image.loFiImage()
        case .classic:
            return R.image.classicImage()
        }
    }

    var selectedOnboardingImage: UIImage? {
       return nil
    }

    var icon: UIImage? {
        switch self {
        case .jazz:
            return R.image.jazzIcon()
        case .loFi:
            return R.image.loFiImage()
        case .classic:
            return R.image.classicImage()
        }
    }

    var soundUrlString: String {
        switch self {
        case .jazz:
            return ""
        case .loFi:
            return "Res/Sounds/Music/Autumn/Autumn.mp3"
        case .classic:
            return ""
        }
    }
}
