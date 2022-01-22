//
//  UserDefaultsService.swift
//  FocOn
//
//  Created by Artem Gorshkov on 2.01.22.
//

import Foundation

class UserDefaultsDataSource {
    struct Key {
        static let didLaunchbefore = "didLaunchbefore"
        static let currentThemeCode = "currentTheme"
    }

    static let shared = UserDefaultsDataSource()

    var didLaunchbefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.didLaunchbefore)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.didLaunchbefore)
        }
    }

    var currentThemeCode: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.currentThemeCode)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.currentThemeCode)
        }
    }
}
