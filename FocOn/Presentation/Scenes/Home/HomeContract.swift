//
//  MainScreenContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import Lottie
import Combine

protocol HomeBuilder {
    func build() -> UIViewController
}

protocol HomeViewModel {
    var themePublisher: AnyPublisher<Theme, Never>? { get }
    var animations: [AnimationState: Animation] { get }
}

protocol HomeRouter {
}
