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
                CardDeck(cardDeckPosition: $cardDeckPosition, cardSize: $cardSize)
                Text("\(game.countOfInDeckCards)")
                    .font(.headline)
                    .foregroundColor(Color.white)
            }

            Spacer()

            VStack {

                Button(action: dealAction) {
                    Text(TextContent.deal)
                }
                .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: opacity, color: dealButtonColor))

                Button(action: cheatAction) {
                    Text(TextContent.cheat)
                }
                .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: opacity, color: cheatButtonColor))
            }

            Spacer()
        }
    }
    
    // MARK: - Private View Constants
    
    let opacity: Double = 1.0
    let dealButtonColor: Color = Color.rainbowViolet
    let cheatButtonColor: Color = Color.rainbowOrange
}

struct ScreenBottom_Previews: PreviewProvider {
    static var previews: some View {
        ScreenBottom(cardDeckPosition: .constant(CGRect(x: 100, y: 200, width: 200, height: 400)), cardSize: .constant(CGSize(width: 30, height: 60)), size: CGSize(width: 400, height: 800)) {
            print("deal cards")
        } cheatAction: {
            print("cheat cards")
        }

    }
}
