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
}
