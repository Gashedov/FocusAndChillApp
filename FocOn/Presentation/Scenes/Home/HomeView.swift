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

enum ProgressKeyFrames: CGFloat {
    case write = 0
    case up = 200
    case shake = 400
    case down = 600
    case end = 800
}

class HomeView: UIViewController {
    
    private var shouldStartKitty = false
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
    
    private func setupViewModel() {
        can = viewModel.themePublisher?.sink { [weak self] _ in
            self?.updateUI()
        }
    }
}
