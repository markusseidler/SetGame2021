//
//  SetCard.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

struct SetCard: Cardable, SetCardable {
    // Low level data structure. A Set Card that owns behaviour of a Card and the features determined in SetCard protocol
    
    var featureOne: FeatureOne
    var featureTwo: FeatureTwo
    var featureThree: FeatureThree
    var featureFour: FeatureFour
   
    var isDealt: Bool = false
    var isSelected: Bool = false
    var isMatched: Bool = false
    var wasUsed: Bool = false
    var id = UUID()
    
//    var iteratingCount: Int = 1
    
}

////https://www.hackingwithswift.com/example-code/language/how-to-make-a-custom-sequence
//extension SetCard: Sequence, IteratorProtocol {
//
//    mutating func next() -> UUID? {
//        return id
//    }
//}
