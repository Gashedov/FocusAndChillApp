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
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(120)
            $0.height.equalTo(30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .lightGray

        // imageView.image = R.image.screenImage()

        timerLabel.text = "00:40:00"
        timerLabel.font = .systemFont(ofSize: 24)
        timerLabel.textAlignment = .center
        
        timerIncreaseButton.setImage(R.image.arrowUp(), for: .normal)
        timerIncreaseButton.tintColor = .purple
        timerIncreaseButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)

        timerDecreaseButton.setImage(R.image.arrowDown(), for: .normal)
        timerDecreaseButton.tintColor = .purple
        timerDecreaseButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)

        activeUsersView.backgroundColor = .blue
    }
}
