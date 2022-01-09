//
//  Track.swift
//  FocOn
//
//  Created by Nikita Zhukov on 09.01.2022.
//

import Foundation


protocol AnalyticsTracking {
    func open(screen: String)
    func fire(screen: String, action: String, value: String?)
}

class Track {
    private static let traker: AnalyticsTracking = FBAnalyticsTracker()
    
    class func didShow(screen: TrackerScreens) {
        traker.open(screen: screen.description())
    }
    
    class func action(_ action: TrackerActions) {
        traker.fire(screen: action.screen(),
                    action: action.action(),
                    value: action.value())
    }
}

