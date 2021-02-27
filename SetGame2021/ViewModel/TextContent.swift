//
//  TextContent.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

struct TextContent {
    static let newGame = LocalizedStringKey("newGame")
    static let noPoints = LocalizedStringKey("noPoints")
    static let matchedSets = LocalizedStringKey("matchedSets")
    static let dealButtonPressed = LocalizedStringKey("areYouSure")
    static let deal = LocalizedStringKey("deal")
    static let cheat = LocalizedStringKey("cheat")
    static let defaultText = LocalizedStringKey("ok")
    
    static func getTotalScore(_ score: Int) -> LocalizedStringKey {
        return LocalizedStringKey("total \(score)")
    }
    
    static func getFirstAvailableSetMessage(count: Int, cost: Int) -> LocalizedStringKey {
        if count == 0 {
            return LocalizedStringKey("cheatingNoSetsDisplayed \(cost)")
        } else if count == 1 {
            return LocalizedStringKey("cheatingOneSetsDisplayed \(cost)")
        } else {
            return LocalizedStringKey("cheatingMultipleSetsDisplayed \(cost) \(count)")
        }
    }
    
    static func getAvailableSetMessage(count: Int, cost: Int) -> LocalizedStringKey {
        if count == 0 {
            return LocalizedStringKey("noSetsDisplayed \(cost)")
        } else if count == 1 {
            return LocalizedStringKey("oneSetDisplayed \(cost)")
        } else {
            return LocalizedStringKey("multipleSetsDisplayed \(count) \(cost)")
        }
    }
    
    static func getDealCostPointsMessage(cost: Int) -> LocalizedStringKey {
        return LocalizedStringKey("dealCostMessage \(cost)")
    }
    
    
}
