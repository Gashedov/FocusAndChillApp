//
//  MainScreenView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 21.09.21.
//

import UIKit

class MainScreenView: TransparentTabBarController {
    private let settingsButton = UIButton()
    private let timerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(40)
        }

        view.addSubview(timerButton)
        timerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(44)
            $0.size.equalTo(50)
        }
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        settingsButton.setImage(R.image.hamburger(), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)

        timerButton.setImage(R.image.timerIcon(), for: .normal)
        timerButton.layer.cornerRadius = 25
        timerButton.tintColor = .lightGray
        timerButton.backgroundColor = .black.withAlphaComponent(0.1)
        timerButton.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)
    }

    @objc
    private func settingsButtonAction() {
        Track.action(.mainSettings)
        let settingsView = SettingsBuilderImpl().build()
        settingsView.modalPresentationStyle = .custom
        settingsView.modalTransitionStyle = .crossDissolve
        present(settingsView, animated: true)
    }

    @objc
    private func timerButtonAction() {
        Track.action(.mainTimer)
        
        let builder = TimerSelectorViewControllerBuilder()
        present(builder.build(), animated: true, completion: nil)
    }
}

extension MainScreenView: MainScreenDelegate {
    func themeDidChange() {
        guard let controllers = viewControllers as? [TabController] else { return }
        controllers.forEach {
            $0.updateUI()
        }
    }
}
