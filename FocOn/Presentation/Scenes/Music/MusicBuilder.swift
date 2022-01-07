//
//  MusicBuilder.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit

class MusicBuilderImpl: MusicBuilder {
    func build(withDelegate delegate: MainScreenDelegate) -> UIViewController {
        let view = MusicView()
        let router = MusicRouterImpl(view: view)
        let viewModel = MusicViewModelImpl(router: router)
        viewModel.delegate = view
        viewModel.mainScreenDelegate = delegate
        view.viewModel = viewModel
        return view
    }
}
