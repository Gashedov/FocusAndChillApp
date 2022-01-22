//
//  MusicBuilder.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit

class MusicBuilderImpl: MusicBuilder {
    func build() -> UIViewController {
        let view = MusicView()
        let router = MusicRouterImpl(view: view)
        let viewModel = MusicViewModelImpl(router: router,
                                           themeRepository: RepositoriesProvider.shared.themeRepository,
                                           musicRepository: RepositoriesProvider.shared.musicRepository)
        
        view.viewModel = viewModel
        return view
    }
}
