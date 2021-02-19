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
//    @State private var cardSize: CGSize = CGSize.zero
    @State private var cardDeckPosition: CGRect = CGRect.zero
//    @State private var showMatchedText: Bool = false
    @State private var rotationAngle: Double = 0
//    @State private var availableSets: AvailableSets?
//    @State private var haptics: Haptics?
//    @State private var blackBackgroundOpacity: Double = 1
    
    
    var body: some View {
        GeometryReader { globalGeo in
            ZStack {
                Color.gray.opacity(opacityMedium).edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScreenTop(game: game, size: globalGeo.size)
                    ScreenCenter(game: game, cardDeckPosition: $cardDeckPosition, rotationAngle: $rotationAngle, choosingCardAction: choosingCard, matchingCardAction: matchingCard)
                        .padding(.leading, paddingBase)
                }
                
                
            }
            
        }
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: - Private Methods
    
    private func choosingCard() {
        
    }
    
    private func matchingCard() {
        
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
    }
}
