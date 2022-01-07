//
//  MainScreenViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import Foundation
import Lottie

class HomeViewModelImpl: HomeViewModel {
    private let router: HomeRouter
    private var theme: Theme {
        let code = UserDefaultsService.shared.currentThemeCode
        return Theme(rawValue: code) ?? .forest
    }

    var animations: [AnimationState: Animation] = [:]

    init(router: HomeRouter) {
        self.router = router
    }

    func fetchThemeAnimations() {
        animations = fetchAnimations(named: theme.animationFolderName)
    }

    func updateAnimations() {
        fetchThemeAnimations()
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
