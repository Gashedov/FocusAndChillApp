//
//  Music.swift
//  FocOn
//
//  Created by Artem Gorshkov on 24.09.21.
//

import Foundation

struct Sound {
    let title: String
    let url: URL?
    let image: String
    let type: SoundType

    static var empty = Sound(
        title: "",
        url: URL(string: ""),
        image: "",
        type: .music
    )
}

enum SoundType {
    case music
    case whiteNoize
}
