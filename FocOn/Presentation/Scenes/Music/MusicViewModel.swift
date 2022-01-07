//
//  MusicViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import AVFoundation

class MusicViewModelImpl: MusicViewModel {
    private let router: MusicRouter
    var theme: Theme {
        Theme(rawValue: UserDefaultsService.shared.currentThemeCode) ?? .forest
    }

    private var whiteNoizePlayer: AudioPlayer
    private var musicPlayer: AudioPlayer

    var music: [SoundModel] = MusicItem.allCases
    var whiteNoizes: [SoundModel] = WhiteNoizeItem.allCases

    let initialPlayerVolume: Float = 0.5

    var delegate: MusicViewModelDelegate?
    var mainScreenDelegate: MainScreenDelegate?

    init(router: MusicRouter) {
        self.router = router
        musicPlayer = AudioPlayer(initialVolume: initialPlayerVolume)
        whiteNoizePlayer = AudioPlayer(initialVolume: initialPlayerVolume)
    }

    func soundSelected(at index: Int, type: SoundType) {
        guard let boundleUrl = Bundle.main.resourceURL else { return }

        switch type {
        case .music:
            let url = boundleUrl.appendingPathComponent(music[index].soundUrlString)
            musicPlayer.play(from: url)
        case .whiteNoize:
            guard let item = whiteNoizes[index] as? WhiteNoizeItem else { return }
            let url = boundleUrl.appendingPathComponent(item.soundUrlString)
            whiteNoizePlayer.play(from: url)

            if UserDefaultsService.shared.currentThemeCode != item.rawValue {
                UserDefaultsService.shared.currentThemeCode = item.rawValue
                mainScreenDelegate?.themeDidChange()
            }
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
