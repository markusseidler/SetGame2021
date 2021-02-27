//
//  ScreenBottom.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/2/21.
//

import SwiftUI

struct ScreenBottom: View {
    
    // MARK: - Public View API
    
    @EnvironmentObject var game: SetGame
    
    @Binding var cardDeckPosition: CGRect
    @Binding var cardSize: CGSize
    let size: CGSize
    let dealAction: () -> Void
    let cheatAction: () -> Void
   
    // MARK: - Private View API
    
    var body: some View {
        
        return HStack {

            Spacer()

            ZStack {
                CardDeck(cardDeckPosition: $cardDeckPosition, cardSize: $cardSize, deckColor:  areCardsInDeck ? LinearGradient.active : LinearGradient.passive)
                Text("\(game.countOfInDeckCards)")
                    .font(.headline)
                    .foregroundColor(areCardsInDeck ? Color.appSecondary : Color.clear)
            }

            Spacer()

            VStack {

                Button(action: dealAction) {
                    Text(TextContent.deal)
                }
                .disabled(!areCardsInDeck)
                .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: areCardsInDeck ? opacityEnabled : opacityDisabled, color: dealButtonColor))
                

                Button(action: cheatAction) {
                    Text(TextContent.cheat)
                }
                .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: areCardsFaceUp ? opacityEnabled : opacityDisabled, color: cheatButtonColor))
            }

            Spacer()
        }
    }
    
    // MARK: - Private View Constants and Computed Properties
    
    private var areCardsInDeck: Bool {
        game.isInDeckViewCards.count > 0
    }
    
    private var areCardsFaceUp: Bool {
        game.isFaceUpViewCards.count > 0
    }
    
    private let opacityEnabled: Double = 1.0
    private let opacityDisabled: Double = 0.3
    private let dealButtonColor: Color = Color.rainbowViolet
    private let cheatButtonColor: Color = Color.rainbowOrange
    
    private let cardDeckColorActive: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color.rainbowRed, Color.rainbowOrange, Color.rainbowYellow, Color.rainbowGreen, Color.rainbowTurquoise, Color.rainbowBlue, Color.rainbowPink, Color.rainbowViolet]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

struct ScreenBottom_Previews: PreviewProvider {
    static var previews: some View {
        ScreenBottom(cardDeckPosition: .constant(CGRect(x: 100, y: 200, width: 200, height: 400)), cardSize: .constant(CGSize(width: 50, height: 100)), size: CGSize(width: 400, height: 800)) {
            print("deal cards")
        } cheatAction: {
            print("cheat cards")
        }
        .environmentObject(SetGame())
    }
}

