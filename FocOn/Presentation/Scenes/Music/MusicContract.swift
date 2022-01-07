//
//  MusicContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit

enum SoundType {
    case music
    case whiteNoize
}

protocol MusicBuilder {
    func build(withDelegate: MainScreenDelegate) -> UIViewController
}

protocol MusicViewModel {
    var theme: Theme { get }
    var music: [SoundModel] { get }
    var whiteNoizes: [SoundModel] { get }
    var delegate: MusicViewModelDelegate? { get set }
    var initialPlayerVolume: Float { get }
    
    func soundSelected(at: Int, type: SoundType)
    func soundDeselected(type: SoundType)
    func setup(volume: Float, for: SoundType)
}

protocol MusicViewModelDelegate {
    func musicReceived() 
}

protocol MusicRouter {
}
