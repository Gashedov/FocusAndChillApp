//
//  MusicViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import AVFoundation

class MusicViewModelImpl: MusicViewModel {
    private let router: MusicRouter

    private var whiteNoizePlayer: AudioPlayer
    private var musicPlayer: AudioPlayer

    var music: [Sound] = []
    var whiteNoizes: [Sound] = []

    let initialPlayerVolume: Float = 0.5

    var delegate: MusicViewModelDelegate?

    init(router: MusicRouter) {
        self.router = router
        musicPlayer = AudioPlayer(initialVolume: initialPlayerVolume)
        whiteNoizePlayer = AudioPlayer(initialVolume: initialPlayerVolume)
        fetchMusic()
    }

    func soundSelected(at index: Int, for type: SoundType) {
        switch type {
        case .music:
            playMusic(from: music[index].url)
        case .whiteNoize:
            playWhiteNoize(from: whiteNoizes[index].url)
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

    func fetchMusic() {
        music = fetchSoundsFromBoundle(from: "Res/Sounds/Music", for: .music)
        whiteNoizes = fetchSoundsFromBoundle(from: "Res/Sounds/WhiteNoizes", for: .whiteNoize)
    }

    private func fetchSoundsFromBoundle(from urlString: String, for soundType: SoundType) -> [Sound] {
        let fileManager = FileManager.default
        guard let BoundleUrl = Bundle.main.resourceURL else { return [] }

        let resourceURL = BoundleUrl.appendingPathComponent(urlString)
        let resourceContent = (try? fileManager.contentsOfDirectory(
            at: resourceURL,
            includingPropertiesForKeys: nil
        )) ?? []


        return resourceContent.compactMap { soundFolderURL in
            guard let folderContent = try? fileManager.contentsOfDirectory(
                at: soundFolderURL,
                includingPropertiesForKeys: nil
            ) else { return nil }

            let imageURL = folderContent.first(where: { $0.pathExtension == "pdf" })
            let soundURL = folderContent.first(where: { $0.pathExtension == "mp3" })
            let soundName = soundFolderURL.pathComponents.last ?? ""
            return Sound(title: soundName, url: soundURL, image: imageURL, type: soundType)
        }
    }

    private func playWhiteNoize(from url: URL?) {
        guard let url = url else { return }
        whiteNoizePlayer.play(from: url)
    }

    private func playMusic(from url: URL?) {
        guard let url = url else { return }
        musicPlayer.play(from: url)
    }
}
