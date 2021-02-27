//
//  ScreenTop.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/2/21.
//

import SwiftUI

struct ScreenTop: View {
    
    // MARK: - Public View API
    
    @EnvironmentObject var game: SetGame
    let size: CGSize
    
    // MARK: - Private View API
    
    var body: some View {
        HStack(alignment: .center) {
            
            Spacer()
            
            Button(action: {
                game.newGame()
            }, label: {
                Text(LocalizedStringKey("newGame"))
            })
            .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: opacityPrimary, color: Color.rainbowTurquoise))
            
            Spacer()
            
            Text("+\(game.currentRoundScore)").convertToStandardLabel(size: size, opacity: opacitySecondary, widthPercentage: widthPercentageSecondary)
            
            Spacer()
            
            Text(TextContent.getTotalScore(game.totalScore)).convertToStandardLabel(size: size, opacity: opacityPrimary, widthPercentage: widthPercentagePrimary)
            
            Spacer()
        }
    }
    
    // MARK: - Private View Constants
    
    private let opacityPrimary: Double = 1.0
    private let opacitySecondary: Double = 0.5
    private let widthPercentagePrimary: CGFloat = 36
    private let widthPercentageSecondary: CGFloat = 22
    
}

struct ScreenTop_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTop(size: CGSize(width: 300, height: 600))
            .previewLayout(.sizeThatFits)
            .environmentObject(SetGame())
        
        ScreenTop(size: CGSize(width: 300, height: 600))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(SetGame())
    }
}
