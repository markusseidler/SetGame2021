//
//  CardGameable.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

protocol CardGameable {
    // basic functions of a card game
    
    associatedtype Content where Content: Cardable
    var setOfCards: [Content] { get }
    
    mutating func resetGame()
    mutating func selectCard(at cardIndex: Int)
    mutating func deSelectCard(at cardIndex: Int)
    mutating func dealCards(numberOfCards: Int)
    
}
