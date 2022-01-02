//
//  OnboardingBuilder.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import UIKit

class OnboardingBuilderImpl: OnboardingBuilder {
    func build() -> UIViewController {
        let view = OnboardingView(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )

        let router = OnboardingRouterImpl(view: view)
        let viewModel = OnboardingViewModelImpl(router: router)

        view.viewModel = viewModel
        viewModel.delegate = view
        return view
    }
}

