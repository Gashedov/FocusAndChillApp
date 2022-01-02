//
//  OnboardingContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import UIKit

protocol OnboardingViewModel {
    var delegate: OnboardingViewModelDelegate? { get set }
    var currentTheme: Theme { get }

    func changeTheme(to: Theme)
    func moveToMainScreen()
}

protocol OnboardingBuilder {
    func build() -> UIViewController
}

protocol OnboardingRouter {
    func moveToMainScreen(withTheme theme: Theme)
}

protocol OnboardingViewModelDelegate: AnyObject {

}
