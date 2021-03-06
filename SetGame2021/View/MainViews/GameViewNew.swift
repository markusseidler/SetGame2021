//
//  GameViewNew.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/2/21.
//

import SwiftUI

struct GameViewNew: View {
    
    @EnvironmentObject var game: SetGame
    @EnvironmentObject var globalAspect: GlobalAspect
   
    @State private var blackBackgroundOpacity: Double = 1
    
    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
    
    @State private var matchedTextScale: CGFloat = 0.01
    @State private var matchedTextOpacity: Double = 1.0
    @State private var haptics: Haptics?
    
    @State private var rotationAngle: Double = 0
    @State private var availableSets: AvailableSets?
    
    @State private var isFirstTimeCheat: Bool = true
    @State private var isDealButtonPressed: Bool = false
    @State private var isCheatButtonPressed: Bool = false
    
    var body: some View {
        GeometryReader { globalGeo in
            ZStack {
                Color.gray.opacity(opacityMedium).edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ScreenTop(
                        size: globalGeo.size)
                        .padding(.top, paddingBase)
                    
                    ZStack {
                        
                        ScreenCenter(
                            cardDeckPosition: $cardDeckPosition,
                            cardSize: $cardSize,
                            rotationAngle: $rotationAngle,
                            choosingCardAction: {
                                card in choosingCard(card)},
                            matchingCardAction: { matchingCard()})
                            .padding(.leading, paddingBase)
                    
                        matchedText
                    }
                    
                    ScreenBottom(
                        cardDeckPosition: $cardDeckPosition,
                        cardSize: $cardSize,
                        size: globalGeo.size,
                        dealAction: dealButtonPressed,
                        cheatAction: cheat)
                        .padding(.top, paddingLarge)
                        .padding(.bottom, paddingSmall)
                }
                
                Color.black
                    .opacity(blackBackgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
            }
            .onAppear {
                globalAspect.ratio = globalGeo.size.width / globalGeo.size.height
            }
            .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification), perform: { _ in
                globalAspect.ratio = globalGeo.size.width / globalGeo.size.height
            })
            
        }
        .navigationBarHidden(true)
        .alert(item: $availableSets, content: { (sets) -> Alert in
            getAvailableSetsAlert(count: sets.count)
        })
        .onAppear {
            Animations.veryFast { game.dealCards() }
            Animations.standardDelayed { blackBackgroundOpacity = opacityNone }
            haptics = Haptics()
        }
    }
    
    // MARK: - Private View Properties
    
    private var matchedText: some View {
        if game.currentRoundScore > 0 {
            return Text("+\(game.currentRoundScore)")
                .font(Font.system(.largeTitle, design: .rounded))
                .foregroundColor(Color.appPrimary)
                .scaleEffect(matchedTextScale)
                .opacity(matchedTextOpacity)
        } else {
            return Text(TextContent.noPoints)
                .font(Font.system(.largeTitle, design: .rounded))
                .foregroundColor(Color.appPrimary)
                .scaleEffect(matchedTextScale)
                .opacity(matchedTextOpacity)
        }
       
    }
    
    // MARK: - Private Methods
    
    private func choosingCard(_ card: SetGame.ViewCard) {
        game.chooseCard(card)
    }
    
    private func matchingCard() {
        resetAllMatchedTextStates()
        game.checkIfMatch(
            positiveActionOne: {
                DispatchQueue.main.async {
                    game.stopScoreDecay()
                    matchedTextScale = scaleMedium
                }
            },
            positiveActionTwo: {
                DispatchQueue.main.async {
                    matchedTextOpacity = opacityNone
                }
            },
            positiveActionThree: {
                matchedTextOpacity = opacityNone
                DispatchQueue.main.async {
                    game.addToTotalScore( game.currentRoundScore)
                    game.startScoreDecay()
                    
                    // as game over check
                    // put it background thread as calculations takes too long but ui update are back on main thread again.
                    DispatchQueue.global(qos: .userInitiated).async {
                        let count = game.countOfAvailableSetsInUsedCards
                        
                        DispatchQueue.main.async {
                            if count == 0 {
                                availableSets = AvailableSets(count: game.countOfAvailableSetsDisplayed)
                            }
                        }
                    }
                    
                }
            },
            negativeAction: {
                haptics?.wrongSelection()
            })
    }
    
    private func resetAllMatchedTextStates() {
        matchedTextScale = scaleNone
        matchedTextOpacity = opacityFull
    }
    
    private func cheat() {
        for id in blockID.allCases {
            cheatAnimation(block: id)
        }
    }
    
    private enum blockID: String, CaseIterable { case one, two, three }
    
    private func cheatAnimation(block: blockID) {
        
        isCheatButtonPressed = true
        
        var internalCount: Double {
            switch block {
            case .one: return 1
            case .two: return 5
            case .three: return 9
            }
        }
        
        let animationDuration: Double = 0.2
        let angle = 5.0
        
        game.checkHowManyMatchingSetsAreAvailable()
        
        if game.countOfAvailableSetsDisplayed > 0 {
       
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
            
        } else {
            availableSets = AvailableSets(count: game.countOfAvailableSetsDisplayed)
        }
        
    }
    
    private func getAvailableSetsAlert(count: Int) -> Alert {
        
        // cheating first time
        if isCheatButtonPressed && isFirstTimeCheat && !isDealButtonPressed {
            return Alert(title: Text(TextContent.matchedSets), message: Text(TextContent.getFirstAvailableSetMessage(count: count, cost: game.cheatingCost)), dismissButton: .default(Text(TextContent.defaultText)) {
                isFirstTimeCheat = false
                isCheatButtonPressed = false
            }) }
        
        // cheating AFTER first time
        else if isCheatButtonPressed && !isFirstTimeCheat && !isDealButtonPressed {
                return Alert(title: Text(TextContent.matchedSets), message: Text(TextContent.getAvailableSetMessage(count: count, cost: game.cheatingCost)), dismissButton: .default(Text(TextContent.defaultText)) {
                game.deductFromTotalScore(game.cheatingCost)
                    isCheatButtonPressed = false
            })
            }
        
        // dealing when more than three sets are available
        else if !isCheatButtonPressed && isDealButtonPressed {
                return Alert(title: Text(TextContent.dealButtonPressed), message: Text(TextContent.getDealCostPointsMessage(cost: game.dealingCost)), primaryButton: .cancel({
                    isDealButtonPressed = false
                }), secondaryButton: .default(Text(TextContent.deal), action: {
                    isDealButtonPressed = false
                    game.dealAndDisplayCards()
                    game.deductFromTotalScore(game.dealingCost)
                }))
            }
        
        // game-over-message
        else if game.countOfAvailableSetsInUsedCards == 0 && !isCheatButtonPressed && !isDealButtonPressed {
            return Alert(title: Text(TextContent.gameOverTitle), message: Text(TextContent.getGameOverMessage(totalScore: game.totalScore)), dismissButton: .default(Text(TextContent.newGame), action: {
                game.newGame()
            }))
        }
        else {
            return Alert(title: Text("Error"))
        }
    }
    
    private func dealButtonPressed() {
        isDealButtonPressed = true
        game.checkHowManyMatchingSetsAreAvailable()
        if game.countOfAvailableSetsDisplayed > 3 {
            availableSets = AvailableSets(count: game.countOfAvailableSetsDisplayed)
        } else {
            game.dealAndDisplayCards()
            isDealButtonPressed = false
        }
        
    }
    

    
    // MARK: - Private view constants
    
    private let opacityFull: Double = 1.0
    private let opacityMedium: Double = 0.3
    private let opacityNone: Double = 0.0
    
    private let paddingBase: CGFloat = 10
    private let paddingLarge: CGFloat = 15
    private let paddingSmall: CGFloat = 5
    
    private let scaleNone: CGFloat = 0.01
    private let scaleMedium: CGFloat = 2.0
}

struct GameViewNew_Previews: PreviewProvider {
    static var previews: some View {
        GameViewNew()
            .environmentObject(GlobalAspect())
    }
}
