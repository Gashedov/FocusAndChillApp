//
//  BoardCollectionViewCell.swift
//  FocOn
//
//  Created by Artem Gorshkov on 13.12.21.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    //MARK: - Properties
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()

    override var isSelected: Bool {
            willSet {
                highlight(newValue)
            }
        }

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.backgroundColor = .white.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 20
        containerView.tintColor = .white

        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        imageView.contentMode = .scaleAspectFit

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }

        titleLabel.text = "Text"
        titleLabel.textAlignment = .center
        titleLabel.highlightedTextColor = .black
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Internal methods
    func setup(
        title: String,
        image: UIImage?,
        highlightedImage: UIImage? = nil,
        primaryColor: UIColor? = nil
    ) {
        titleLabel.text = title
        imageView.image = image
        imageView.highlightedImage = highlightedImage
        imageView.tintColor = primaryColor
    }

    //MARK: Private methods
    private func highlight(_ newValue: Bool) {
        containerView.backgroundColor = newValue ? .white : .white.withAlphaComponent(0.5)
    }
}
