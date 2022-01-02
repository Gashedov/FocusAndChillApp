//
//  AppDelegate.swift
//  FocOn
//
//  Created by Artem Gorshkov on 11.09.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

//        if !UserDefaultsService.shared.didLaunchbefore {
            window?.rootViewController = UINavigationController(rootViewController: OnboardingBuilderImpl().build())
            window?.makeKeyAndVisible()
            UserDefaultsService.shared.didLaunchbefore = true
            return true
//        }
//
//        let currentTheme = Theme(rawValue: UserDefaultsService.shared.currentThemeCode) ?? .forest
//        window?.rootViewController = MainScreenBuilderImpl().build(withTheme: currentTheme)
//        window?.makeKeyAndVisible()
        return true
    }
}

