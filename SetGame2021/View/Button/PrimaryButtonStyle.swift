//
//  PrimaryButtonStyle.swift
//  SetGame2021
//
//  Created by Markus Seidler on 13/2/21.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    // MARK: - Public View API

    var geometrySize: CGSize
    var opacityLevel: Double
    var color: Color = Color.rainbowViolet
    var widthPercentage: CGFloat = 30
    
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(configuration.isPressed ? color.opacity(0.3) : color)
                .opacity(opacityLevel)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            configuration.label
                .font(Font.system(size: viewFontSize, design: .rounded))
                .foregroundColor(Color.white)
            
        }
        .frame(width: viewWidth, height: viewHeight, alignment: .center)
        
        
    }
    
    // MARK: - Private View Constants and Variables
    
    private var baseLength: CGFloat {
        min(geometrySize.width, geometrySize.height)
    }
    
    private var viewWidth: CGFloat {
        baseLength * widthPercentage / 100
    }
    
    private var viewHeight: CGFloat {
        baseLength * 0.10
    }
    
    private var viewFontSize: CGFloat {
        baseLength * 0.05
    }
    
    private let viewCornerRadius: CGFloat = 15.0
  
}
    
