//
//  MainSceenView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import SnapKit
import Lottie

class HomeView: UIViewController {
    private let timerView = UIView()
    private let timerLabel = UILabel()
    private let timerIncreaseButton = UIButton()
    private let timerDecreaseButton = UIButton()
    private let backgroundAnimatedView = AnimationView()

    private var index = 0

    private var timer: Timer?
    private var totalTime = 0
    private var timerInitialValue = 2700
    @objc private let changesTimeValue = 300

    var viewModel: HomeViewModel?

    override func loadView() {
        view = UIView()

        view.addSubview(backgroundAnimatedView)
        backgroundAnimatedView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }

        view.addSubview(timerView)
        timerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
        }

        timerView.addSubview(timerDecreaseButton)
        timerDecreaseButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.size.equalTo(40)
        }

        timerView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.leading.equalTo(timerDecreaseButton.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.top.bottom.equalToSuperview()
        }

        timerView.addSubview(timerIncreaseButton)
        timerIncreaseButton.snp.makeConstraints {
            $0.leading.equalTo(timerLabel.snp.trailing)
            $0.trailing.top.bottom.equalToSuperview()
            $0.size.equalTo(40)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchThemeAnimations()

        setupUI()

        totalTime = timerInitialValue
        updateTimerLabel()
        let timerTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerView.addGestureRecognizer(timerTapRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundAnimatedView.play(completion: nil)
    }

    private func setupUI() {
        view.backgroundColor = .lightGray

        timerLabel.font = .systemFont(ofSize: 24)
        timerLabel.textAlignment = .center
        timerLabel.textColor = .lightText
        
        timerIncreaseButton.setImage(R.image.arrowUp(), for: .normal)
        timerIncreaseButton.tintColor = .lightText
        timerIncreaseButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        timerIncreaseButton.addTarget(self, action: #selector(changeTimerValue), for: .touchUpInside)

        timerDecreaseButton.setImage(R.image.arrowDown(), for: .normal)
        timerDecreaseButton.tintColor = .lightText
        timerDecreaseButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
        timerDecreaseButton.addTarget(self, action: #selector(changeTimerValue), for: .touchUpInside)

        backgroundAnimatedView.animation = viewModel?.animations[.full]
        backgroundAnimatedView.loopMode = .loop
        backgroundAnimatedView.contentMode = .scaleAspectFill
    }

    @objc private func changeTimerValue(_ sender: UIButton) {
        if sender == timerIncreaseButton {
            guard totalTime < 10800 else { return }
            totalTime += changesTimeValue
        }
        if sender == timerDecreaseButton {
            guard totalTime > 300 else { return }
            totalTime -= changesTimeValue
        }
        updateTimerLabel()
        timerInitialValue = totalTime
    }

    @objc private func startTimer() {
        if timer == nil {
            updateTimer()

            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(updateTimer),
                userInfo: nil,
                repeats: true
            )

            timerDecreaseButton.isHidden = true
            timerIncreaseButton.isHidden = true
        } else {
            timer?.invalidate()
            timer = nil

            totalTime = timerInitialValue
            updateTimerLabel()

            timerDecreaseButton.isHidden = false
            timerIncreaseButton.isHidden = false
        }
    }

    @objc private func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            setTimerValue(360)
        }
    }

    private func updateTimerLabel() {
        let seconds: Int = totalTime % 60
        let minutes: Int = (totalTime / 60) % 60
        let hours: Int = (totalTime / 3600) % 60
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func setTimerValue(_ value: Int) {
        guard value >= 300, value <= 10800 else { return }
        totalTime = value
        updateTimerLabel()
        timerInitialValue = totalTime
    }

    private func udpateTimerMode() {

    }
}
