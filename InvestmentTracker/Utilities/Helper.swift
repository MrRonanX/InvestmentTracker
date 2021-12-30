//
//  Helper.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/31/21.
//

import SwiftUI

enum DeviceTypes {
    enum ScreenSize {
        static let width         = UIScreen.main.bounds.size.width
        static let height        = UIScreen.main.bounds.size.height
        static let maxLength     = max(ScreenSize.width, ScreenSize.height)
    }
    
    static let idiom             = UIDevice.current.userInterfaceIdiom
    static let nativeScale       = UIScreen.main.nativeScale
    static let scale             = UIScreen.main.scale

    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
}
