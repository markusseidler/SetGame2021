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
    @State private var blackBackgroundOpacity: Double = 1
    
    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
    
    @State private var matchedTextScale: CGFloat = 0.0
    @State private var matchedTextOpacity: Double = 0.0
    @State private var haptics: Haptics?
    
    @State private var rotationAngle: Double = 0
    @State private var availableSets: AvailableSets?
    
    var body: some View {
        GeometryReader { globalGeo in
            ZStack {
                Color.gray.opacity(opacityMedium).edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ScreenTop(
                        game: game,
                        size: globalGeo.size)
                        .padding(.top, paddingBase)
                    
                    ZStack {
                        
                        ScreenCenter(
                            game: game,
                            cardDeckPosition: $cardDeckPosition,
                            cardSize: $cardSize,
                            rotationAngle: $rotationAngle,
                            choosingCardAction: {
                                card in choosingCard(card)},
                            matchingCardAction: { matchingCard()})
                            .padding(.leading, paddingBase)
                        
                        
                    }
                    
                    
                    
//                    ScreenBottom(
//                        cardDeckPosition: $cardDeckPosition,
//                        cardSize: $cardSize,
//                        size: globalGeo.size, dealAction: {
//                        game.dealAndDisplayCards()
//                    }, cheatAction: {
//                        cheat()
//                    })
//                    .padding(.top, paddingLarge)
//                    .padding(.bottom, paddingSmall)
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
        .onChange(of: matchedTextScale, perform: { scale in
            print("changed: \(scale)")
            getScaleRelatedOpacity(scale: scale)
        })
        
    }
    
    // MARK: - Private View Properties
    
    private var matchedText: some View {
        Text(TextContent.matched)
            .font(Font.system(.largeTitle, design: .rounded))
            .scaleEffect(matchedTextScale)
            .opacity(matchedTextOpacity)
    }
    
    // MARK: - Private Methods
    
    private func choosingCard(_ card: SetGame.ViewCard) {
        game.chooseCard(card)
    }
    
    private func matchingCard() {
        matchedTextScale = scaleNone
        game.checkIfMatch {
            matchedTextScale = scaleMedium
        } positiveActionTwo: {
            matchedTextScale = scaleLarge
        } negativeAction: {
            haptics?.wrongSelection()
        }
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
        Alert(title: Text(TextContent.matchedSets), message: Text(TextContent.getAvailableSetMessage(count: count)), dismissButton: .default(Text(TextContent.defaultText)))
    }
    
    private func getScaleRelatedOpacity(scale: CGFloat) {
        if scale == scaleNone || scale == scaleLarge {
            matchedTextOpacity = opacityNone
        } else {
            matchedTextOpacity = opacityMedium
        }
    }
    
    // MARK: - Private view constants
    
    private let opacityFull: Double = 1.0
    private let opacityMedium: Double = 0.3
    private let opacityNone: Double = 0.0
    
    private let paddingBase: CGFloat = 10
    private let paddingLarge: CGFloat = 15
    private let paddingSmall: CGFloat = 5
    
    private let scaleNone: CGFloat = 0.0
    private let scaleMedium: CGFloat = 1.0
    private let scaleLarge: CGFloat = 3.0
    
}

struct GameViewNew_Previews: PreviewProvider {
    static var previews: some View {
        GameViewNew()
            .environmentObject(GlobalAspect())
    }
}
