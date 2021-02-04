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
                                ZStack {
                                    NewCardView(viewCard: card).opacity(0)
                                        .onAppear { cardSize = geo.size }
                                        .onChange(of: geo.size, perform: { (size) in
                                            cardSize = size
                                        })
                                    GeometryReader { geoNewCard in
                                        let xOffset = geoNewCard.frame(in: .global).minX
                                        let yOffset = geoNewCard.frame(in: .global).minY
                                        
                                        if card.isFaceUp {
                                            NewCardView(viewCard: card)
                                                .transition(.offset(x: cardDeckPosition.minX - xOffset, y: cardDeckPosition.minY - yOffset))
                                        }
                                    }
                                }
                             
                                    // makes sure that at start cardSize is overwriting initial value of zero
                                .padding(4)
                            }
                        }
                        .padding(10)
                        HStack {
                            ZStack {
//                                ForEach(0..<game.isInDeckViewCards.count) { index in
                                ForEach(0..<1) { _ in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .frame(width: cardSize.width, height: cardSize.height, alignment: .center)
                                            .trackPosition()
                                            .onPreferenceChange(PositionPreferenceKey.self) {
                                                cardDeckPosition = $0
                                            }
                                    }
//
//                                    if index == 0 {
//                                        NewCardView(viewCard: game.isInDeckViewCards[index]).stacked(at: index, in: game.isInDeckViewCards.count)
//                                            .frame(width: cardSize.width, height: cardSize.height)
//                                    } else {
//                                        NewCardView(viewCard: game.isInDeckViewCards[index]).stacked(at: index, in: game.isInDeckViewCards.count)
//                                            .frame(width: cardSize.width, height: cardSize.height)
//                                            .onAppear {
//                                                print(cardDeckPosition.origin, cardDeckPosition.size)
//                                            }
//                                    }
//
                                }
                            }
                            VStack {
                                Button {
                                    withAnimation(Animation.easeInOut(duration: 2)) {
                                        game.turnCardFaceUp()
                                    }
                                } label: {
                                    Text("Deal")
                                }
                                Button {
                                    withAnimation(Animation.easeInOut(duration: 2)) {
                                        game.dealThreeMoreCards()
                                        game.turnCardFaceUp()
                                    }
                                } label: {
                                    Text("Deal 3 more")
                                }
                                

                                // Cheat Button, Deal Button
                            }
                        }
                    }
                    
                }
                
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    TrialTest().testCheckFeatureThreeNoMatch()
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
