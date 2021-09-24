//
//  SettingsViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

class SettingsViewModelImpl: SettingsViewModel {
    let options: [SettingsOption] = [
        .changeCharacter,
        .aboutUs,
        .support,
        .faq,
        .terms,
        .rateUs
    ]

    private let router: SettingsRouter

    init(router: SettingsRouter) {
        self.router = router
    }

    func optionSelected(at index: Int) {
        guard let option = SettingsOption(rawValue: index) else { return }
        switch option {
        case .changeCharacter:
            router.openChangeCharacterView()
        case .aboutUs:
            router.openAboutUs()
        case .support, .faq, .terms:
            print("\(option.title) opened")
        case .rateUs:
            router.openRateUs()
        }
    }

}
