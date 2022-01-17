//
//  MusicView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit
import Combine

class MusicView: UIViewController {
    private var canMusic: AnyCancellable?
    private var canNoize: AnyCancellable?
    private var canTheme: AnyCancellable?
    
    private let titleLabel = UILabel()

    private var musicItems: [SoundModel] = []
    private var noizeItems: [SoundModel] = []
    
    private let whiteNoizeContainer = UIView()
    private let whiteNoizeLabel = UILabel()
    private let whiteNoizeSlider = CustomSlider()

    private var selectedWhiteNoizeIndex: IndexPath?

    lazy var whiteNoizeCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()

        collectionLayout.scrollDirection = .vertical
        collectionLayout.minimumLineSpacing = 10
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.itemSize = CGSize(width: 85, height: 85)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)

        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear

        collection.register(SoundCollectionViewCell.self)
        return collection
    }()

    private let musicContainer = UIView()
    private let musicLabel = UILabel()
    private let musicSlider = CustomSlider()

    private var selectedMusicIndex: IndexPath?

    lazy var musicCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()

        collectionLayout.scrollDirection = .vertical
        collectionLayout.minimumLineSpacing = 10
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.itemSize = CGSize(width: 85, height: 85)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)

        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear

        collection.register(SoundCollectionViewCell.self)
        return collection
    }()

    var viewModel: MusicViewModel!
    var theme: Theme?
    
    override func loadView() {
        view = UIView()

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        view.addSubview(whiteNoizeContainer)
        whiteNoizeContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }

        whiteNoizeContainer.addSubview(whiteNoizeLabel)
        whiteNoizeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        whiteNoizeContainer.addSubview(whiteNoizeSlider)
        whiteNoizeSlider.snp.makeConstraints {
            $0.leading.equalTo(whiteNoizeLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(whiteNoizeLabel)
        }

        whiteNoizeContainer.addSubview(whiteNoizeCollectionView)
        whiteNoizeCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(whiteNoizeLabel.snp.bottom).offset(10)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview()
        }

        view.addSubview(musicContainer)
        musicContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(whiteNoizeContainer.snp.bottom).offset(20)
            $0.bottom.lessThanOrEqualToSuperview()
        }

        musicContainer.addSubview(musicLabel)
        musicLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        musicContainer.addSubview(musicSlider)
        musicSlider.snp.makeConstraints {
            $0.leading.equalTo(musicLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(musicLabel)
        }

        musicContainer.addSubview(musicCollectionView)
        musicCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(musicLabel.snp.bottom).offset(10)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Track.didShow(screen: .music)
    }
    
    private func setupViewModel() {
        canTheme = viewModel.themePublisher?.sink { [weak self] theme in
            self?.updateUI(theme: theme)
            self?.theme = theme
        }
        canMusic = viewModel.musicPublisher?.sink { [weak self] values in
            self?.musicItems = values
            self?.musicCollectionView.reloadData()
        }
        canNoize = viewModel.whiteNoizesPublisher?.sink { [weak self] values in
            self?.noizeItems = values
            self?.whiteNoizeCollectionView.reloadData()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }

        view.backgroundColor = R.color.backgroundColor()

        titleLabel.text = "Music"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textAlignment = .left

        whiteNoizeLabel.text = "White noize"
        whiteNoizeLabel.font = .systemFont(ofSize: 25, weight: .semibold)

        whiteNoizeSlider.thumbImage(radius: 15)
        whiteNoizeSlider.value = viewModel.initialPlayerVolume
        whiteNoizeSlider.addTarget(self, action: #selector(sliderValueChangedAction(_:)), for: .valueChanged)

        musicLabel.text = "Music stream"
        musicLabel.font = .systemFont(ofSize: 25, weight: .semibold)

        musicSlider.thumbImage(radius: 15)
        musicSlider.value = viewModel.initialPlayerVolume
        musicSlider.addTarget(self, action: #selector(sliderValueChangedAction(_:)), for: .valueChanged)
    }

    func updateUI(theme: Theme) {
        titleLabel.textColor = theme.primaryColor
        whiteNoizeLabel.textColor = theme.primaryColor
        whiteNoizeSlider.thumbTintColor = theme.primaryColor
        whiteNoizeSlider.tintColor = theme.primaryColor
        musicLabel.textColor = theme.primaryColor
        musicSlider.thumbTintColor = theme.primaryColor
        musicSlider.tintColor = theme.primaryColor

        musicCollectionView.reloadData()
        whiteNoizeCollectionView.reloadData()
    }

    @objc
    private func sliderValueChangedAction(_ sender: UISlider) {
        if sender == whiteNoizeSlider {
            viewModel?.setup(volume: sender.value, for: .whiteNoize)
        } else if sender == musicSlider {
            viewModel?.setup(volume: sender.value, for: .music)
        }
    }
}

extension MusicView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == whiteNoizeCollectionView {
            if selectedWhiteNoizeIndex == indexPath {
                collectionView.deselectItem(at: indexPath, animated: true)
                selectedWhiteNoizeIndex = nil
                viewModel?.soundDeselected(type: .whiteNoize)
            } else {
                selectedWhiteNoizeIndex = indexPath
                viewModel?.soundSelected(at: indexPath.row, type: .whiteNoize)
                Track.action(.musicSelectNoise(value: WhiteNoizeItem(rawValue: indexPath.row)))
            }
            
        } else if collectionView == musicCollectionView {
            if selectedMusicIndex == indexPath {
                collectionView.deselectItem(at: indexPath, animated: true)
                selectedMusicIndex = nil
                viewModel?.soundDeselected(type: .music)
            } else {
                selectedMusicIndex = indexPath
                viewModel?.soundSelected(at: indexPath.row, type: .music)
                Track.action(.musicSelectMusic(value: MusicItem(rawValue: indexPath.row)))
            }
        }
    }
}

extension MusicView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        if collectionView == whiteNoizeCollectionView {
            count = noizeItems.count
        } else if collectionView == musicCollectionView {
            count = musicItems.count
        }

        return count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        var resultCell = UICollectionViewCell()
        if collectionView == whiteNoizeCollectionView {
            let sound = noizeItems[indexPath.row]
            let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(
                title: sound.title,
                image: sound.icon,
                primaryColor: theme?.primaryColor ?? .white,
                selected: indexPath == selectedWhiteNoizeIndex
            )
            resultCell = cell
        } else if collectionView == musicCollectionView {
            let sound = musicItems[indexPath.row]
            let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(
                title: sound.title,
                image: sound.icon,
                primaryColor: theme?.primaryColor ?? .white,
                selected: indexPath == selectedMusicIndex
            )
            resultCell = cell
        }

        return resultCell
    }
}
