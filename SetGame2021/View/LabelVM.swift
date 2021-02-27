//
//  LabelVM.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

struct LabelVM: ViewModifier {
    
    var geometrySize: CGSize
    var opacityLevel: Double
    var color: Color = Color.appSecondary
    var widthPercentage: CGFloat = 30
    
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
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(color)
                .opacity(opacityLevel)
            content
                .font(Font.system(size: viewFontSize, design: .rounded))
                .foregroundColor(Color.white)
              
        }
        .frame(width: viewWidth, height: viewHeight, alignment: .center)
    }
    
}


struct LabelVM_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Text("Total ").modifier(LabelVM(geometrySize: CGSize(width: 300, height: 700), opacityLevel: 0.5))
            Text("Total ").modifier(LabelVM(geometrySize: CGSize(width: 300, height: 700), opacityLevel: 1.0))
        }
    }
    
}

