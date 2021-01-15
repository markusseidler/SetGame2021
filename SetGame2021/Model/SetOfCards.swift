//
//  SetOfCards.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

struct SetOfCards: CardGameable {
    
    // Model for Set Game

    typealias Content = SetCard
    
    // MARK: - Public API Properties
    var setOfCards = [SetCard]()
    
    // MARK: - Public API Methods
    init() {
        resetGame()
    }
    
    // creates a game of new cards with all available features. Tested
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
    
    // function to select Card which will be visually shown in the View. Tested.
    mutating func selectCard(at cardIndex: Int) {
        setOfCards[cardIndex].isSelected = true
    }
    
    // function to de-select Card which will be visually shown in the View. Tested.
    mutating func deSelectCard(at cardIndex: Int) {
        setOfCards[cardIndex].isSelected = false
    }
    
    // changes randomly cards from isDealt false to true. NumberOfCards controls how many cards should be changed. Tested. 
    mutating func dealCards(numberOfCards: Int) {
        
        // how many cards are with isDealt false in the total set?
        let notDealtCards = setOfCards.filter { $0.isDealt == false}
        
        // making sure that numberOfCards looking to be dealt does not exceed total count of available not-yet-dealt cards in the set
        let numberToChange = min(numberOfCards, notDealtCards.count)
        
        // putting it into a temporary set to ensure no double counting of random indices.
        var tempIndexSet = Set<Int>()
        while tempIndexSet.count < numberToChange {
            tempIndexSet.insert(Int.random(in: 0..<notDealtCards.count))
        }
        
        // based on the random indices, get the cards which are not dealt yet
        var tempCardSetToBeChanged = [SetCard]()
        for index in tempIndexSet {
            tempCardSetToBeChanged.append(notDealtCards[index])
        }
        
        // find those cards in the original setOfCards and set their isDealt to true
        for tempCard in tempCardSetToBeChanged {
            let realIndex = setOfCards.firstIndex { $0.id == tempCard.id }
            if let realIndexUnwrapped = realIndex {
                setOfCards[realIndexUnwrapped].isDealt = true
            }
        }

    }
    
    // MARK: - Private API Properties
    
    
    
 
}


