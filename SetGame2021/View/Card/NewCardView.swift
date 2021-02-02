//
//  NewCardView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 1/2/21.
//

import SwiftUI

struct NewCardView: View, CardViewable {
    
    var viewCard: SetGame.ViewCard
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    private let viewCornerRadius: CGFloat = 25.0
    private let stackSpacing: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: viewCornerRadius)
                .fill(Color.white)
            if viewCard.isDealt {
                if verticalSizeClass == .regular {
                    VStack(spacing: stackSpacing) {
                        getRoundedRectangleWithShapeAndQuantity()
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                } else {
                    HStack(spacing: stackSpacing) {
                        getRoundedRectangleWithShapeAndQuantity()
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            } else {
                // TODO: Needs to set the size as same as size as GridCards... use preferenceKeys?
                
                ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color.black)
                }
                
//                Image("CardBack")
//                    .resizable()
//                    .scaledToFill()
            }
        }
    }
    
    private func getRoundedRectangleWithShapeAndQuantity() -> some View {
        
        return AnyView(ForEach(0..<viewCard.quantity) { _ in
            switch viewCard.cardShape {
            case .diamond:
                GeometryReader { geo in
                    let minLength = min(geo.size.width, geo.size.height)
                    VStack {
                        Spacer()
                        ZStack {
                            Diamond()
                                .stroke(viewCard.color)
                            Diamond()
                                .fillWithShading(viewCard: viewCard)
                        }
                       Spacer()
                    }
                    .frame(width: minLength, height: minLength, alignment: .center)
                }
            case .squiggle:
                ZStack {
                    Squiggle()
                        .stroke(viewCard.color)
                    Squiggle()
                        .fillWithShading(viewCard: viewCard)
                }
            case .oval:
                ZStack {
                    Oval()
                        .stroke(viewCard.color)
                    Oval()
                        .fillWithShading(viewCard: viewCard)
                }
            }
            
        })
        
    }
    
    private func getCardsWithContent() -> some View {
        
        // TODO: fix this and see if it can be more generalized...
        // idea is to change opactiy due to number of counts
        // hstack for potrait... vstack for landscape
        // and size depending on offered space
        // need to add spacers?
        
        if verticalSizeClass == .regular {
            GeometryReader { geo in
                Group {
                    switch viewCard.cardShape {
                    case .diamond:
                        HStack {
                        SingleCardContentView(content: Diamond(), viewCard: viewCard)
                            .opacity(viewCard.quantity > 1 ? 1 : 0)
                        SingleCardContentView(content: Diamond(), viewCard: viewCard)
                            .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                        SingleCardContentView(content: Diamond(), viewCard: viewCard)
                            .opacity(viewCard.quantity > 1 ? 1 : 0)
                            
                        }
                        
                    case .default:
                        return Text("test")
                    }
                    
                   
                }
                
            }
        }
    }
    

    
    
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPreview {
            VStack {
                HStack {
                    NewCardView(viewCard: SetGame.ViewCard.exampleSquiggleThree)
                    NewCardView(viewCard: SetGame.ViewCard.exampleDiamondThree)
                    NewCardView(viewCard: SetGame.ViewCard.exampleOvalThree)
                }
                HStack {
                    NewCardView(viewCard: SetGame.ViewCard.exampleSquiggleTwo)
                    NewCardView(viewCard: SetGame.ViewCard.exampleDiamondTwo)
                    NewCardView(viewCard: SetGame.ViewCard.exampleOvalTwo)
                }
                
                HStack {
                    NewCardView(viewCard: SetGame.ViewCard.exampleSquiggleOne)
                    NewCardView(viewCard: SetGame.ViewCard.exampleDiamondOne)
                    NewCardView(viewCard: SetGame.ViewCard.exampleOvalOne)
                }
            }
        }
    }
}
