//
//  MainScreenViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import Foundation

class HomeViewModelImpl: HomeViewModel {
    let router: HomeRouter

    init(router: HomeRouter) {
        self.router = router
    }

    func showSettings() {
        router.openSettings()
    }
}
