//
//  MainScreenContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 4.01.22.
//

import Foundation

protocol MainScreenDelegate: AnyObject {
    func themeDidChange()
}

protocol TabController {
    func updateUI()
}
