//
//  ViewController.swift
//  FocOn
//
//  Created by Artem Gorshkov on 11.09.21.
//

import UIKit
import Lottie
import AVFoundation

class ViewController: UIViewController {

    var avPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://soundrelax.herokuapp.com/nose/tresk-kostra-kamin-27518")
        avPlayer = AVPlayer(url: url!)
        let time = CMTime(seconds: 1.0, preferredTimescale: 1000)
        avPlayer?.addPeriodicTimeObserver(forInterval: time, queue: DispatchQueue.global(), using: { time in
            print(time)
        })
        avPlayer?.actionAtItemEnd = .none
        avPlayer?.volume = 1.0
        avPlayer?.play()
    }


}

