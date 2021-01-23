//
//  GameView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

// TODO: - LazyGrid bauen und Card deck... fix the size for both

struct GameView: View {
    
    @StateObject var game = SetGame() 
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    createUpperScreen(size: geometry.size)
                    LazyGridView(game: game)
                    HStack {
                        ZStack {
                            ForEach(0..<game.isInDeckViewCards.count) { index in
                                CardView(baseWidth: 100, viewCard: game.isInDeckViewCards[index]).stacked(at: index, in: game.isInDeckViewCards.count)
                            }
                        }
                        VStack {
                            // Cheat Button, Deal Button
                        }
                    }
                }
                
            }
    }
    
    private func createUpperScreen(size: CGSize) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Button(action: {
                print("Button pressed")
            }, label: {
                Text("\(TextContent.newGame)")
            })
            .convertToStandardLabel(size: size, opacity: 1.0, color: Color.blue, widthPercentage: 33)
            Spacer()
            Text("\(TextContent.bonusScore)10").convertToStandardLabel(size: size, opacity: 0.5, widthPercentage: 28)
            Spacer()
            Text("\(TextContent.totalScore)10").convertToStandardLabel(size: size, opacity: 1.0, widthPercentage: 28)
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        
//        GroupPreview {
//            GameView()
//        }
        
        GameView()
       
    }
}
