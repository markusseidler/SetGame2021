//
//  GameView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

// TODO: - Recording Size of Griditems and apply to Deck... and then add animations flying from Deck and flipping over...

struct GameView: View {
    
    @StateObject var game = SetGame() 
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.green.opacity(0.3).edgesIgnoringSafeArea(.all)
                    VStack {
                        createUpperScreen(size: geometry.size)
                            .padding(.top)
                        //                    LazyGridView(game: game)
                        NewGridView(game.isDealtViewCards) { card in
                            NewCardView(viewCard: card)
                                .padding(4)
                            //                        TestCardView(viewCard: card)
                            
                        }
                        .padding(10)
                        HStack {
                            ZStack {
                                ForEach(0..<game.isInDeckViewCards.count) { index in
                                    NewCardView(viewCard: game.isInDeckViewCards[index]).stacked(at: index, in: game.isInDeckViewCards.count)
                                        .frame(width: 50, height: 100)
                                }
                            }
                            VStack {
                                // Cheat Button, Deal Button
                            }
                        }
                    }
                    
                }
                
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    game.dealFirstTwelveCards()
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
            .convertToStandardLabel(size: size, opacity: 1.0, color: Color.green, widthPercentage: 33)
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
