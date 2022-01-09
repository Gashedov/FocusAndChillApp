//
//  FBAnalyticsTracker.swift
//  FocOn
//
//  Created by Nikita Zhukov on 09.01.2022.
//

import FirebaseAnalytics

class FBAnalyticsTracker: AnalyticsTracking {
    func open(screen: String) {
        var args = [String: Any]()
        
        args[AnalyticsParameterScreenName] = screen
        
        Analytics.logEvent(AnalyticsEventScreenView, parameters: args)
    }
    
    func fire(screen: String, action: String, value: String?) {
        var args = [String: Any]()
        
        args[AnalyticsParameterScreenName] = screen
        args[AnalyticsParameterItemName] = action
        args[AnalyticsParameterValue] = value
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: args)
    }
}
