//
//  RepositoriesProvider.swift
//  FocOn
//
//  Created by Nikita Zhukov on 22.01.2022.
//

import Foundation

class RepositoriesProvider {
    static let shared = RepositoriesProvider()
    
    let themeRepository = ThemeRepository()
    let musicRepository = MusicRepository()
}
