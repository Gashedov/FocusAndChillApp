//
//  MainScreenBuilder.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

class HomeBuilderImpl: HomeBuilder {
    func build(withTheme theme: Theme) -> UIViewController {
        let view = HomeView()
        let router = HomeRouterImpl(view: view)
        let viewModel = HomeViewModelImpl(
            router: router,
            theme: theme
        )
        view.viewModel = viewModel
        return view
    }
}
