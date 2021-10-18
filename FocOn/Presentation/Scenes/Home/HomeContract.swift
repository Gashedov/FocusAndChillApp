//
//  MainScreenContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

protocol HomeBuilder {
    func build() -> UIViewController
}

protocol HomeViewModel {
    func showSettings()
}

protocol HomeRouter {
    func openSettings()
}
