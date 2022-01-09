//
//  TrackerItems.swift
//  FocOn
//
//  Created by Nikita Zhukov on 09.01.2022.
//

import Foundation


enum TrackerActions {
    case onboardSkip
    case onboardSelectTheme(value: Theme)
    case onboardSelectMusic(value: MusicItem)
    case mainSettings
    case mainTimer
    case mainMusic
    case mainHome
    case musicSelectMusic(value: MusicItem?)
    case musicSelectNoise(value: WhiteNoizeItem?)
    
    func action() -> String {
        switch self {
        case .onboardSkip:
            return "skip pressed"
        case .onboardSelectTheme:
            return "theme selected"
        case .onboardSelectMusic:
            return "music selected"
        case .mainSettings:
            return "open settings pressed"
        case .mainTimer:
            return "setup timer pressed"
        case .mainMusic:
            return "change music pressed"
        case .mainHome:
            return "go to home pressed"
        case .musicSelectMusic:
            return "music selected"
        case .musicSelectNoise:
            return "moise selected"
        }
    }
    
    func screen() -> String {
        switch self {
        case .onboardSkip:
            return TrackerScreens.onboard.description()
        case .onboardSelectTheme:
            return TrackerScreens.onboard.description()
        case .onboardSelectMusic:
            return TrackerScreens.onboard.description()
        case .mainSettings:
            return TrackerScreens.main.description()
        case .mainTimer:
            return TrackerScreens.main.description()
        case .mainMusic:
            return TrackerScreens.main.description()
        case .mainHome:
            return TrackerScreens.main.description()
        case .musicSelectMusic:
            return TrackerScreens.music.description()
        case .musicSelectNoise:
            return TrackerScreens.music.description()
        }
    }
    
    func value() -> String? {
        switch self {
        case .onboardSkip:
            return nil
        case .onboardSelectTheme(let value):
            return title(from: value)
        case .onboardSelectMusic(let value):
            return title(from: value)
        case .mainSettings:
            return nil
        case .mainTimer:
            return nil
        case .mainMusic:
            return nil
        case .mainHome:
            return nil
        case .musicSelectMusic(let value):
            return title(from: value)
        case .musicSelectNoise(let value):
            return title(from: value)
        }
    }
    
    private func title(from: TrackerItemDescripting?) -> String? {
        return from?.description()
    }
}


enum TrackerScreens: TrackerItemDescripting {
    case onboard
    case home
    case settings
    case music
    case main
    
    func description() -> String {
        switch self {
        case .onboard:
            return "onboard view"
        case .home:
            return "home view"
        case .settings:
            return "settings view"
        case .music:
            return "music view"
        case .main:
            return "main view container"
        }
    }
}

extension Theme: TrackerItemDescripting {
    func description() -> String {
        return animationFolderName
    }
}

extension MusicItem: TrackerItemDescripting {
    func description() -> String {
        return title
    }
}

extension WhiteNoizeItem: TrackerItemDescripting {
    func description() -> String {
        return title
    }
}
