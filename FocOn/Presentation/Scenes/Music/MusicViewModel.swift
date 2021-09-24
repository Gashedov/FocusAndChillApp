//
//  MusicViewModel.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

class MusicViewModelImpl: MusicViewModel {
    private let router: MusicRouter
    var music: [Sound] = []
    var whiteNoize: [Sound] = []

    var delegate: MusicViewModelDelegate?

    init(router: MusicRouter) {
        self.router = router
    }
    
    func musicSelected(at: Int) {
    }

    func whiteNoizeSelected(at: Int) {
    }

    func fetchMusic() {
    }
}
