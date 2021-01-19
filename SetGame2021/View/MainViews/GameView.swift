//
//  GameView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

struct GameView: View {
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            print("Button pressed")
                        }, label: {
                            Text("\(TextContent.newGame)")
                        })
                        .convertToStandardLabel(size: geometry.size, opacity: 1.0, color: Color.blue, widthPercentage: 33)
                        Spacer()
                        Text("\(TextContent.bonusScore)10").convertToStandardLabel(size: geometry.size, opacity: 0.5, widthPercentage: 28)
                        Spacer()
                        Text("\(TextContent.totalScore)10").convertToStandardLabel(size: geometry.size, opacity: 1.0, widthPercentage: 28)
                        Spacer()
                    }
                    // Lazy Grid
                    HStack {
                        // Deck of Cards
                        VStack {
                            // Cheat Button, Deal Button
                        }
                    }
                }
                
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        
        GroupPreview {
            GameView()
        }
       
    }
}
