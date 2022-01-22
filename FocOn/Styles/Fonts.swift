//
//  Fonts.swift
//  FocOn
//
//  Created by Nikita Zhukov on 15.01.2022.
//

import UIKit

class Styler {
    let fonts = Fonts()
    var theme: Theme?
}

struct Fonts {
    let titlePopup = UIFont.preferredFont(forTextStyle: .title1)
    let titleActionButton = UIFont.preferredFont(forTextStyle: .body)
    let textPopup = UIFont.preferredFont(forTextStyle: .body)
}
