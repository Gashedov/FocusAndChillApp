//
//  MainScreenBuilder.swift
//  FocOn
//
//  Created by Artem Gorshkov on 21.09.21.
//

import UIKit

class MainScreenBuilderImpl {
    func build() -> UIViewController {
        let view = MainScreenView()

        let homeView = HomeBuilderImpl().build()
        homeView.tabBarItem.image = R.image.homeButton()

        let musicView = MusicBuilderImpl().build()
        musicView.tabBarItem.image = R.image.musicIcon()

        view.setViewControllers([homeView, musicView])

        return view
    }
}
