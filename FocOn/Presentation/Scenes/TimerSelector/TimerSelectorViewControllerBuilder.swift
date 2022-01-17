//
//  TimerSelectorViewControllerBuilder.swift
//  FocOn
//
//  Created by Nikita Zhukov on 15.01.2022.
//

import Foundation

class TimerSelectorViewControllerBuilder {
    
    func build() -> TimerSelectorViewController {
        guard let vc = R.storyboard.timerSelectorViewController().instantiateInitialViewController() as? TimerSelectorViewController else {
            fatalError()
        }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        vc.styler = TimerSelectorStyler()
        vc.appValues = AppValues()
        vc.viewModel = TimerSelectorViewModel(themeRepository: ThemeRepository())
        
        return vc
    }
    
}
