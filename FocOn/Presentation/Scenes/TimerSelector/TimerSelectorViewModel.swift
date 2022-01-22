//
//  TimerSelectorViewModel.swift
//  FocOn
//
//  Created by Nikita Zhukov on 17.01.2022.
//

import Foundation
import Combine

class TimerSelectorViewModel {
    // MARK: - Properties

    private var can: AnyCancellable?
    private let themeRepository: ThemeRepository
    
    var themePublisher: AnyPublisher<Theme, Never>? {
        themeRepository.themePublisher.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(themeRepository: ThemeRepository) {
        self.themeRepository = themeRepository
    }
    
    // MARK: - Lifecycle

    // MARK: - Methods
    // MARK: Private methods
    
}
