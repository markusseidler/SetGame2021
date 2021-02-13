//
//  Card.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

// Protocol with standard feature ofa Card
protocol Cardable: Identifiable {
    // Basic metrics of each card
    
    var isDealt: Bool { get }
    var isFaceUp: Bool { get }
    var turnAround: Bool { get }
    var isSelected: Bool { get }
    var isMatched: Bool { get }
    var isCheated: Bool { get }
    var wasUsed: Bool { get }
    var id: UUID { get }
    
    
}

//extension Cardable {
//    var id: UUID {
//        UUID()
//    }
//}
//

