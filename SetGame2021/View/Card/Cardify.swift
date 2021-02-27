//
//  Cardify.swift
//  SetGame2021
//
//  Created by Markus Seidler on 5/2/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    var rotation2D: Double
    var rotationAngle: Double
    var viewCard: SetGame.ViewCard
    
    init(_ viewCard: SetGame.ViewCard, rotationAngle: Double, geoSize: CGSize) {
        self.viewCard = viewCard
        self.rotation = viewCard.turnAround ? 0 : 180
        self.rotation2D = viewCard.isCheated ? rotationAngle : 0
        self.rotationAngle = rotationAngle
        self.viewCornerRadius = min(geoSize.width, geoSize.height) / 4
        
    }
    
    var isShowingFaceUp: Bool { rotation < 90 }
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(rotation, rotation2D) }
        set {
            rotation = newValue.first
            rotation2D = newValue.second
        }
    }
    
    func body(content: Content) -> some View {
        var cardFrontView: some View {
            Group {
                RoundedRectangle(cornerRadius: viewCornerRadius)
                    .fill(frontCardColor)
                RoundedRectangle(cornerRadius: viewCornerRadius)
                    .stroke(viewCard.isSelected ? lineColor : Color.clear, lineWidth: borderLineWidth)
                content
            }
            .rotationEffect(Angle.degrees(rotation2D))
        }
        
        var backFrontView: some View {
            Group {
                RoundedRectangle(cornerRadius: viewCornerRadius)
                    .fill(backCardColor)
                RoundedRectangle(cornerRadius: viewCornerRadius)
                    .stroke(lineColor)
            }
           
        }
        
        return ZStack {
            cardFrontView
                .opacity(isShowingFaceUp ? 1 : 0)
            backFrontView
                .opacity(isShowingFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }

    
    // MARK: - View Constants
    private var viewCornerRadius: CGFloat
    private let frontCardColor: Color = Color.white
    private let backCardColor: Color = Color.primary
    private let lineColor: Color = Color.black
    private let borderLineWidth: CGFloat = 4.0
    
}

extension View {
    func cardify(viewCard: SetGame.ViewCard, angle: Double = 10, geoSize: CGSize) -> some View {
        self.modifier(Cardify(viewCard, rotationAngle: angle, geoSize: geoSize))
    }
}

