//
//  SetCardable.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

protocol SetCardable {
    // Specific to Set Card. Four features per card.
    
    var featureOne: FeatureOne { get }
    var featureTwo: FeatureTwo { get }
    var featureThree: FeatureThree { get }
    var featureFour: FeatureFour { get }
}
