//
//  MainSceenView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import SnapKit
import Lottie

enum ProgressKeyFrames: CGFloat {
    case write = 0
    case up = 200
    case shake = 400
    case down = 600
    case end = 800
}

class HomeView: UIViewController, TabController {
    
    private var shouldStartKitty = false
    private let backgroundAnimatedView = AnimationView()

//    private var timer: Timer?
//    private var totalTime = 0
//    private var timerInitialValue = 2700
//    @objc private let changesTimeValue = 300

    var viewModel: HomeViewModel?

    override func loadView() {
        view = UIView()

        view.addSubview(backgroundAnimatedView)
        backgroundAnimatedView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchThemeAnimations()
        setupUI()
//        totalTime = timerInitialValue
//        updateTimerLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Track.didShow(screen: .home)
    }

    private func setupUI() {
        view.backgroundColor = .lightGray

        backgroundAnimatedView.animation = viewModel?.animations[.full]
//        startInfiniteWritingAnimation()
        startKittyShakingAnimation()
        backgroundAnimatedView.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showKittyAnimation))
        backgroundAnimatedView.isUserInteractionEnabled = true
        backgroundAnimatedView.addGestureRecognizer(tap)
    }

    func updateUI() {
        viewModel?.updateAnimations()
        backgroundAnimatedView.animation = viewModel?.animations[.full]
        startInfiniteWritingAnimation()
    }
    
    @objc
    private func showKittyAnimation() {
        shouldStartKitty = true
    }
    
    private func showAnimation() {
        if shouldStartKitty == true {
            shouldStartKitty = false
            startKittyShakingAnimation()
        } else {
            startInfiniteWritingAnimation()
        }
    }
    
    private func startInfiniteWritingAnimation() {
        backgroundAnimatedView.play(fromFrame: AnimationFrameTime(ProgressKeyFrames.write.rawValue),
                                    toFrame: AnimationFrameTime(ProgressKeyFrames.up.rawValue),
                                    loopMode: .playOnce) { [weak self] _ in
            if Int.random(in: 0...13) == 0 {
                self?.showKittyAnimation()
            }
            self?.showAnimation()
        }
    }
    
    private func startKittyShakingAnimation() {
        backgroundAnimatedView.play(fromFrame: AnimationFrameTime(ProgressKeyFrames.up.rawValue),
                                    toFrame: AnimationFrameTime(ProgressKeyFrames.end.rawValue),
                                    loopMode: .playOnce) { [weak self] _ in
            self?.showAnimation()
        }
    }

//    @objc private func changeTimerValue(_ sender: UIButton) {
//        if sender == timerIncreaseButton {
//            guard totalTime < 10800 else { return }
//            totalTime += changesTimeValue
//        }
//        if sender == timerDecreaseButton {
//            guard totalTime > 300 else { return }
//            totalTime -= changesTimeValue
//        }
//        updateTimerLabel()
//        timerInitialValue = totalTime
//    }
//
//    @objc private func startTimer() {
//        if timer == nil {
//            updateTimer()
//
//            timer = Timer.scheduledTimer(
//                timeInterval: 1.0,
//                target: self,
//                selector: #selector(updateTimer),
//                userInfo: nil,
//                repeats: true
//            )
//
//            timerDecreaseButton.isHidden = true
//            timerIncreaseButton.isHidden = true
//        } else {
//            timer?.invalidate()
//            timer = nil
//
//            totalTime = timerInitialValue
//            updateTimerLabel()
//
//            timerDecreaseButton.isHidden = false
//            timerIncreaseButton.isHidden = false
//        }
//    }
//
//    @objc private func updateTimer() {
//        if totalTime > 0 {
//            totalTime -= 1
//            updateTimerLabel()
//        } else {
//            timer?.invalidate()
//            timer = nil
//            setTimerValue(360)
//        }
//    }
//
//    private func updateTimerLabel() {
//        let seconds: Int = totalTime % 60
//        let minutes: Int = (totalTime / 60) % 60
//        let hours: Int = (totalTime / 3600) % 60
//        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
//    }
//
//    private func setTimerValue(_ value: Int) {
//        guard value >= 300, value <= 10800 else { return }
//        totalTime = value
//        updateTimerLabel()
//        timerInitialValue = totalTime
//    }
//
//    private func udpateTimerMode() {
//
//    }
}
