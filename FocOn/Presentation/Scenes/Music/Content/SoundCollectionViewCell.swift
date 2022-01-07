//
//  SoundCollectionViewCell.swift
//  FocOn
//
//  Created by Artem Gorshkov on 23.09.21.
//

import UIKit

class SoundCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    private let coloredView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    private var primaryColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white

        contentView.insertSubview(coloredView, belowSubview: imageView)
        coloredView.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }

        coloredView.layer.cornerRadius = 25

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(5)
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
                titleLabel.textColor = primaryColor
                coloredView.backgroundColor = primaryColor
            } else {
                titleLabel.textColor = primaryColor?.withAlphaComponent(0.5)
                coloredView.backgroundColor = primaryColor?.withAlphaComponent(0.5)
            }
        }
    }

    func setup(
        title: String,
        image: UIImage?,
        primaryColor: UIColor?,
        selected: Bool
    ) {
        titleLabel.text = title
        imageView.image = image?.withAlignmentRectInsets(UIEdgeInsets(top: -8, left: -8, bottom: -8, right: -8))

        titleLabel.textColor = selected ? primaryColor : primaryColor?.withAlphaComponent(0.5)
        coloredView.backgroundColor = selected ? primaryColor : primaryColor?.withAlphaComponent(0.5)

        self.primaryColor = primaryColor
    }

//    func drawPDFfromURL(url: URL?) -> UIImage? {
//        guard let url = url else { return nil }
//        guard let document = CGPDFDocument(url as CFURL) else { return nil }
//        guard let page = document.page(at: 1) else { return nil }
//
//        let pageRect =  page.getBoxRect(.artBox)
//        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
//        let image = renderer.image { context in
//            UIColor.clear.set()
//            context.fill(pageRect)
//
//            context.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
//            context.cgContext.scaleBy(x: 1.0, y: -1.0)
//
//            context.cgContext.drawPDFPage(page)
//        }
//
//        return image
//    }
}

