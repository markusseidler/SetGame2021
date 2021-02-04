//
//  GameView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

// TODO: - Flip Card
// TODO: - select card.. check with match.. animate if match... if not match
// TODO: deal new card...
/// add cheat button


struct GameView: View {
    
    @StateObject var game = SetGame()
    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
    
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.green.opacity(0.3).edgesIgnoringSafeArea(.all)
                    VStack {
                        createUpperScreen(size: geometry.size).padding(.top)
                        gridBody.padding(10)
                        lowerScreen
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
    
    private var gridBody: some View {
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
                                .onTapGesture {
                                    game.chooseCard(card)
                                }
                                .transition(.offset(x: cardDeckPosition.minX - xOffset, y: cardDeckPosition.minY - yOffset))
                        }
                    }
                }
                .padding(4)
            }
        }
    }
    
    private var lowerScreen: some View {
        HStack {
            cardDeck
            VStack {
                Button {
                    startDealing()
                } label: {
                    Text("Deal")
                }
                Button {
                    dealMoreCards()
//                    withAnimation(Animation.easeInOut(duration: 1.0)) {
//                        game.dealThreeMoreCards()
//
//                    }
//
//                    withAnimation(Animation.easeInOut(duration: 1).delay(0.5)) {
//                        game.turnAllCardsFaceUp()
//                    }
                } label: {
                    Text("Deal 3 more")
                }
                // Cheat Button, Deal Button
            }
        }
    }
    
    private var cardDeck: some View {
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
    }
    
    private func startDealing() {
        let delayFactor: Double = 0.3
        let animationDuration: Double = 1.0
        
        for cardNumber in 0..<game.isDealtViewCards.count {
            let delayTime = delayFactor * Double(cardNumber)
            withAnimation(Animation.easeInOut(duration: animationDuration).delay(delayTime)) {
                game.turnSingleCardFaceUp(game.isDealtViewCards[cardNumber])
            }
        }
    }
    
    private func dealMoreCards() {
        let delayFactor: Double = 0.3
        let animationDuration: Double = 1.0
        
        let tempCount = game.isDealtViewCards.count
        
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            game.dealThreeMoreCards()
        }
        let updatedCount = game.isDealtViewCards.count - tempCount
  
        for cardNumber in 0..<updatedCount {
            let delayTime = delayFactor * Double(cardNumber)
            withAnimation(Animation.easeInOut(duration: animationDuration).delay(delayTime)) {
                game.turnSingleCardFaceUp(game.isDealtViewCards[tempCount + cardNumber])
            }
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
