//
//  OnboardingContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import UIKit
import Combine

protocol OnboardingViewModel {
    var themePublisher: AnyPublisher<Theme, Never>? { get }
    
    func changeTheme(to: Theme)
    func moveToMainScreen()
}

protocol OnboardingBuilder {
    func build() -> UIViewController
}

protocol OnboardingRouter {
    func moveToMainScreen()
}
