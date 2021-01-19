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
    enum CardShapes {
        case oval, diamond, squiggle
    }
    
    enum CardShading {
        case none, striped, solid
    }
    
    struct ViewCard: ViewCardable, Cardable {

        var color: Color
        var quantity: Int
        var cardShape: SetGame.CardShapes
        var cardShading: SetGame.CardShading
        
        var isDealt: Bool
        var isSelected: Bool
        var isMatched: Bool
        var wasUsed: Bool
        var id: UUID
        
        static var example = ViewCard(color: .red, quantity: 3, cardShape: .oval, cardShading: .striped, isDealt: true, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
    
    }
    // all cards for the view
    var allViewCards: [ViewCard] { game.setOfCards.map { createViewCard(with: $0) } }
    // only cards on the screen (dealt)
    var isDealtViewCards: [ViewCard] { game.isDealtCards.map { createViewCard(with: $0) } }
    // only cards which are (still) in the card deck. Cards which are not dealt yet or which are not "wasUsed" yet
    var isInDeckViewCards: [ViewCard] { game.isInDeckCards.map { createViewCard(with: $0)} }
    // only cards which are currently matched (and on the screen) or already matched (and removed from the screen)
    var isMatchedViewCards: [ViewCard] { game.isMatchedCards.map { createViewCard(with: $0) } }
    // only cards which are already removed from the screen
    var wasUsedViewCards: [ViewCard] { game.wasUsedCards.map { createViewCard(with: $0) } }
    // only cards which are currently on the screen and are selected by the user
    var isSelectedViewCards: [ViewCard] { game.isSelectedCards.map { createViewCard(with: $0) }}

    init() {
        self.game = SetOfCards()
    }
    
    // MARK: - Public API Methods
    
    
    
    // MARK: - Private API Properties
    
    @Published private var game: SetOfCards
    
    // Colors
    private let colorOne: Color = Color.red
    private let colorTwo: Color = Color.blue
    private let colorThree: Color = Color.green
    
    // MARK: - Private API Methods
    
    private func createViewCard(with setCard: SetCard) -> ViewCard {
        ViewCard(color: convertToColor(with: setCard.featureOne), quantity: convertToQuantity(with: setCard.featureTwo), cardShape: convertToShape(with: setCard.featureThree), cardShading: convertToShading(with: setCard.featureFour), isDealt: setCard.isDealt, isSelected: setCard.isSelected, isMatched: setCard.isMatched, wasUsed: setCard.wasUsed, id: setCard.id)
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
    
}
