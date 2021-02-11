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
    // only cards which are (still) in the card deck. Cards which are not dealt yet or which are not "wasUsed" yet
    var isInDeckCards: [SetCard] { setOfCards.filter { !$0.isDealt || !$0.wasUsed } }
    // only cards which are currently matched (and on the screen) or already matched (and removed from the screen)
    var isMatchedCards: [SetCard] { setOfCards.filter { $0.isMatched } }
    // only cards which are already removed from the screen
    var wasUsedCards: [SetCard] { setOfCards.filter { $0.wasUsed } }
    // only cards which are currently on the screen and are selected by the user
    var isSelectedCards: [SetCard] { setOfCards.filter { $0.isSelected } }
    var isFaceUpCards: [SetCard] { setOfCards.filter { $0.isFaceUp } }
    
    
    // MARK: - Public API Methods
    init() {
        resetGame()
//        print(setOfCards)
    }
    
    // creates a game of new cards with all available features. Tested
    mutating func resetGame() {
        setOfCards = []
        
        for featOne in FeatureOne.allCases {
            for featTwo in FeatureTwo.allCases {
                for featThree in FeatureThree.allCases {
                    for featFour in FeatureFour.allCases {
                        setOfCards.append(SetCard(featureOne: featOne, featureTwo: featTwo, featureThree: featThree, featureFour: featFour))
                    }
                }
            }
        }
        
        setOfCards.shuffle()
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
        
        for number in 0..<numberToChange {
            let cardToChange = notDealtCards[number]
            let indexToChange = setOfCards.getMatchedIndexByID(of: cardToChange)
            if let indexUnwrapped = indexToChange {
                setOfCards[indexUnwrapped].isDealt = true
            }
        }
        
        // putting it into a temporary set to ensure no double counting of random indices.
//        var tempIndexSet = Set<Int>()
//        while tempIndexSet.count < numberToChange {
//            tempIndexSet.insert(Int.random(in: 0..<notDealtCards.count))
//        }
        
        // based on the random indices, get the cards which are not dealt yet
//        var tempCardSetToBeChanged = [SetCard]()
//        for index in tempIndexSet {
//            tempCardSetToBeChanged.append(notDealtCards[index])
//        }
        
        // find those cards in the original setOfCards and set their isDealt to true
//        for tempCard in tempCardSetToBeChanged {
////            let realIndex = setOfCards.firstIndex { $0.id == tempCard.id }
//            let realIndex = setOfCards.getMatchedIndexByID(of: tempCard)
//            if let realIndexUnwrapped = realIndex {
//                setOfCards[realIndexUnwrapped].isDealt = true
//            }
//        }

    }
    
    // changes cards to isMatched = true when check is successful. Tested.
    mutating func checkSelectedCardsIfMatchAndChange() {
        guard (isSelectedCards.count == 3) else { fatalError("Failed matching. \(isSelectedCards.count) are selected. It needs three cards to start matching process.") }
        
        if checkMatch(for: isSelectedCards) {
            for selectedCard in isSelectedCards {
                if let matchingIndex = setOfCards.getMatchedIndexByID(of: selectedCard) {
                    setOfCards[matchingIndex].isMatched = true
                }
            }
        }
    }
    
    // changes cards to wasUsed and deselect while deMatch. Tested.
    mutating func moveToWasUsedCards() {
        for matchedCard in isMatchedCards {
            if let matchingIndex = setOfCards.getMatchedIndexByID(of: matchedCard) {
                setOfCards[matchingIndex].isMatched = false
                setOfCards[matchingIndex].isSelected = false
                setOfCards[matchingIndex].wasUsed = true
             }
        }
    }
    
    mutating func turnAllCardsFaceUp() {
        for dealtCard in isDealtCards {
            if let matchingIndex = setOfCards.getMatchedIndexByID(of: dealtCard) {
                setOfCards[matchingIndex].isFaceUp = true
            }
        }
    }
    
    mutating func turnSingleCardFaceUp(at index: Int) {
        setOfCards[index].isFaceUp = true
    }
    
    mutating func turnAroundCard(at index: Int) {
        setOfCards[index].turnAround = true
    }
    
    func checkWhereAreMatchedSets() -> [[SetCard]]? {
        var matchedSets: [[SetCard]]?
        
        let setsToCheck = getUniqueSetCombinations(in: isDealtCards)
        for set in setsToCheck {
            if checkMatch(for: set) {
                matchedSets?.append(set)
            }
        }
        
        return matchedSets
    }
    
    func getUniqueSetCombinations(in cardArray: [SetCard]) -> [[SetCard]] {
        var resultSet = Set<Set<SetCard>>()
        var resultArray = [[SetCard]]()
        
        for cardOne in cardArray {
            for cardTwo in cardArray {
                for cardThree in cardArray {
                    let tempSet = Set(arrayLiteral: cardOne, cardTwo, cardThree)
                    if tempSet.count == 3 {
                        
                        resultSet.insert(tempSet)
                    }
                }
            }
        }
        
        // convert from Set to Array for easier processing in subsequent methods
        for set in resultSet {
            resultArray.append(Array(set))
        }
        
        return resultArray
    }

    
    
    
    // MARK: - Private API Properties
    
    
    
    // MARK: - Private API Methods
    
    //
    private func checkMatch(for cardArray: [SetCard]) -> Bool {
        
        // checking if only 3 cards are selected
        guard (cardArray.count == 3) else { fatalError("Failed matching. \(cardArray.count) are selected. It needs three cards to start matching process.") }
        
        // extracts each feature for each card
        let featureOneSelected = cardArray.map { $0.featureOne }
        let featureTwoSelected = cardArray.map { $0.featureTwo }
        let featureThreeSelected = cardArray.map { $0.featureThree }
        let featureFourSelected = cardArray.map { $0.featureFour }
        
        // checks if all features are either all equal or all different. If yes, returns true
        let featureCheck: Bool = singleFeatureCheck(feature: featureOneSelected) && singleFeatureCheck(feature: featureTwoSelected) && singleFeatureCheck(feature: featureThreeSelected) && singleFeatureCheck(feature: featureFourSelected)
        
        return featureCheck
    }
    
    // runs check on a single feature. Logic is if all elements of one feature are the same or if they are all different then it is a match. Implementation with two Array extensions.
    private func singleFeatureCheck<T> (feature: [T]) -> Bool where T: Hashable {
            return feature.allEqual() || feature.allDifferent()
    }
    
}


