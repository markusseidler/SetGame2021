//
//  CardDeck.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/2/21.
//

import SwiftUI

struct CardDeck: View {
    @Binding var cardDeckPosition: CGRect
    @Binding var cardSize: CGSize
//    var deckColor: Color
    var deckColor: LinearGradient
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: min(cardSize.width, cardSize.height) / 4)
                .fill(deckColor)
                .frame(width: cardSize.width, height: cardSize.height, alignment: .center)
                .trackPosition()
                .onPreferenceChange(PositionPreferenceKey.self) {
                    cardDeckPosition = $0
            }
        }
    }
    
    // MARK: - Private View Constants
}

struct CardDeck_Previews: PreviewProvider {
    static var previews: some View {
        CardDeck(cardDeckPosition: .constant(CGRect(x: 100, y: 100, width: 200, height: 500)), cardSize: .constant(CGSize(width: 20, height: 50)), deckColor: LinearGradient.active)
    }
}
