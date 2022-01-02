//
//  AnimationState.swift
//  FocOn
//
//  Created by Artem Gorshkov on 2.01.22.
//

enum AnimationState: String {
    case chill
    case down
    case full
    case up
    case write


    static var allCases: [AnimationState] {
        return [.chill, .down, .full, .up, .write]
    }
}
