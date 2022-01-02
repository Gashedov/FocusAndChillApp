//
//  MainScreenContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import Lottie

protocol HomeBuilder {
    func build(withTheme: Theme) -> UIViewController
}

protocol HomeViewModel {
    var animations: [AnimationState: Animation] { get }
    func fetchThemeAnimations()
}

protocol HomeRouter {
}
