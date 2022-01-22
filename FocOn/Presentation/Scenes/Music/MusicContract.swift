//
//  MusicContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit
import Combine

enum SoundType {
    case music
    case whiteNoize
}

protocol MusicBuilder {
    func build() -> UIViewController
}

protocol MusicViewModel {
    var themePublisher: AnyPublisher<Theme, Never>? { get }
    var musicPublisher: AnyPublisher<[SoundModel], Never>? { get }
    var whiteNoizesPublisher: AnyPublisher<[SoundModel], Never>? { get }
    
    var initialPlayerVolume: Float { get }
    
    func soundSelected(at: Int, type: SoundType)
    func soundDeselected(type: SoundType)
    func setup(volume: Float, for: SoundType)
}

protocol MusicRouter {
}
