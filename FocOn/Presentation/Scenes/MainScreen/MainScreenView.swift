//
//  MainScreenView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 21.09.21.
//

import UIKit

class MainScreenView: TransparentTabBarController {
    private let settingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(40)
        }
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        settingsButton.setImage(R.image.hamburger(), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
    }

    @objc private func settingsButtonAction() {
        let settingsView = SettingsBuilderImpl().build()
        settingsView.modalPresentationStyle = .custom
        settingsView.modalTransitionStyle = .crossDissolve
        present(settingsView, animated: true)
    }
}
