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
    
    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .fill(Color.primary)
            .frame(width: cardSize.width, height: cardSize.height, alignment: .center)
            .trackPosition()
            .onPreferenceChange(PositionPreferenceKey.self) {
                cardDeckPosition = $0
            }
    }
    
    // MARK: - Private View Constants
    let deckColor = Color.primary
    let radius: CGFloat = 25.0
}

struct CardDeck_Previews: PreviewProvider {
    static var previews: some View {
        CardDeck(cardDeckPosition: .constant(CGRect(x: 100, y: 100, width: 200, height: 500)), cardSize: .constant(CGSize(width: 20, height: 50)))
    }
}
