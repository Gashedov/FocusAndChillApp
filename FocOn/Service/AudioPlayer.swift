//
//  AudioPlayer.swift
//  FocOn
//
//  Created by Artem Gorshkov on 1.10.21.
//

import Foundation
import AVFoundation

class AudioPlayer {
    private var player: AVPlayer?
    private var playingFileURL: URL?

    private var currentVolume: Float

    var isOnRepeatMode: Bool = false

    init(initialVolume: Float) {
        currentVolume = initialVolume
    }

    func setVolume(_ volume: Float) {
        player?.volume = volume
        currentVolume = volume
    }

    func play(from url: URL) {
        playingFileURL = url

        if let player = player,
           let currentUrl = (player.currentItem?.asset as? AVURLAsset)?.url {
            if url == currentUrl {
                if player.rate != 0, player.error == nil {
                    player.pause()
                } else {
                    player.play()
                }
            } else {
                doPlay(for: url)
            }
        } else {
            doPlay(for: url)
        }
    }

    private func doPlay(for url: URL) {
        NotificationCenter.default.removeObserver(self)

        player = AVPlayer(url: url)
        player?.volume = currentVolume
        player?.play()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidEnded),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
    }

    @objc private func videoDidEnded(notification: Notification) {
        if isOnRepeatMode {
            guard let playerItem = notification.object as? AVPlayerItem else { return }
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            player?.play()
        }
    }
}
