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
    

//    func fetchMusic() {
//        fetchSoundsFromBoundle(from: "Res/Sounds/Music", for: .music)
//    }
//
//    private func fetchSoundsFromBoundle(from urlString: String, for soundType: SoundType) -> [Sound] {
//        let fileManager = FileManager.default
//        guard let BoundleUrl = Bundle.main.resourceURL else { return [] }
//
//        let resourceURL = BoundleUrl.appendingPathComponent(urlString)
//        let resourceContent = (try? fileManager.contentsOfDirectory(
//            at: resourceURL,
//            includingPropertiesForKeys: nil
//        )) ?? []
//
//
//        return resourceContent.compactMap { soundFolderURL in
//            guard let folderContent = try? fileManager.contentsOfDirectory(
//                at: soundFolderURL,
//                includingPropertiesForKeys: nil
//            ) else { return nil }
//
//            let imageURL = folderContent.first(where: { $0.pathExtension == "pdf" })
//            let soundURL = folderContent.first(where: { $0.pathExtension == "mp3" })
//            let soundName = soundFolderURL.pathComponents.last ?? ""
//            return Sound(title: soundName, url: soundURL, image: imageURL, type: soundType)
//        }
//    }
}
