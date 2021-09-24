//
//  ReuseIdentifiable.swift
//  FocOn
//
//  Created by Artem Gorshkov on 15.09.21.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable where Self: UIView {
    static var reuseId: String {
        return String(describing: self)
    }
}

