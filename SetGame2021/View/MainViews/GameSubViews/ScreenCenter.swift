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
    @Binding var rotationAngle: Double
    let choosingCardAction: () -> Void
    let matchingCardAction: () -> Void
    
    // MARK: - Private View API
    
    @State var cardSize: CGSize = CGSize.zero

    var body: some View {
        NewGridView(game.isDealtViewCards, cardDeckPosition: $cardDeckPosition) { card in
            GeometryReader { localGeoOne in
                ZStack {
                    CardContentView(viewCard: card).opacity(0)
                        .onAppear { cardSize = localGeoOne.size }
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
                                    choosingCardAction()
                                    matchingCardAction()
                                }
                                .transition(.offset(x: cardDeckPosition.minX - xOffset, y: cardDeckPosition.minY - yOffset))
                        }
                    }
                    .padding(standardPadding)
                }
                
            }
        }
    }
    
    // MARK: - Private View Constants
    let standardPadding: CGFloat = 5
}

struct ScreenCenter_Previews: PreviewProvider {
    static var previews: some View {
        ScreenCenter(game: SetGame(), cardDeckPosition: .constant(CGRect.zero), rotationAngle: .constant(5.0)) {
            print("choosing Card")
        } matchingCardAction: {
            print("matching Card")
        }

    }
}
