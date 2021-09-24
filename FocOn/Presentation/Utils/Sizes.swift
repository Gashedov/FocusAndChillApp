//
//  Sizes.swift
//  FocOn
//
//  Created by Artem Gorshkov on 15.09.21.
//

import UIKit

enum DeviceType {
    case iphoneProMax // 11ProMax, XS MAX, 12 PRO MAX
    case iPhone12Mini // iPhone8 Plus
    case iPhonePro // iPhone12 PRO, iPhone11 PRO, iPhoneX, iPhoneXS
    case iPhone11 // XR
    case iPhone8 // iPhoneSE (2rd gen)
    case iPad
}

enum Sizes {
    static func getCurrentDeviceType() -> DeviceType {
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1334:
                return .iPhone8
            case 1792:
                return .iPhone11
            case 2340, 2208:
                return .iPhone12Mini
            case 2532, 2436:
                return .iPhonePro
            case 2688, 2778:
                return .iphoneProMax
            default:
                return .iPhone8
            }
        } else {
            return .iPad
        }
    }

    static func value<T>(from values: [DeviceType: T], defaultValue: T? = nil) -> T {
        let currentDeviceType = Sizes.getCurrentDeviceType()
        return values[currentDeviceType] ?? defaultValue ?? values[.iPhone8]!
    }
}

