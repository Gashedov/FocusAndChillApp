//
//  BoardViewController.swift
//  FocOn
//
//  Created by Artem Gorshkov on 23.12.21.
//


import UIKit

class BoardViewController: UIViewController {
    //MARK: - Properties
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let buttonsCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private var callback: ((Int) -> Void)?
    private var items: [SoundModel]
    private var theme: Theme

    var preselectedItemIndex: Int? = nil

    init(
        theme: Theme,
        items: [SoundModel],
        callback: ((Int) -> Void)? = nil
    ) {
        self.callback = callback
        self.items = items
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life cycle methods
    override func loadView() {
        view = UIView()

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(100)
        }

        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(100)
        }

        view.addSubview(buttonsCollectionView)
        buttonsCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(buttonsCollectionView.snp.width)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func changeTheme(to theme: Theme) {
        self.theme = theme
        buttonsCollectionView.reloadData()
    }

    //MARK: - Private methods
    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 34)
        titleLabel.numberOfLines = 0

        descriptionLabel.font = .systemFont(ofSize: 17, weight: .light)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white.withAlphaComponent(0.6)

        buttonsCollectionView.backgroundColor = .clear
        buttonsCollectionView.showsVerticalScrollIndicator = false
        buttonsCollectionView.showsHorizontalScrollIndicator = false
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.delegate = self
        buttonsCollectionView.bounces = false
        buttonsCollectionView.register(BoardCollectionViewCell.self)
        buttonsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        if let preselectedItemIndex = preselectedItemIndex {
            buttonsCollectionView.selectItem(
                at: IndexPath(row: preselectedItemIndex, section: 0),
                animated: true,
                scrollPosition: .top
            )
        }

        buttonsCollectionView.contentInsetAdjustmentBehavior = .never

        guard let flowLayout = buttonsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
    }
}

extension BoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat
        let height: CGFloat

        let collectionViewWidth = collectionView.bounds.size.width
        let collectionViewHeight = collectionView.bounds.size.height

        if items.count % 2 != 0,
           indexPath.item == 0
        {
            width = collectionViewWidth - 45
            height = collectionViewHeight/2 - 30
        } else {
            width = collectionViewWidth/2 - 30
            height = collectionViewHeight/2 - 30
        }
        return CGSize(width: width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}

extension BoardViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: BoardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = items[indexPath.item]
        cell.setup(
            title: item.title,
            image: item.onboardingImage,
            highlightedImage: item.selectedOnboardingImage,
            primaryColor: theme.primaryColor
        )
        return cell
    }
}

extension BoardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callback?(indexPath.item)
    }
}
