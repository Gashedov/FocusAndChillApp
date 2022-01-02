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
    private var theme: Theme

    var animations: [AnimationState: Animation] = [:]

    init(
        router: HomeRouter,
         theme: Theme
    ) {
        self.router = router
        self.theme = theme
    }

    func fetchThemeAnimations() {
        animations = fetchAnimations(named: theme.animationFolderName)
    }
    
    private func fetchAnimations(named: String) -> [AnimationState: Animation] {
        let fileManager = FileManager.default
        guard let boundleUrl = Bundle.main.resourceURL else { return [:] }

        let folderURL = boundleUrl.appendingPathComponent("Res/Animations")
        let resourceURL = folderURL.appendingPathComponent(named)

        let resourceContent = (try? fileManager.contentsOfDirectory(
            at: resourceURL,
            includingPropertiesForKeys: nil
        )) ?? []

        var result: [AnimationState: Animation] = [:]

        resourceContent.forEach { path in
            let pathString = path.relativePath
            let states = AnimationState.allCases
            states.forEach { state in
                if pathString.contains(state.rawValue) {
                    result[state] = Animation.filepath(pathString, animationCache: nil)
                }
            }
        }
        return result
    }
}
