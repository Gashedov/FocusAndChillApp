//
//  MusicContract.swift
//  FocOn
//
//  Created by Artem Gorshkov on 22.09.21.
//

import UIKit

protocol MusicBuilder {
    func build() -> UIViewController
}

protocol MusicViewModel {
    var music: [Sound] { get }
    var whiteNoize: [Sound] { get }
    var delegate: MusicViewModelDelegate? { get set }
    
    func musicSelected(at: Int)
    func whiteNoizeSelected(at: Int)
    func fetchMusic()
}

protocol MusicViewModelDelegate {
    func musicReceived() 
}

protocol MusicRouter {
}
