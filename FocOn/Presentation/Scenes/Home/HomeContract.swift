//
//  MainScreenContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import Lottie

protocol HomeBuilder {
    func build() -> UIViewController
}

protocol HomeViewModel {
    var animations: [AnimationState: Animation] { get }
    func fetchThemeAnimations()
    func updateAnimations()
}

protocol HomeRouter {
}
