//
//  SettingsTableViewCell.swift
//  FocOn
//
//  Created by Artem Gorshkov on 15.09.21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, ReuseIdentifiable {
    //MARK: - Properties
    private let titleLabel = UILabel()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textAlignment = .left

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods
    func setup(title: String) {
        titleLabel.text = title
    }
}
