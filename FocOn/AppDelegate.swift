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
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        self.window?.rootViewController = MainScreenBuilderImpl().build()
        self.window?.makeKeyAndVisible()
        return true
    }
}

