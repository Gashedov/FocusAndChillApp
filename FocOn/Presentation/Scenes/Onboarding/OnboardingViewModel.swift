//
//  OnboardingViewMdodel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import Foundation
import Combine

class OnboardingViewModelImpl: OnboardingViewModel {
    //MARK: - Properties
    private let router: OnboardingRouter
    private let themeRepository: ThemeRepository

    var themePublisher: AnyPublisher<Theme, Never>? {
        themeRepository.themePublisher.eraseToAnyPublisher()
    }
    
    var themeDidChange: ((Theme) -> Void)?

    //MARK: - Initializer
    init(router: OnboardingRouter, themeRepository: ThemeRepository) {
        self.router = router
        self.themeRepository = themeRepository
    }

    //MARK: - Internal methods
    func changeTheme(to theme: Theme) {
        themeRepository.theme = theme
    }

    func moveToMainScreen() {
        router.moveToMainScreen()
    }

    //MARK: - Private methods
    
//    private func subscribe() {
//        can = themeRepository.themePublisher.sink { [weak self] theme in
//            self?.themeDidChange?(theme)
//        }
//    }
}
