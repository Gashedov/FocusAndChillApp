//
//  MainSceenView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import SnapKit

class HomeView: UIViewController {
    private let imageView = UIImageView()
    private let timerView = UIView()
    private let timerLabel = UILabel()
    private let timerIncreaseButton = UIButton()
    private let timerDecreaseButton = UIButton()
    private let activeUsersView = UIView()
    private let activeUsersLabel = UILabel()

    private var timer: Timer?
    private var totalTime = 0
    private var timerInitialValue = 2700
    @objc private let changesTimeValue = 300

    var viewModel: HomeViewModel?

    override func loadView() {
        view = UIView()

        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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

        view.addSubview(activeUsersView)
        activeUsersView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(30)
        }

        view.addSubview(activeUsersLabel)
        activeUsersLabel.snp.makeConstraints {
            $0.leading.equalTo(activeUsersView).offset(6)
            $0.top.equalTo(activeUsersView.snp.bottom).offset(4)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        totalTime = timerInitialValue
        updateTimerLabel()
        let timerTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerView.addGestureRecognizer(timerTapRecognizer)
    }

    private func setupUI() {
        view.backgroundColor = .lightGray

        // imageView.image = R.image.screenImage()

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

        activeUsersView.backgroundColor = .lightText
        activeUsersView.layer.cornerRadius = 15

        activeUsersLabel.font = .systemFont(ofSize: 12, weight: .light)
        activeUsersLabel.text = "active users: 123"
        activeUsersLabel.textColor = .lightText
    }

    @objc private func changeTimerValue(_ sender: UIButton) {
        if sender == timerIncreaseButton {
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
        }
    }

    private func updateTimerLabel() {
        let seconds: Int = totalTime % 60
        let minutes: Int = (totalTime / 60) % 60
        let hours: Int = (totalTime / 3600) % 60
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
