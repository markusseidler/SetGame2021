//
//  SetGame.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/1/21.
//

import SwiftUI

class SetGame: ObservableObject {
    
    // MARK: - Public API Properties
    
    // card features enum
    enum CardShapes { case oval, diamond, squiggle }
    enum CardShading { case none, striped, solid }
    
    struct ViewCard: ViewCardable, Cardable {

        var color: Color
        var quantity: Int
        var cardShape: SetGame.CardShapes
        var cardShading: SetGame.CardShading
        
        var isDealt: Bool
        var isFaceUp: Bool
        var turnAround: Bool
        var isSelected: Bool
        var isMatched: Bool
        var isCheated: Bool = false
        var wasUsed: Bool
        var id: UUID
        
        static var exampleSquiggleOne = ViewCard(color: .red, quantity: 1, cardShape: .squiggle, cardShading: .none, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleSquiggleTwo = ViewCard(color: .red, quantity: 2, cardShape: .squiggle, cardShading: .solid, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleSquiggleThree = ViewCard(color: .red, quantity: 3, cardShape: .squiggle, cardShading: .striped, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleDiamondOne = ViewCard(color: .red, quantity: 1, cardShape: .diamond, cardShading: .none, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleDiamondTwo = ViewCard(color: .red, quantity: 2, cardShape: .diamond, cardShading: .solid, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleDiamondThree = ViewCard(color: .red, quantity: 3, cardShape: .diamond, cardShading: .striped, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleOvalOne = ViewCard(color: .red, quantity: 1, cardShape: .oval, cardShading: .none, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleOvalTwo = ViewCard(color: .red, quantity: 2, cardShape: .oval, cardShading: .solid, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        static var exampleOvalThree = ViewCard(color: .red, quantity: 3, cardShape: .oval, cardShading: .striped, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
    }
    
    var allViewCards: [ViewCard] { game.setOfCards.map { createViewCard(with: $0) } }
    var isDealtViewCards: [ViewCard] { game.isDealtCards.map { createViewCard(with: $0) } }
    var isInDeckViewCards: [ViewCard] { game.isInDeckCards.map { createViewCard(with: $0)} }
    var isMatchedViewCards: [ViewCard] { game.isMatchedCards.map { createViewCard(with: $0) } }
    var wasUsedViewCards: [ViewCard] { game.wasUsedCards.map { createViewCard(with: $0) } }
    var isSelectedViewCards: [ViewCard] { game.isSelectedCards.map { createViewCard(with: $0) }}
    var isFaceUpViewCards: [ViewCard] { game.isFaceUpCards.map { createViewCard(with: $0) }}
    var isFaceUpSetCards: [SetCard] { game.isFaceUpCards }
    var countOfAvailableSetsDisplayed: Int { game.countOfAvailableSetsDisplayed }
    
    var score: Int = 0
    let cheatingCost: Int = 5
    let maxMatchingBenefits: Int = 10
    let dealingCost: Int = 5
    
    private var threeSetCardsSelected: [SetCard] { game.isSelectedCards.filter { $0.isSelected }}
    private var threeSetCardsMatched: [SetCard] { game.isMatchedCards.filter { $0.isMatched }}
    private var areThreeCardsSelected: Bool { game.isSelectedCards.count == 3 }
    private var areThreeCardsAreMatched: Bool { game.isMatchedCards.count == 3}
  

    
    init() { self.game = SetOfCards() }
    
    // MARK: - Public API Methods
    
    func newGame() {
        game.resetGame()
        score = 0
        dealFirstTwelveCards()
    }
    
    func dealCards() {
        if isDealtViewCards.count == 0 {
            dealFirstTwelveCards()
        } else {
            dealThreeMoreCards()
        }
    }
    
    func dealAndDisplayCards() {
        if isFaceUpViewCards.count == 0 {
            turningCardsWithAnimation()
        } else {
            let displayedCards = isFaceUpViewCards.count
            Animations.standard {
                self.dealCards()
            }
         
            turningCardsWithAnimation(previouslyDisplayedCards: displayedCards)
        }
    }
    
    func chooseCard(_ viewCard: SetGame.ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        
        if let indexUnwrapped = index {
            if !viewCard.isSelected {
                game.selectCard(at: indexUnwrapped)
            } else {
                game.deSelectCard(at: indexUnwrapped)
            }
        }
    }
    
    func cheatOn() { game.cheatMatchingCardsChangedToIsCheatedTrue() }
    
    func cheatOff() { game.changeAllCardsToIsCheatedFalse() }

    func checkIfMatch(positiveActionOne: @escaping () -> Void, positiveActionTwo: @escaping () -> Void, positiveActionThree: @escaping () -> Void, negativeAction: @escaping () -> Void ) {
        checkAndMatchOrNot(
            positiveAction: {
                Animations.fastStaggered(
                    actionOne: { positiveActionOne() },
                    actionTwo: { positiveActionTwo() },
                    actionThree: { positiveActionThree() })
            },
            negativeAction: { negativeAction() })
    }
    
    func addToScore(_ points: Int) {
        score += points
    }
    
    func deductFromScore(_ points: Int) {
        score -= points
        
        // score is on purpose capped at minimum 0
        if score < 0 {
            score = 0
        }
    }
    
    func checkHowManyMatchingSetsAreAvailable() {
        game.checkHowManyMatchedSetsAreDisplayed()
    }
    
    // MARK: - Private API Properties
    
    @Published private var game: SetOfCards
    
    // Colors
    private let colorOne: Color = Color.rainbowBlue
    private let colorTwo: Color = Color.rainbowRed
    private let colorThree: Color = Color.rainbowGreen
    
    // MARK: - Private API Methods
    
    private func createViewCard(with setCard: SetCard) -> ViewCard {
        ViewCard(color: convertToColor(with: setCard.featureOne), quantity: convertToQuantity(with: setCard.featureTwo), cardShape: convertToShape(with: setCard.featureThree), cardShading: convertToShading(with: setCard.featureFour), isDealt: setCard.isDealt, isFaceUp: setCard.isFaceUp, turnAround: setCard.turnAround, isSelected: setCard.isSelected, isMatched: setCard.isMatched, isCheated: setCard.isCheated, wasUsed: setCard.wasUsed, id: setCard.id)
    }
    
    // Color conversion
    private func convertToColor(with featureOne: FeatureOne) -> Color {
        switch featureOne {
        case .one:
            return colorOne
        case .two:
            return colorTwo
        case .three:
            return colorThree
        }
    }
    
    // Quantity conversion
    private func convertToQuantity(with featureTwo: FeatureTwo) -> Int {
        switch featureTwo {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
    }
    
    // Shape conversion
    private func convertToShape(with featureThree: FeatureThree) -> CardShapes {
        switch featureThree {
        case .one:
            return CardShapes.diamond
        case .two:
            return CardShapes.oval
        case .three:
            return CardShapes.squiggle
        }
    }
    
    // Shading conversion
    private func convertToShading(with featureFour: FeatureFour) -> CardShading {
        switch featureFour {
        case .one:
            return CardShading.none
        case .two:
            return CardShading.solid
        case.three:
            return CardShading.striped

        }
    }
    
    private func selectCard(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        
        if let indexUnwrapped = index {
            game.selectCard(at: indexUnwrapped)
        }
    }
    
    private func deSelectCard(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        
        if let indexUnwrapped = index {
            game.deSelectCard(at: indexUnwrapped)
        }
    }
    
    private func dealFirstTwelveCards() { game.dealCards(numberOfCards: 12) }
    
    private func dealThreeMoreCards() { game.dealCards(numberOfCards: 3) }
    
    private func checkCardsAreASet() { game.checkSelectedCardsIfMatchAndChange() }
    
    private func turnAllCardsFaceUp() { game.turnAllCardsFaceUp() }
    
    private func changeViewCardToFaceUpTrue(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        if let indexUnwrapped = index {
            game.changeSetCardToFaceUpTrue(at: indexUnwrapped)
        }
    }
    
    private func changeViewCardToTurnAroundTrue(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        if let indexUnwrapped = index {
            game.changeSetCardToTurnAroundCardTrue(at: indexUnwrapped)
        }
    }
    
    private func turningCardsWithAnimation(previouslyDisplayedCards: Int = 0) {
        let delayFactor: Double = 0.3
        let animationDuration: Double = 1.0
        let startOfTurnAround: Double = 0.3
        
        let cardCount: Int = isDealtViewCards.count - previouslyDisplayedCards
        
        for cardNumber in 0..<cardCount {
            let delayTime = delayFactor * Double(cardNumber)
            let cardIndex = cardNumber + previouslyDisplayedCards
            withAnimation(Animation.easeInOut(duration: animationDuration).delay(delayTime)) {
                changeViewCardToFaceUpTrue(isDealtViewCards[cardIndex])
            }
            withAnimation(Animation.easeInOut(duration: animationDuration / 2).delay(delayTime + startOfTurnAround)) {
                changeViewCardToTurnAroundTrue(isDealtViewCards[cardIndex])
            }
        }
    }
    
    private func checkAndMatchOrNot(positiveAction: () -> Void, negativeAction: (() -> Void)?) {
        if areThreeCardsSelected {
            checkCardsAreASet()
            if areThreeCardsAreMatched {
                positiveAction()
            } else {
                if let hapticActionUnwrapped = negativeAction {
                    hapticActionUnwrapped()
                }
            }
            
            for selectedCard in threeSetCardsSelected {
                if let selectedIndex = game.setOfCards.getMatchedIndexBySetCardFeatures(of: selectedCard) {
                    game.setOfCards[selectedIndex].isSelected = false
                    if areThreeCardsAreMatched {
                        
                        // Need to split it into two parts, otherwise animations are overlapping and transitions do not work.isDealt change has to happen in second parts, otherwise in conflict with cards flying away.
                        
                        Animations.standard {
                            self.game.moveToWasUsedCardsPartA()
                        }
                        
                        Animations.standardDelayed {
                            self.game.moveToWasUsedCardsPartB()
                        }

                    }
                }
            }
            
        }
    }
}
