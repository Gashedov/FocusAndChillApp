//
//  UICollectionView+Generics.swift
//  FocOn
//
//  Created by Artem Gorshkov on 15.09.21.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReuseIdentifiable {
        register(T.self, forCellWithReuseIdentifier: T.reuseId)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseId) at indexPath: \(indexPath)")
        }
        return cell
    }

    func registerHeaderView<T: UICollectionReusableView>(_: T.Type) where T: ReuseIdentifiable {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseId
        )
    }

    func dequeueReusableHeaderView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: T.reuseId, for: indexPath
        ) as? T else {
            fatalError("Could not dequeue header with identifier: \(T.reuseId)")
        }
        return cell
    }
}
