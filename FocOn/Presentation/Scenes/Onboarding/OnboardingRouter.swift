//
//  OnboardingRouter.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import UIKit

class OnboardingRouterImpl: OnboardingRouter {
    weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func moveToMainScreen() {
        view?.navigationController?.viewControllers = [MainScreenBuilderImpl().build()]
    }
}
