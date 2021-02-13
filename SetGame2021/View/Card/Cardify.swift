//
//  Cardify.swift
//  SetGame2021
//
//  Created by Markus Seidler on 5/2/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    var viewCard: SetGame.ViewCard
    
    init(_ viewCard: SetGame.ViewCard) {
        self.viewCard = viewCard
        self.rotation = viewCard.turnAround ? 0 : 180
    }
    
    var isShowingFaceUp: Bool { rotation < 90 }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
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
    private let viewCornerRadius: CGFloat = 25.0
    private let frontCardColor: Color = Color.white
    private let backCardColor: Color = Color.black
    private let lineColor: Color = Color.black
    private let borderLineWidth: CGFloat = 6.0
    
}

extension View {
    func cardify(viewCard: SetGame.ViewCard) -> some View {
        self.modifier(Cardify(viewCard))
    }
}

