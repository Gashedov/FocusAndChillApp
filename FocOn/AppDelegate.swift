//
//  AppDelegate.swift
//  FocOn
//
//  Created by Artem Gorshkov on 11.09.21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(rootViewController: OnboardingBuilderImpl().build())
        window?.makeKeyAndVisible()
        UserDefaultsDataSource.shared.didLaunchbefore = true
        return true
    }
}

