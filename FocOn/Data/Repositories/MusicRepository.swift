//
//  MusicRepository.swift
//  FocOn
//
//  Created by Nikita Zhukov on 17.01.2022.
//

import Foundation
import Combine

class MusicRepository {
    
    // data source here:
    private let music: [SoundModel] = MusicItem.allCases
    private let whiteNoizes: [SoundModel] = WhiteNoizeItem.allCases
    
    var musicPublisher: CurrentValueSubject<[SoundModel], Never>
    var whiteNoizesPublisher: CurrentValueSubject<[SoundModel], Never>
    
    init() {
        musicPublisher = CurrentValueSubject<[SoundModel], Never>(music)
        whiteNoizesPublisher = CurrentValueSubject<[SoundModel], Never>(whiteNoizes)
    }
    
    func urlForMusic(by index: Int) -> URL {
        guard let boundleUrl = Bundle.main.resourceURL else { fatalError() }
        
        return boundleUrl.appendingPathComponent(music[index].soundUrlString)
    }
    
    func urlForNoize(by index: Int) -> URL {
        guard let boundleUrl = Bundle.main.resourceURL else { fatalError() }
        
        return boundleUrl.appendingPathComponent(whiteNoizes[index].soundUrlString)
    }
    
    func themeForNoize(by index: Int) -> Theme? {
        let item = whiteNoizes[index] as? WhiteNoizeItem
        switch item {
        case .rain:
            return .rain
        case .forest:
            return .forest
        case .sea:
            return .sea
        case .fire:
            return .fire
        case .none:
            return nil
        }
    }
}
