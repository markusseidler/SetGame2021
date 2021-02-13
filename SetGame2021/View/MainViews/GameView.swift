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
    @State private var showMatchedText: Bool = false
    
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.gray.opacity(0.3).edgesIgnoringSafeArea(.all)
                    VStack {
                        createUpperScreen(size: geometry.size).padding(.top)
                        ZStack {
                            gridBody.padding(10)
                            if showMatchedText {
                                matchedText
                            }
                        }
                        lowerScreen(size: geometry.size)
                    }
                    
                }
                
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    TrialTest().testCheckFeatureThreeNoMatch()
                    game.dealFirstTwelveCards()
                }
            }
            .navigationBarHidden(true)
    }
    
    // MARK: - Private view methods
    
    private func createUpperScreen(size: CGSize) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Button(action: {
                game.newGame()
            }, label: {
                Text("\(TextContent.newGame)")
            })
            .accessibility(identifier: AccessID.newGameButton)
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
                                .cardify(viewCard: card)
                                .onTapGesture {
                                   choosingCard(card)
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
    
    private func lowerScreen(size: CGSize) -> some View {
        return HStack {
            cardDeck
            VStack {
                Button {
                    startDealing()
                } label: {
                    Text("Deal")
                }
    .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: 1.0))
                .accessibility(identifier: AccessID.firstDealButton)
                Button {
                    dealMoreCards()
                } label: {
                    Text("Deal 3 more")
                }
                // Cheat Button, Deal Button
            }
        }
    }
    
    // MARK: - Private view properties
    
    private var matchedText: some View {
            ZStack {
                Text(TextContent.matched)
                    .background(Color.clear)
                    .foregroundColor(Color.red)
                    .font(Font.system(.largeTitle))
                    .padding()
            }
            .transition(.scale)
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
    
    // MARK: - Private methods
    
    private func startDealing() { turningCardsAnimation() }
    
    private func dealMoreCards() {
        
        let currentlyDisplayedCards = game.isDealtViewCards.count
        
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            game.dealThreeMoreCards()
        }
    
        turningCardsAnimation(isFirstDeal: false, alreadyDisplayedCards: currentlyDisplayedCards)
    }
    
    private func turningCardsAnimation(isFirstDeal: Bool = true, alreadyDisplayedCards: Int = 0) {
        let delayFactor: Double = 0.3
        let animationDuration: Double = 1.0
        let startOfTurnAround: Double = 0.3
        var cardCount: Int { isFirstDeal ? game.isDealtViewCards.count : game.isDealtViewCards.count - alreadyDisplayedCards }
    
        for cardNumber in 0..<cardCount {
            let delayTime = delayFactor * Double(cardNumber)
            withAnimation(Animation.easeInOut(duration: animationDuration).delay(delayTime)) {
                game.turnSingleCardFaceUp(game.isDealtViewCards[alreadyDisplayedCards + cardNumber])
            }
            withAnimation(Animation.easeInOut(duration: animationDuration / 2).delay(delayTime + startOfTurnAround)) {
                game.turnAroundCard(game.isDealtViewCards[alreadyDisplayedCards + cardNumber])
            }
        }
    }
    
    private func choosingCard(_ card: SetGame.ViewCard) {
        game.chooseCard(card)
        checkCard()
    }
    
    private func checkCard() {
        if game.threeCardsSelected {
            game.checkCardsAreASet()
            if checkIfMatchedCardsAreThree() {
                withAnimation(Animation.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 5)) {
                    showMatchedText = true
                }
            }
        }
    }
    
    private func checkIfMatchedCardsAreThree() -> Bool {
        game.isMatchedViewCards.count == 3
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
