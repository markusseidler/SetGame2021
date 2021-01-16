//
//  Devices.swift
//  SetGame2021
//
//  Created by Markus Seidler on 16/1/21.
//

import SwiftUI

enum Devices: String {
    case twelveProMax = "iPhone 12 Pro Max"
    case twelvePro = "iPhone 12 Pro"
    case eight = "iPhone 8"
    case se = "iPhone SE (2nd generation)"
    case iPadProTwelveNine = "iPad Pro (12.9-inch) (4th generation)"
    
    func getLandScapeDimension() -> (width: CGFloat, height: CGFloat){
        switch self {
        case .twelveProMax, .twelvePro:
            return (896, 414)
        case .eight:
            return (736, 414)
        case .se:
            return (568, 320)
        case .iPadProTwelveNine:
            return (1366, 1024)
        }
    }
}
