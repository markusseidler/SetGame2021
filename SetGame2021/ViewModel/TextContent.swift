//
//  TextContent.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

struct TextContent {
    static let totalScore = "Total: "
//    static let bonusScore = "Now: "
    static let newGame = LocalizedStringKey("newGame")
//    static let matched = "Matched"
    static let noPoints = LocalizedStringKey("noPoints")
    static let matchedSets = "Matched Sets"
    static let dealButtonPressed = LocalizedStringKey("areYouSure")
    static let deal = LocalizedStringKey("deal")
    static let cheat = LocalizedStringKey("cheat")
    static let defaultText = "Ok"
    
    static func getFirstAvailableSetMessage(count: Int, cost: Int) -> String {
        let firstTime = LocalizedStringKey("\(count)")
        
        if count == 0 {
            return "\(firstTime)\nThere are no sets displayed."
        } else if count == 1 {
            return "\(firstTime)\nThere is one set displayed."
        } else {
            return "\(firstTime)\nThere are \(count) sets displayed."
        }
    }
    
    static func getAvailableSetMessage(count: Int) -> String {
        if count == 0 {
            return "There are no sets displayed. \nCheating cost you 5 points."
        } else if count == 1 {
            return "There is one set displayed. \nCheating cost you 5 points."
        } else {
            return "There are \(count) sets displayed. \nCheating cost you 5 points."
        }
    }
    
    static func getDealCostPointsMessage(cost: Int) -> String {
        return "There are more than 3 matching sets on the screen. Dealing three more cards will cost you \(cost) points."
    }
    
    
}
