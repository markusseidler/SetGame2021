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
    private let widthHeightRatio: CGFloat = 2.0

    private var baseHeight: CGFloat {
        baseWidth * widthHeightRatio
    }
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: viewCornerRadius)
                    .stroke(viewCard.color)
                VStack(spacing: 0) {
                    getRoundedRectangleWithShapeAndQuantity()
                        .padding(.horizontal)
                }
                .padding(.vertical)

//                getRoundedRectangleWithShading()
               
            }
            .frame(width: baseWidth, height: baseHeight, alignment: .center)
    }
    
//    private func getRoundedRectangleWithShading() -> some View {
//        switch viewCard.cardShading {
//        case .none:
//            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius))
//        case .solid:
//            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius)
//                .fill(viewCard.color))
//        case .striped:
//            return AnyView(RoundedRectangle(cornerRadius: viewCornerRadius)
//                .fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor(viewCard.color), UIColor.white), width: baseWidth / stripsWidthRatio , ratio: stripsRatio), scale: 1))))
//        }
//    }
    
    private func getRoundedRectangleWithShapeAndQuantity() -> some View {
        switch viewCard.cardShape {
        case .diamond:
            return AnyView(ForEach(0..<viewCard.quantity) { _ in
                ZStack {
                    Diamond()
                        .stroke(viewCard.color)
                    Diamond()
                        .fillWithShading(viewCard: viewCard, baseWidth: baseWidth)
                }
            })
        case .squiggle:
            return AnyView(ForEach(0..<viewCard.quantity) { _ in
                ZStack {
                    Squiggle()
                        .stroke(viewCard.color)
                    Squiggle()
                        .fillWithShading(viewCard: viewCard, baseWidth: baseWidth)
                }
            })
        case .oval:
            return AnyView(ForEach(0..<viewCard.quantity) { _ in
                ZStack {
                    Oval()
                        .stroke(viewCard.color)
                    Oval()
                        .fillWithShading(viewCard: viewCard, baseWidth: baseWidth)
                }
            })
        }
    }

}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        
        GroupPreview {
            GeometryReader { geometry in
//                let minLength = min(geometry.size.height, geometry.size.width) / 3.5
                let minLength: CGFloat = 100
            VStack {
                HStack {
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleSquiggleThree)
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleDiamondThree)
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleOvalThree)
                }
                HStack {
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleSquiggleTwo)
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleDiamondTwo)
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleOvalTwo)
                }
                
                HStack {
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleSquiggleOne)
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleDiamondOne)
                    CardView(baseWidth: minLength, viewCard: SetGame.ViewCard.exampleOvalOne)
                }
            }
            
        }
        }
    }
}
