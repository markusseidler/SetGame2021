//
//  ScreenTop.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/2/21.
//

import SwiftUI

struct ScreenTop: View {
    
    // MARK: - Public View API
    
    let game: SetGame
    let size: CGSize
    
    // MARK: - Private View API
    
    var body: some View {
        HStack(alignment: .center) {
            
            Spacer()
            
            Button(action: {
                game.newGame()
            }, label: {
                Text("\(TextContent.newGame)")
            })
            .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: opacityPrimary, color: Color.rainbowTurquoise))
            
            Spacer()
            
            Text("\(TextContent.bonusScore)10").convertToStandardLabel(size: size, opacity: opacitySecondary, widthPercentage: widthPercentagePrimary)
            
            Spacer()
            
            Text("\(TextContent.totalScore)10").convertToStandardLabel(size: size, opacity: opacityPrimary, widthPercentage: widthPercentagePrimary)
            
            Spacer()
        }
    }
    
    // MARK: - Private View Constants
    
    private let opacityPrimary: Double = 1.0
    private let opacitySecondary: Double = 0.5
    private let widthPercentagePrimary: CGFloat = 28
    
}

struct ScreenTop_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTop(game: SetGame(), size: CGSize(width: 300, height: 600))
            .previewLayout(.sizeThatFits)
        
        ScreenTop(game: SetGame(), size: CGSize(width: 300, height: 600))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
