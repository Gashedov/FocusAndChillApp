//
//  MusicView.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

class MusicView: UIViewController {
    private let titleLabel = UILabel()

    private let flowLayout = UICollectionViewFlowLayout()

    private let whiteNoizeContainer = UIView()
    private let whiteNoizeLabel = UILabel()
    private let whiteNoizeSlider = UISlider()
    private let whiteNoizeCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private let musicContainer = UIView()
    private let musicLabel = UILabel()
    private let musicSlider = UISlider()
    private let musicCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

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
            $0.bottom.equalTo(whiteNoizeLabel)
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
            $0.bottom.equalTo(musicLabel)
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

    private func setupUI() {
        titleLabel.text = "Music"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textAlignment = .left

        whiteNoizeLabel.text = "White noize"
        whiteNoizeLabel.font = .systemFont(ofSize: 25, weight: .semibold)

        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 85, height: 85)

        whiteNoizeCollectionView.collectionViewLayout = flowLayout
        whiteNoizeCollectionView.delegate = self
        whiteNoizeCollectionView.dataSource = self
        whiteNoizeCollectionView.register(SoundCollectionViewCell.self)
        whiteNoizeCollectionView.backgroundColor = .clear

        musicLabel.text = "Music stream"
        musicLabel.font = .systemFont(ofSize: 25, weight: .semibold)

        musicCollectionView.collectionViewLayout = flowLayout
        musicCollectionView.delegate = self
        musicCollectionView.dataSource = self
        musicCollectionView.register(SoundCollectionViewCell.self)
        musicCollectionView.backgroundColor = .clear
    }
}

extension MusicView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == whiteNoizeCollectionView {
            viewModel?.whiteNoizeSelected(at: indexPath.row)
        } else if collectionView == musicCollectionView {
            viewModel?.musicSelected(at: indexPath.row)
        }
    }
}

extension MusicView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        if collectionView == whiteNoizeCollectionView {
            count = viewModel?.whiteNoize.count
        } else if collectionView == musicCollectionView {
            count = viewModel?.music.count
        }

        return count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }

        var sound = Sound.empty
        if collectionView == whiteNoizeCollectionView {
            sound = viewModel.whiteNoize[indexPath.row]
        } else if collectionView == musicCollectionView {
            sound = viewModel.music[indexPath.row]
        }

        let cell: SoundCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(title: sound.title, image: sound.image)
        return cell
    }
}

extension MusicView: MusicViewModelDelegate {
    func musicReceived() {
        musicCollectionView.reloadData()
        whiteNoizeCollectionView.reloadData()
    }
}
