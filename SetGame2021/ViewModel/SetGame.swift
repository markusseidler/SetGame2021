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
    var isFaceUpCards: [ViewCard] { game.isFaceUpCards.map { createViewCard(with: $0) }}
    var threeCardsSelected: Bool { game.isSelectedCards.count == 3 }
    

    init() { self.game = SetOfCards() }
    
    // MARK: - Public API Methods
    
    func newGame() {
        game.resetGame()
        dealFirstTwelveCards()
    }
    
    func dealFirstTwelveCards() {
        game.dealCards(numberOfCards: 12)
    }
    
    func dealThreeMoreCards() {
        game.dealCards(numberOfCards: 3)
    }
    
    func turnAllCardsFaceUp() {
        game.turnAllCardsFaceUp()
    }
    
    func turnSingleCardFaceUp(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        if let indexUnwrapped = index {
            game.turnSingleCardFaceUp(at: indexUnwrapped)
        }
    }
    
    func turnAroundCard(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        if let indexUnwrapped = index {
            game.turnAroundCard(at: indexUnwrapped)
        }
    }
    
    func chooseCard(_ viewCard: ViewCard) {
        let index = allViewCards.getMatchedIndexByID(of: viewCard)
        
        if let indexUnwrapped = index {
            if !viewCard.isSelected {
                game.selectCard(at: indexUnwrapped)
            } else {
                game.deSelectCard(at: indexUnwrapped)
            }
        }
    }
    
    func checkCardsAreASet() {
        game.checkSelectedCardsIfMatchAndChange()
    }
    
    // MARK: - Private API Properties
    
    @Published private var game: SetOfCards
    
    // Colors
    private let colorOne: Color = Color.trendyGreen
    private let colorTwo: Color = Color.trendyBlue
    private let colorThree: Color = Color.trendyPink
    
    // MARK: - Private API Methods
    
    private func createViewCard(with setCard: SetCard) -> ViewCard {
        ViewCard(color: convertToColor(with: setCard.featureOne), quantity: convertToQuantity(with: setCard.featureTwo), cardShape: convertToShape(with: setCard.featureThree), cardShading: convertToShading(with: setCard.featureFour), isDealt: setCard.isDealt, isFaceUp: setCard.isFaceUp, turnAround: setCard.turnAround, isSelected: setCard.isSelected, isMatched: setCard.isMatched, wasUsed: setCard.wasUsed, id: setCard.id)
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
    
}
