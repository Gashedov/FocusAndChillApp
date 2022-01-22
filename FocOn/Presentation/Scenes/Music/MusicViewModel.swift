//
//  MusicViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import AVFoundation
import Combine

class MusicViewModelImpl: MusicViewModel {
    private var can: AnyCancellable?
    private let router: MusicRouter
    private let themeRepository: ThemeRepository
    private let musicRepository: MusicRepository
    
    private var whiteNoizePlayer: AudioPlayer
    private var musicPlayer: AudioPlayer
    
    var themePublisher: AnyPublisher<Theme, Never>? {
        themeRepository.themePublisher.eraseToAnyPublisher()
    }
    var musicPublisher: AnyPublisher<[SoundModel], Never>? {
        musicRepository.musicPublisher.eraseToAnyPublisher()
    }
    var whiteNoizesPublisher: AnyPublisher<[SoundModel], Never>? {
        musicRepository.whiteNoizesPublisher.eraseToAnyPublisher()
    }
    
    let initialPlayerVolume: Float = 0.5

    init(router: MusicRouter, themeRepository: ThemeRepository, musicRepository: MusicRepository) {
        self.router = router
        self.themeRepository = themeRepository
        self.musicRepository = musicRepository
    
        musicPlayer = AudioPlayer(initialVolume: initialPlayerVolume)
        whiteNoizePlayer = AudioPlayer(initialVolume: initialPlayerVolume)
    }

    func soundSelected(at index: Int, type: SoundType) {
        switch type {
        case .music:
            let url = musicRepository.urlForMusic(by: index)
            musicPlayer.play(from: url)
        case .whiteNoize:
            let url = musicRepository.urlForNoize(by: index)
            whiteNoizePlayer.play(from: url)
            
            themeRepository.theme = musicRepository.themeForNoize(by: index) ?? themeRepository.theme
        }
    }

    func soundDeselected(type: SoundType) {
        switch type {
        case .music:
            musicPlayer.pause()
        case .whiteNoize:
            whiteNoizePlayer.pause()
        }

    }

    func setup(volume: Float, for type: SoundType) {
        switch type {
        case .music:
            musicPlayer.setVolume(volume)
        case .whiteNoize:
            whiteNoizePlayer.setVolume(volume)
        }
    }
    
}
