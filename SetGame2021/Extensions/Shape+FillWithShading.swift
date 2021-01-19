//
//  Shape+FillWithShading.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

extension Shape {
    func fillWithShading(viewCard: ViewCardable, baseWidth: CGFloat) -> some View {
        let stripsRatio: CGFloat = 0.5
        let stripsWidthRatio: CGFloat = 20

        switch viewCard.cardShading {
        case .none:
            return AnyView(self.fill(Color.white))
        case .solid:
            return AnyView(self.fill(viewCard.color))
        case .striped:
            return AnyView(self.fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor(viewCard.color), UIColor.white), width: baseWidth / stripsWidthRatio , ratio: stripsRatio), scale: 1))))
        }
        
    }
}
