//
//  OnboardingItem.swift
//  FocOn
//
//  Created by Artem Gorshkov on 26.12.21.
//

import UIKit

protocol SoundModel {
    var selectedOnboardingImage: UIImage? { get }
    var onboardingImage: UIImage? { get }
    var title: String { get }
    var icon: UIImage? { get }
    var soundUrlString: String { get }
}
