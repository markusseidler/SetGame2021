//
//  CardView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/1/21.
//

import SwiftUI

struct CardView: View, CardViewable {
    
    // MARK: - Public API Properties
    
    var baseLength: CGFloat
    var viewCard: SetGame.ViewCard
    
    // MARK: - Private API Properties
    private let viewCornerRadius: CGFloat = 25.0
    private let baseLengthDiscount: CGFloat = 0.5
    private let widthHeightRatio: CGFloat = 1.5
    
    private let stripsRatio: CGFloat = 0.25
    private let stripsWidthRatio: CGFloat = 10
    
    // TODO: - Need to think through ... width/ height/ potrait and landscape.. etc? what is fixed?
    
//    private let
//
//    private var baseWidth: CGFloat {
//
//    }
    
    private var baseHeight: CGFloat {
        baseLength * widthHeightRatio
    }
    
    var body: some View {
        GeometryReader { geometry in
            let minLength: CGFloat = min(geometry.size.height, geometry.size.width)
            ZStack {
                getRoundedRectangleWithShading(minLength: minLength)
            }
            .frame(width: baseLength * 0.5, height: baseHeight, alignment: .center)
    }
    
    }
    
    private func getRoundedRectangleWithShading(minLength: CGFloat) -> some View {
        switch viewCard.cardShading {
        case .none:
            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius))
        case .solid:
            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(viewCard.color))
        case .striped:
            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor(viewCard.color), UIColor.white), width: minLength / stripsWidthRatio , ratio: stripsRatio), scale: 1))))
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        
        GroupPreview {
            GeometryReader { geometry in
                let minLength: CGFloat = min(geometry.size.width, geometry.size.height)
                ZStack {
                    CardView(baseLength: minLength, viewCard: SetGame.ViewCard.example)
                    Text("Length: \(geometry.size.height), \nWidth: \(geometry.size.width), \nminLength: \(minLength)")
                }
            }
        }
        
        
    }
}
