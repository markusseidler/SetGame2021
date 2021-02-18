//
//  ScreenCenter.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/2/21.
//

import SwiftUI

struct ScreenCenter: View {
    let game: SetGame
    @Binding var cardDeckPosition: CGRect
    
    var body: some View {
        NewGridView(game.isDealtViewCards, cardDeckPosition: $cardDeckPosition) { card in
            
            // continue here... 
            <#code#>
        }
    }
}

struct ScreenCenter_Previews: PreviewProvider {
    static var previews: some View {
        ScreenCenter()
    }
}

private var gridBody: some View {
    NewGridView(game.isDealtViewCards, cardDeckPosition: $cardDeckPosition) { card in
        GeometryReader { geo in
            ZStack {
                CardContentView(viewCard: card).opacity(0)
                    .onAppear { cardSize = geo.size }
                    .onChange(of: geo.size, perform: { (size) in
                        cardSize = size
                    })
                GeometryReader { geoNewCard in
                    let xOffset = geoNewCard.frame(in: .global).minX
                    let yOffset = geoNewCard.frame(in: .global).minY
                    
                    if card.isFaceUp {
                        CardContentView(viewCard: card)
                            .cardify(viewCard: card, angle: rotationAngle)
                            .onTapGesture {
                                choosingCard(card)
                                game.checkAndMatchOrNot {
                                    matchedAnimation()
                                } negativeAction: {
                                    haptics?.wrongSelection()
                                }

                            }
                            .transition(.offset(x: cardDeckPosition.minX - xOffset, y: cardDeckPosition.minY - yOffset))
                            .accessibility(identifier: AccessID.singleCardView)
                    }
                }
            }
            .padding(4)
        }
    }
    
}
