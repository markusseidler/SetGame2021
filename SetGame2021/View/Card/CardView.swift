//
//  CardView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/1/21.
//

import SwiftUI

struct CardView: View, CardViewable {
    
    // MARK: - Public API Properties
    
    var baseWidth: CGFloat
    var viewCard: SetGame.ViewCard
    
    // MARK: - Private API Properties
    private let viewCornerRadius: CGFloat = 25.0
    private let widthHeightRatio: CGFloat = 1.5
    
    private let stripsRatio: CGFloat = 0.5
    private let stripsWidthRatio: CGFloat = 20

    private var baseHeight: CGFloat {
        baseWidth * widthHeightRatio
    }
    
    var body: some View {
            ZStack {
                getRoundedRectangleWithShading()
            }
            .frame(width: baseWidth, height: baseHeight, alignment: .center)
    }
    
    
    private func getRoundedRectangleWithShading() -> some View {
        switch viewCard.cardShading {
        case .none:
            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius))
        case .solid:
            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(viewCard.color))
        case .striped:
            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor(viewCard.color), UIColor.white), width: baseWidth / stripsWidthRatio , ratio: stripsRatio), scale: 1))))
        }
    }
    
    private func get
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        
        GroupPreview {
                ZStack {
                    CardView(baseWidth: 100, viewCard: SetGame.ViewCard.example)
                }
        }
        
        
    }
}
