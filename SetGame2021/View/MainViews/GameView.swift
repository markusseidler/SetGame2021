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
    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
    
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.green.opacity(0.3).edgesIgnoringSafeArea(.all)
                    VStack {
                        createUpperScreen(size: geometry.size)
                            .padding(.top)
                        
                        NewGridView(game.isDealtViewCards, cardDeckPosition: $cardDeckPosition) { card in
                            GeometryReader { geo in
                                NewCardView(viewCard: card)
                                    // makes sure that at start cardSize is overwriting initial value of zero
                                    .onAppear {
                                        cardSize = geo.size
                                    }
                                    .onChange(of: geo.size, perform: { (size) in
                                        cardSize = size
                                    })
                                .padding(4)
                            }
                        }
                        .padding(10)
                        HStack {
                            ZStack {
                                ForEach(0..<game.isInDeckViewCards.count) { index in
                                    NewCardView(viewCard: game.isInDeckViewCards[index]).stacked(at: index, in: game.isInDeckViewCards.count)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .trackPosition()
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
        
        GroupPreview {
            GameView()
        }
        
//        GameView()
       
    }
}
