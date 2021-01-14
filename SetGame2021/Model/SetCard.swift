//
//  SetCard.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

struct SetCard: Cardable, SetCardable {
    var featureOne: FeatureOne
    var featureTwo: FeatureTwo
    var featureThree: FeatureThree
    var featureFour: FeatureFour
   
    var isDealt: Bool = false
    var isSelected: Bool = false
    var isMatched: Bool = false
    
    
}
