//
//  SoundCollectionViewCell.swift
//  FocOn
//
//  Created by Artem Gorshkov on 23.09.21.
//

import UIKit

class SoundCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(imageView.snp.width)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }

        backgroundColor = .clear

        imageView.clipsToBounds = true

        titleLabel.font = .systemFont(ofSize: 12, weight: .light)
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.7
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .green
                backgroundColor = .lightGray
            } else {
                titleLabel.textColor = .black
                backgroundColor = .clear
            }
        }
    }

    func setup(title: String, image: String) {
        titleLabel.text = title
        imageView.image = UIImage()
    }
}
