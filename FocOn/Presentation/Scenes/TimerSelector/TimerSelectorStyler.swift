//
//  TimerSelectorStyler.swift
//  FocOn
//
//  Created by Nikita Zhukov on 15.01.2022.
//

import UIKit

class TimerSelectorStyler: Styler, TimerSelectorViewStyler {
    
    func background(view: UIView) {
        view.backgroundColor = R.color.dimBackgroundColor()?.withAlphaComponent(0.5)
    }
    
    func content(view: UIView) {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
    
    func ringPlaceholder(view: UIView) {
        view.backgroundColor = .clear
    }
    
    func start(button: UIButton) {
        switch theme {
        case .fire:
            button.backgroundColor = R.color.buttonActionBackgroundFire()
        case .forest:
            button.backgroundColor = R.color.buttonActionBackgroundForest()
        case .rain:
            button.backgroundColor = R.color.buttonActionBackgroundRain()
        case .sea:
            button.backgroundColor = R.color.buttonActionBackgroundSea()
        case .none:
            button.backgroundColor = R.color.buttonActionBackgroundDefault()
        }
        button.titleLabel?.font = fonts.titleActionButton
        button.tintColor = .white
        button.setTitle(R.string.localizable.popupTimerStart(), for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        if #available(iOS 15.0, *) {
            button.configuration = .plain()
        }
    }
    
    func close(button: UIButton) {
        button.setTitle("", for: .normal)
        button.tintColor = .white
        button.setImage(R.image.cross(), for: .normal)
        if #available(iOS 15.0, *) {
            button.configuration = .plain()
        }
    }
    
    func restTimeUp(button: UIButton) {
        button.setTitle("", for: .normal)
        button.setImage(R.image.arrowUp(), for: .normal)
        button.tintColor = .black
        if #available(iOS 15.0, *) {
            button.configuration = .plain()
        }
    }
    
    func restTimeDown(button: UIButton) {
        button.setTitle("", for: .normal)
        button.setImage(R.image.arrowDown(), for: .normal)
        button.tintColor = .black
        if #available(iOS 15.0, *) {
            button.configuration = .plain()
        }
    }
    
    func title(label: UILabel) {
        label.text = R.string.localizable.popupTimerTitle()
        label.font = Styler().fonts.titlePopup
    }
    
    func restTimeTitle(label: UILabel) {
        label.text = R.string.localizable.popupTimerRestTimeTitle()
        label.font = Styler().fonts.textPopup
    }
    
    func restTimeValue(label: UILabel, value: String) {
        label.text = R.string.localizable.popupTimerRestTimeValue(value)
        label.font = Styler().fonts.textPopup
    }
}
