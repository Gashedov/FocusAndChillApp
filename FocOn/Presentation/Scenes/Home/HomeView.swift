//
//  MainSceenView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import SnapKit
import Combine
import Lottie

class HomeView: UIViewController {
    private let backgroundAnimatedView = AnimationView()

//    private var timer: Timer?
//    private var totalTime = 0
//    private var timerInitialValue = 2700
//    @objc private let changesTimeValue = 300

    private var can: AnyCancellable?
    var viewModel: HomeViewModel!

    override func loadView() {
        view = UIView()

        view.addSubview(backgroundAnimatedView)
        backgroundAnimatedView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
//        totalTime = timerInitialValue
//        updateTimerLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Track.didShow(screen: .home)
        backgroundAnimatedView.play(completion: nil)
    }

    private func setupUI() {
        view.backgroundColor = .lightGray

        backgroundAnimatedView.animation = viewModel.animations[.full]
        backgroundAnimatedView.loopMode = .loop
        backgroundAnimatedView.contentMode = .scaleAspectFill
    }

    func updateUI() {
        backgroundAnimatedView.animation = viewModel.animations[.full]
        backgroundAnimatedView.play(completion: nil)
    }
    
    private func setupViewModel() {
        can = viewModel.themePublisher?.sink { [weak self] _ in
            self?.updateUI()
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
