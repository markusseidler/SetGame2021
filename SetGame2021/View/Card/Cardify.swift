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
            GeometryReader { geo in
                let minLength = min(geo.size.width, geo.size.height) * scaleFactorRectangle
                
                Group {
                    ZStack {
                        RoundedRectangle(cornerRadius: viewCornerRadius)
                            .fill(viewCard.isSelected ? LinearGradient.active : LinearGradient.white)
                    RoundedRectangle(cornerRadius: viewCornerRadius)
                        .fill(frontCardColor)
                        .frame(width: geo.size.width - minLength , height: geo.size.height - minLength, alignment: .center)
                    content
                        .frame(width: geo.size.width * scaleFactorContent , height: geo.size.height * scaleFactorContent, alignment: .center)
                        
                    }
                }
                .rotationEffect(Angle.degrees(rotation2D))
            }
        }
        
        var backFrontView: some View {
            Group {
                RoundedRectangle(cornerRadius: viewCornerRadius)
                    .fill(LinearGradient.active)
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
    
    private let scaleFactorRectangle: CGFloat = 0.10
    private let scaleFactorContent: CGFloat = 1.0
    
}

extension View {
    func cardify(viewCard: SetGame.ViewCard, angle: Double = 10, geoSize: CGSize) -> some View {
        self.modifier(Cardify(viewCard, rotationAngle: angle, geoSize: geoSize))
    }
}

