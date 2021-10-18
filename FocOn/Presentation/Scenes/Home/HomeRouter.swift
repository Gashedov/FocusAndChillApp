//
//  MainScreenRouter.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

class HomeRouterImpl: HomeRouter {
    private weak var view: UIViewController?

    lazy var slideInTransitioningDelegate = SlideInPresentationManager()

    init(view: UIViewController) {
        self.view = view
    }

    @objc func openSettings() {
        let settingsView = SettingsView()
        slideInTransitioningDelegate.direction = .bottom
        settingsView.transitioningDelegate = slideInTransitioningDelegate
        settingsView.modalPresentationStyle = .custom
        settingsView.modalTransitionStyle = .crossDissolve
        view?.showDetailViewController(settingsView, sender: self)
    }
}

