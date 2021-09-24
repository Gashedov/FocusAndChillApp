//
//  SettingsBuilder.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit

class SettingsBuilderImpl: SettingsBuilder {
    func build() -> UIViewController {
        let view = SettingsView()
        let router = SettingsRouterImpl(view: view)
        let viewModel = SettingsViewModelImpl(router: router)
        view.viewModel = viewModel
        return view
    }
}
