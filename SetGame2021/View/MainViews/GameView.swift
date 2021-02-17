//
//  GameView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

//https://stackoverflow.com/questions/58737344/swiftui-ipados-app-change-text-based-on-orientation

struct GameView: View {
    
    @StateObject var game = SetGame()
    
    @EnvironmentObject var globalAspect: GlobalAspect
    
    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
    @State private var showMatchedText: Bool = false
    @State private var rotationAngle: Double = 0
    @State private var availableSets: AvailableSets?
    @State private var haptics: Haptics?
//    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
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
                        createLowerScreen(size: geometry.size)
                    }
                }
                .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification), perform: { _ in
                    globalAspect.ratio = geometry.size.width / geometry.size.height
                })
                .onAppear {
                    globalAspect.ratio = geometry.size.width / geometry.size.height
                }
                
            }
            .alert(item: $availableSets) { sets in
                getAvailableSetsAlert(count: sets.count)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    game.dealFirstTwelveCards()
                }
                haptics = Haptics()
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
            .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: 1.0, color: Color.rainbowTurquoise))
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
                                .cardify(viewCard: card, angle: rotationAngle)
                                .onTapGesture {
                                    choosingCard(card)
                                    game.checkAndMatchOrNot {
                                        matchedAnimation()
                                    } negativeAction: {
                                        haptics?.wrongSelection()
                                    }

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
    
    private func createLowerScreen(size: CGSize) -> some View {
        return HStack {
            cardDeck
            VStack {
                Button {
                    if game.isFaceUpViewCards.count > 0 {
                        dealMoreCards()
                    } else {
                        startDealing()
                    }
                } label: {
                    Text("Deal")
                }
                .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: 1.0))
                .accessibility(identifier: AccessID.firstDealButton)
                Button {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        cheat()
                    }
                   
                } label: {
                    Text("Cheat")
                }
                .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: 1.0, color: Color.rainbowOrange))
                
            }
        }
    }
    
    private func getAvailableSetsAlert(count: Int) -> Alert {
        Alert(title: Text(TextContent.matchedSets), message: Text(TextContent.getAvailableSetMessage(count: count)), dismissButton: .default(Text("Ok")))
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
            ForEach(0..<1) { _ in
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.primary)
                        .frame(width: cardSize.width, height: cardSize.height, alignment: .center)
                        .trackPosition()
                        .onPreferenceChange(PositionPreferenceKey.self) {
                            cardDeckPosition = $0
                        }
                }
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
//        checkCard()
    }
    
    private func matchedAnimation() {
        withAnimation(.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 3)) {
            showMatchedText = true
        }
    }
    
//    private func checkCard() {
//        if game.threeCardsSelected {
////            game.checkCardsAreASet()
//            if checkIfMatchedCardsAreThree() {
//                withAnimation(Animation.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 5)) {
//                    showMatchedText = true
//                }
//            }
//        }
//    }
    
//    private func checkIfMatchedCardsAreThree() -> Bool {
//        game.isMatchedViewCards.count == 3
//    }
    
    private func cheat() {
        
        for id in blockID.allCases {
            cheatAnimation(block: id)
        }
    }
    
    private enum blockID: String, CaseIterable { case one, two, three }
    
    private func cheatAnimation(block: blockID) {
        
        var internalCount: Double {
            switch block {
            case .one: return 1
            case .two: return 5
            case .three: return 9
            }
        }
        
        let animationDuration: Double = 0.2
        let angle = 5.0
       
        Animations.delayedAction(by: internalCount, duration: animationDuration) {
            rotationAngle = angle
            game.cheatOn()
        }
        
        Animations.delayedAction(by: internalCount + 1, duration: animationDuration) {
            game.cheatOff()
        }
        
        Animations.delayedAction(by: internalCount + 2, duration: animationDuration) {
            rotationAngle = angle * -1
            game.cheatOn()
        }
        
        Animations.delayedAction(by: internalCount + 3, duration: animationDuration) {
            game.cheatOff()
            
        }
        
        if block == .three {
            Animations.delayedAction(by: internalCount + 8, duration: animationDuration) {
                availableSets = AvailableSets(count: game.countOfAvailableSetsDisplayed)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        
//        GroupPreview {
//            GameView()
//        .environmentObject(GlobalAspect())
//        }
        
        GameView()
            .environmentObject(GlobalAspect())
       
    }
}
