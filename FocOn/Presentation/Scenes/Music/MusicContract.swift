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
    func build() -> UIViewController
}

protocol MusicViewModel {
    var music: [Sound] { get }
    var whiteNoizes: [Sound] { get }
    var delegate: MusicViewModelDelegate? { get set }
    var initialPlayerVolume: Float { get }
    
    func soundSelected(at: Int, for: SoundType)
    func setup(volume: Float, for: SoundType)
    func fetchMusic()
}

protocol MusicViewModelDelegate {
    func musicReceived() 
}

protocol MusicRouter {
}
