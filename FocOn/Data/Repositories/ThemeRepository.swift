//
//  ThemeRepository.swift
//  FocOn
//
//  Created by Nikita Zhukov on 17.01.2022.
//

import Foundation
import Combine

class ThemeRepository {
    var theme: Theme {
        get {
            Theme(rawValue: dataSource.currentThemeCode) ?? .forest
        }
        set {
            if dataSource.currentThemeCode != newValue.rawValue {
                dataSource.currentThemeCode = newValue.rawValue
                themePublisher.send(newValue)
            }
        }
    }
    let themePublisher: CurrentValueSubject<Theme, Never>
    
    private let dataSource: UserDefaultsDataSource
    
    init() {
        dataSource = UserDefaultsDataSource.shared
        themePublisher = CurrentValueSubject(Theme(rawValue: dataSource.currentThemeCode) ?? .forest)
    }
}
