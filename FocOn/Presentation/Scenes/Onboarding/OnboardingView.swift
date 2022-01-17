//
//  OnboardingView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import UIKit
import Combine
import SnapKit

class OnboardingView: UIPageViewController {
    //MARK: - Properties
    private var can: AnyCancellable?
    private let skipButton = UIButton()
    private let pageControl = UIPageControl(frame: .zero)

    private var pages: [UIViewController] = []

    var viewModel: OnboardingViewModel!

    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Track.didShow(screen: .onboard)
    }

    //MARK: - Private methods
    
    private func setupViewModel() {
        can = viewModel.themePublisher?.sink { [weak self] theme in
            self?.configureViewControllers(theme: theme)
            self?.setupUI(theme: theme)
        }
    }
    
    private func addSubviews() {
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(80)
        }

        view.insertSubview(pageControl, at: 0)
        view.bringSubviewToFront(pageControl)
        pageControl.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    private func setupUI(theme: Theme) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = theme.primaryColor

        dataSource = self
        delegate = self

        skipButton.setTitle("Skip", for: .normal)
        skipButton.tintColor = .white.withAlphaComponent(0.5)
        skipButton.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = .clear
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = .white
    }

    private func configureViewControllers(theme: Theme) {
        guard let viewModel = viewModel else {
            return
        }

        let musicViewController = BoardViewController(
            theme: theme,
            items: [MusicItem.loFi, MusicItem.jazz, MusicItem.classic],
            callback: { index in
                guard let music = MusicItem(rawValue: index) else { return }
                Track.action(.onboardSelectMusic(value: music))
                
                viewModel.moveToMainScreen()
            })
        
        musicViewController.titleLabel.text = "What music do you prefer?"
        musicViewController.descriptionLabel.text = "Relaxing classic music or joyful jazz for inspiration, or maybe Lo-Fi beats perfect for work and study"

        let whiteNoizesViewController = BoardViewController(
            theme: theme,
            items: [WhiteNoizeItem.rain, WhiteNoizeItem.forest, WhiteNoizeItem.sea, WhiteNoizeItem.fire],
            callback: { [unowned self] index in
                guard let theme = Theme(rawValue: index) else { return }
                Track.action(.onboardSelectTheme(value: theme))
                
                self.view.backgroundColor = theme.primaryColor
                musicViewController.changeTheme(to: theme)
                viewModel.changeTheme(to: theme)
                self.setViewControllers([musicViewController], direction: .forward, animated: true)
                self.pageControl.currentPage = 1
            }
        )

        whiteNoizesViewController.titleLabel.text = "Where would you like to be?"
        whiteNoizesViewController.descriptionLabel.text = "Choose from our four beautiful locations and enjoy your time with Martha!"
        whiteNoizesViewController.preselectedItemIndex = theme.rawValue

        pages = [whiteNoizesViewController, musicViewController]

        setViewControllers([pages[0]], direction: .forward, animated: true)
    }

    @objc
    func skipButtonAction() {
        viewModel?.moveToMainScreen()
    }
}

//MARK - UIPageViewControllerDelegate implementation
extension OnboardingView: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let pageViewControllers = pageViewController.viewControllers else { return }
        let pageContentViewController = pageViewControllers[0]
        pageControl.currentPage = pages.firstIndex(of: pageContentViewController) ?? 0
    }
}

//MARK - UIPageViewControllerDataSource implementation
extension OnboardingView: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}
