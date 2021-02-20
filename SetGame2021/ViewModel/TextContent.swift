//
//  TextContent.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import Foundation

struct TextContent {
    static let totalScore = "Total: "
    static let bonusScore = "Now: "
    static let newGame = "New Game"
    static let matched = "Matched!"
    static let matchedSets = "Matched Sets"
    static let deal = "Deal"
    static let cheat = "Cheat"
    static let defaultText = "Ok"
    
    static func getFirstAvailableSetMessage(count: Int) -> String {
        let firstTime = "This is your first time cheating. This time it is for free. Next time it cost you 5 points.\n"
        
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
}
