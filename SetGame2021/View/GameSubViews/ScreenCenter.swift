//
//  ScreenCenter.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/2/21.
//

import SwiftUI

struct ScreenCenter: View {
    
    // MARK: - Public View API
    
    let game: SetGame
    @Binding var cardDeckPosition: CGRect
    @Binding var cardSize: CGSize

    @Binding var rotationAngle: Double
    let choosingCardAction: (SetGame.ViewCard) -> Void
    let matchingCardAction: () -> Void
    
    var xOffsetRemoval: CGFloat {
        if Bool.random() {
            return CGFloat(offsetConstant)
        } else {
            return CGFloat(offsetConstant * -1)
        }
    }
    
    var yOffsetRemoval: CGFloat {
        if Bool.random() {
            return CGFloat(offsetConstant)
        } else {
            return CGFloat(offsetConstant * -1)
        }
    }
    
    // MARK: - Private View API

    var body: some View {
        NewGridView(game.isDealtViewCards, cardDeckPosition: $cardDeckPosition) { card in
            GeometryReader { localGeoOne in
                ZStack {
                    CardContentView(viewCard: card).opacity(0)
                        .onAppear {
                                cardSize = localGeoOne.size
                        }
                        .onChange(of: localGeoOne.size) { size in
                                cardSize = size
                        }
                    GeometryReader { localGeoTwo in
                        let xOffset = localGeoTwo.frame(in: .global).minX
                        let yOffset = localGeoTwo.frame(in: .global).minY
                        
                        if card.isFaceUp {
                            CardContentView(viewCard: card)
                                .cardify(viewCard: card, angle: rotationAngle)
                                .onTapGesture {
                                    choosingCardAction(card)
                                    matchingCardAction()
                                }
                                .transition(.asymmetric(insertion: .offset(x: cardDeckPosition.minX - xOffset, y: cardDeckPosition.minY - yOffset), removal: .offset(x: cardDeckPosition.minX + xOffsetRemoval, y: cardDeckPosition.minY + yOffsetRemoval)))
                        }
                    }
                    .padding(standardPadding)
                }
                
            }
        }
    }
    
    // MARK: - Private View Constants
    
    let standardPadding: CGFloat = 5
    let offsetConstant: CGFloat = 1000
    
}

struct ScreenCenter_Previews: PreviewProvider {
    static var previews: some View {
        ScreenCenter(game: SetGame(), cardDeckPosition: .constant(CGRect.zero), cardSize: .constant(CGSize(width: 20, height: 60)), rotationAngle: .constant(5.0)) {_ in 
            print("choosing Card")
        } matchingCardAction: {
            print("matching Card")
        }

    }
}
