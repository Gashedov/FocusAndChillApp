//
//  MainScreenViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import Foundation
import Lottie
import Combine

class HomeViewModelImpl: HomeViewModel {
    private let router: HomeRouter
    private var can: AnyCancellable?
    private let themeRepository: ThemeRepository
    
    var themePublisher: AnyPublisher<Theme, Never>? {
        themeRepository.themePublisher
            .map { [weak self] theme in
                self?.onThemeUpdate(theme: theme)
                return theme
            }
            .eraseToAnyPublisher()
    }
    
    var animations: [AnimationState: Animation] = [:]

    init(router: HomeRouter, themeRepository: ThemeRepository) {
        self.router = router
        self.themeRepository = themeRepository
    }
    
    private func onThemeUpdate(theme: Theme) {
        animations = fetchAnimations(named: theme.animationFolderName)
    }

    private func fetchAnimations(named: String) -> [AnimationState: Animation] {
        guard let boundleUrl = Bundle.main.resourceURL else { return [:] }
        let folderURL = boundleUrl.appendingPathComponent("Res/Animations/\(named)")

        var result: [AnimationState: Animation] = [:]

        let states = AnimationState.allCases
        states.forEach { state in
            let pathUrl = folderURL.appendingPathComponent("\(state.rawValue).json")
            result[state] = Animation.filepath(pathUrl.relativePath, animationCache: nil)
        }
        return result
    }
}
