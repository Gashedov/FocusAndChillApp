//
//  OnboardingViewMdodel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import Foundation

class OnboardingViewModelImpl: OnboardingViewModel {
    //MARK: - Properties
    private let router: OnboardingRouter

    var currentTheme: Theme {
        Theme(rawValue: UserDefaultsService.shared.currentThemeCode) ?? .rain
    }

    weak var delegate: OnboardingViewModelDelegate?

    //MARK: - Initializer
    init(router: OnboardingRouter) {
        self.router = router
    }

    //MARK: - Internal methods
    func changeTheme(to theme: Theme) {
        UserDefaultsService.shared.currentThemeCode = theme.rawValue
    }

    func moveToMainScreen() {
        router.moveToMainScreen(withTheme: currentTheme)
    }

    //MARK: - Private methods
}
