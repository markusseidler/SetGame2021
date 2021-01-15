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
    // all cards
    var setOfCards = [SetCard]()
    // only cards on the screen (dealt)
    var isDealtCards: [SetCard] { setOfCards.filter { $0.isDealt } }
    // only cards which are currently matched (and on the screen) or already matched (and removed from the screen)
    var isMatchedCards: [SetCard] { setOfCards.filter { $0.isMatched } }
    // only cards which are already removed from the screen
    var wasUsedCards: [SetCard] { setOfCards.filter { $0.wasUsed } }
    // only cards which are currently on the screen and are selected by the user
    var isSelectedCards: [SetCard] { setOfCards.filter { $0.isSelected } }
    
    
    // MARK: - Public API Methods
    init() {
        resetGame()
        print(setOfCards)
//        selectCard(at: 0)
//        selectCard(at: 48)
//        selectCard(at: 80)
//        print(isSelectedCards)
//        checkSelectedCardsIfMatchAndChange()
//        print(isMatchedCards)
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
//            let realIndex = setOfCards.firstIndex { $0.id == tempCard.id }
            let realIndex = setOfCards.getMatchedIndexByID(of: tempCard)
            if let realIndexUnwrapped = realIndex {
                setOfCards[realIndexUnwrapped].isDealt = true
            }
        }

    }
    
    // changes cards to isMatched = true when check is successful. 
    mutating func checkSelectedCardsIfMatchAndChange() {
        guard (isSelectedCards.count == 3) else { fatalError("Failed matching. \(isSelectedCards.count) are selected. It needs three cards to start matching process.") }
        
        if checkMatch() {
            for selectedCard in isSelectedCards {
                if let matchingIndex = setOfCards.getMatchedIndexByID(of: selectedCard) {
                    setOfCards[matchingIndex].isMatched = true
                }
            }
        }
    }
    
    
    
    // MARK: - Private API Properties
    
    
    
    // MARK: - Private API Methods
    
    //
    private func checkMatch() -> Bool {
        
        // checking if only 3 cards are selected
        guard (isSelectedCards.count == 3) else { fatalError("Failed matching. \(isSelectedCards.count) are selected. It needs three cards to start matching process.") }
        
        // extracts each feature for each card
        let featureOneSelected = isSelectedCards.map { $0.featureOne }
        let featureTwoSelected = isSelectedCards.map { $0.featureTwo }
        let featureThreeSelected = isSelectedCards.map { $0.featureThree }
        let featureFourSelected = isSelectedCards.map { $0.featureFour }
        
        // checks if all features are either all equal or all different. If yes, returns true
        let featureCheck: Bool = singleFeatureCheck(feature: featureOneSelected) && singleFeatureCheck(feature: featureTwoSelected) && singleFeatureCheck(feature: featureThreeSelected) && singleFeatureCheck(feature: featureFourSelected)
        
        return featureCheck
    }
    
    // runs check on a single feature. Logic is if all elements of one feature are the same or if they are all different then it is a match. Implementation with two Array extensions.
    private func singleFeatureCheck<T> (feature: [T]) -> Bool where T: Equatable {
            return feature.allEqual() || feature.allDifferent()
    }
    
    
    
 
}


