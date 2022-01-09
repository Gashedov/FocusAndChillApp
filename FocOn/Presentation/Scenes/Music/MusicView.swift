//
//  MusicView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

class MusicView: UIViewController, TabController {
    private let titleLabel = UILabel()

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

    var viewModel: MusicViewModel?

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Track.didShow(screen: .music)
    }

    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }

        view.backgroundColor = R.color.backgroundColor()

        titleLabel.text = "Music"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = viewModel.theme.primaryColor

        whiteNoizeLabel.text = "White noize"
        whiteNoizeLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        whiteNoizeLabel.textColor = viewModel.theme.primaryColor

        whiteNoizeSlider.thumbTintColor = viewModel.theme.primaryColor
        whiteNoizeSlider.tintColor = viewModel.theme.primaryColor
        whiteNoizeSlider.thumbImage(radius: 15)
        whiteNoizeSlider.value = viewModel.initialPlayerVolume
        whiteNoizeSlider.addTarget(self, action: #selector(sliderValueChangedAction(_:)), for: .valueChanged)

        musicLabel.text = "Music stream"
        musicLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        musicLabel.textColor = viewModel.theme.primaryColor

        musicSlider.thumbTintColor = viewModel.theme.primaryColor
        musicSlider.tintColor = viewModel.theme.primaryColor
        musicSlider.thumbImage(radius: 15)
        musicSlider.value = viewModel.initialPlayerVolume
        musicSlider.addTarget(self, action: #selector(sliderValueChangedAction(_:)), for: .valueChanged)
    }

    func updateUI() {
        titleLabel.textColor = viewModel?.theme.primaryColor
        whiteNoizeLabel.textColor = viewModel?.theme.primaryColor
        whiteNoizeSlider.thumbTintColor = viewModel?.theme.primaryColor
        whiteNoizeSlider.tintColor = viewModel?.theme.primaryColor
        musicLabel.textColor = viewModel?.theme.primaryColor
        musicSlider.thumbTintColor = viewModel?.theme.primaryColor
        musicSlider.tintColor = viewModel?.theme.primaryColor

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
            count = viewModel?.whiteNoizes.count
        } else if collectionView == musicCollectionView {
            count = viewModel?.music.count
        }

        return count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }

        var resultCell = UICollectionViewCell()
        if collectionView == whiteNoizeCollectionView {
            let sound = viewModel.whiteNoizes[indexPath.row]
            let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(
                title: sound.title,
                image: sound.icon,
                primaryColor: viewModel.theme.primaryColor ?? .white,
                selected: indexPath == selectedWhiteNoizeIndex
            )
            resultCell = cell
        } else if collectionView == musicCollectionView {
            let sound = viewModel.music[indexPath.row]
            let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(
                title: sound.title,
                image: sound.icon,
                primaryColor: viewModel.theme.primaryColor ?? .white,
                selected: indexPath == selectedMusicIndex
            )
            resultCell = cell
        }

        return resultCell
    }
}

extension MusicView: MusicViewModelDelegate {
    func musicReceived() {
        whiteNoizeCollectionView.reloadData()
        musicCollectionView.reloadData()
    }
}
