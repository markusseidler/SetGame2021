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
//    @State private var rotationAngle: Double = 0
//    @State private var availableSets: AvailableSets?
//    @State private var haptics: Haptics?
//    @State private var blackBackgroundOpacity: Double = 1
    
    
    var body: some View {
        GeometryReader { globalGeo in
            ZStack {
                Color.gray.opacity(opacitySecondary).edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScreenTop(game: game, size: globalGeo.size)
                }
                
                
            }
            
        }
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: - Private view constants
    private let opacityPrimary: Double = 1.0
    private let opacitySecondary: Double = 0.3
    private let opacityNone: Double = 0.0
}

struct GameViewNew_Previews: PreviewProvider {
    static var previews: some View {
        GameViewNew()
    }
}
