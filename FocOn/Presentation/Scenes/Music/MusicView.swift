//
//  MusicView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

class MusicView: UIViewController {
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
        viewModel?.fetchMusic()
    }

    private func setupUI() {
        view.backgroundColor = R.color.backgroundColor()

        titleLabel.text = "Music"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textAlignment = .left

        whiteNoizeLabel.text = "White noize"
        whiteNoizeLabel.font = .systemFont(ofSize: 25, weight: .semibold)

        whiteNoizeSlider.thumbTintColor = R.color.sliderThumbColor()
        whiteNoizeSlider.tintColor = .white
        whiteNoizeSlider.thumbImage(radius: 15)
        whiteNoizeSlider.value = viewModel?.initialPlayerVolume ?? 0
        whiteNoizeSlider.addTarget(self, action: #selector(sliderValueChangedAction(_:)), for: .valueChanged)

        musicLabel.text = "Music stream"
        musicLabel.font = .systemFont(ofSize: 25, weight: .semibold)

        musicSlider.thumbTintColor = R.color.sliderThumbColor()
        musicSlider.tintColor = .white
        musicSlider.thumbImage(radius: 15)
        musicSlider.value = viewModel?.initialPlayerVolume ?? 0
        musicSlider.addTarget(self, action: #selector(sliderValueChangedAction(_:)), for: .valueChanged)
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
            viewModel?.soundSelected(at: indexPath.row, for: .whiteNoize)

            if selectedWhiteNoizeIndex == indexPath {
                collectionView.deselectItem(at: indexPath, animated: true)
                selectedWhiteNoizeIndex = nil
            } else {
                selectedWhiteNoizeIndex = indexPath
            }
        } else if collectionView == musicCollectionView {
            viewModel?.soundSelected(at: indexPath.row, for: .music)
            
            if selectedMusicIndex == indexPath {
                collectionView.deselectItem(at: indexPath, animated: true)
                selectedMusicIndex = nil
            } else {
                selectedMusicIndex = indexPath
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }

        var sound: Sound?
        if collectionView == whiteNoizeCollectionView {
            sound = viewModel.whiteNoizes[indexPath.row]
            let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(title: sound?.title ?? "", imageURL: sound?.image)
            return cell
        } else if collectionView == musicCollectionView {
            sound = viewModel.music[indexPath.row]
            let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(title: sound?.title ?? "", imageURL: sound?.image)
            return cell
        }

        return UICollectionViewCell()
    }
}

extension MusicView: MusicViewModelDelegate {
    func musicReceived() {
        whiteNoizeCollectionView.reloadData()
        musicCollectionView.reloadData()
    }
}
