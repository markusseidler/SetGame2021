//
//  GameViewNew.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/2/21.
//

import SwiftUI

struct GameViewNew: View {
    
    @StateObject var game = SetGame()
    @EnvironmentObject var globalAspect: GlobalAspect
    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
//    @State private var showMatchedText: Bool = false
    @State private var rotationAngle: Double = 0
    @State private var availableSets: AvailableSets?
    @State private var haptics: Haptics?
    @State private var blackBackgroundOpacity: Double = 1
    
    
    var body: some View {
        GeometryReader { globalGeo in
            ZStack {
                Color.gray.opacity(opacityMedium).edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ScreenTop(game: game, size: globalGeo.size)
                        .padding(.top, paddingBase)
                    
                    ScreenCenter(game: game, cardDeckPosition: $cardDeckPosition, cardSize: $cardSize, rotationAngle: $rotationAngle, choosingCardAction: {
                        card in choosingCard(card)
                    }, matchingCardAction: matchingCard)
                    .padding(.leading, paddingBase)
                    
                    ScreenBottom(cardDeckPosition: $cardDeckPosition, cardSize: $cardSize, size: globalGeo.size) {
                        game.dealAndDisplayCards()
                    } cheatAction: {
                        cheat()
                    }
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
            Animations.standardDelayed { blackBackgroundOpacity = 0.0 }
            haptics = Haptics()
        }
        
    }
    
    // MARK: - Private Methods
    
    private func choosingCard(_ card: SetGame.ViewCard) {
        game.chooseCard(card)
    }
    
    private func matchingCard() {
        
    }
    
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
    
    private func getAvailableSetsAlert(count: Int) -> Alert {
        Alert(title: Text(TextContent.matchedSets), message: Text(TextContent.getAvailableSetMessage(count: count)), dismissButton: .default(Text("Ok")))
    }
    
    // MARK: - Private view constants
    private let opacityFull: Double = 1.0
    private let opacityMedium: Double = 0.3
    private let opacityNone: Double = 0.0
    
    private let paddingBase: CGFloat = 10
    private let paddingLarge: CGFloat = 15
    private let paddingSmall: CGFloat = 5
    
}

struct GameViewNew_Previews: PreviewProvider {
    static var previews: some View {
        GameViewNew()
            .environmentObject(GlobalAspect())
    }
}