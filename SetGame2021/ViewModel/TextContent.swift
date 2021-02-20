//
//  TextContent.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import Foundation

struct TextContent {
    static let totalScore = "Total: "
    static let bonusScore = "Bonus: "
    static let newGame = "New Game"
    static let matched = "Matched!"
    static let matchedSets = "Matched Sets"
    static let deal = "Deal"
    static let cheat = "Cheat"
    
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
