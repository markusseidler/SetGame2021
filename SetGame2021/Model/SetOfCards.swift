//
//  SetOfCards.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

struct SetOfCards: CardGameable {
    typealias Content = SetCard
    
    // MARK: - Public API Properties
    var setOfCards = [SetCard]()
    
    // MARK: - Public API Methods
    init() {
        resetGame()
        print(setOfCards)
    }
    
    mutating func resetGame() {
        for featOne in FeatureOne.allCases {
            for featTwo in FeatureTwo.allCases {
                for featThree in FeatureThree.allCases {
                    for featFour in FeatureFour.allCases {
                        setOfCards.append(SetCard(featureOne: featOne, featureTwo: featTwo, featureThree: featThree, featureFour: featFour))
                    }
                }
            }
        }
    }
    
    mutating func selectCard(at cardIndex: Int) {
        setOfCards[cardIndex].isSelected = true
    }
    
    mutating func deSelectCard(at cardIndex: Int) {
        setOfCards[cardIndex].isSelected = false
    }
    
    // MARK: - Private API Properties
    
    
    
 
}


