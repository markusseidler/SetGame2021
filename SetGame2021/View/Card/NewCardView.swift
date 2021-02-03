//
//  NewCardView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 1/2/21.
//

import SwiftUI

// TODO: Fix sizetracking for deck ... check also gameView which has its size fixed now at 50/100

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
                    getCardsWithContent()
                        .padding(.vertical)
                } else {
                    getCardsWithContent()
                        .padding(.horizontal)
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
    
    private func getCardsWithContent() -> some View {
        
        if verticalSizeClass == .regular {
            return AnyView(VStack(spacing: -5) {
                groupSingleCardContentViews()
            })
        } else {
            return AnyView(HStack(spacing: -8) {
                groupSingleCardContentViews()
            })
        }
    }
    
    private func groupSingleCardContentViews() -> some View {
        switch viewCard.cardShape {
        case .diamond:
            return AnyView(
                Group {
                SingleCardContentView(content: Diamond(), viewCard: viewCard)
                    .padding(.horizontal)
                    .opacity(viewCard.quantity > 1 ? 1 : 0)
                SingleCardContentView(content: Diamond(), viewCard: viewCard)
                    .padding(.horizontal)
                    .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                SingleCardContentView(content: Diamond(), viewCard: viewCard)
                    .padding(.horizontal)
                    .opacity(viewCard.quantity > 1 ? 1 : 0)
                }
        )
      
        case .oval:
            return AnyView(
                Group {
                    SingleCardContentView(content: Oval(), viewCard: viewCard)
                        .padding(.horizontal)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                    SingleCardContentView(content: Oval(), viewCard: viewCard)
                        .padding(.horizontal)
                        .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                    SingleCardContentView(content: Oval(), viewCard: viewCard)
                        .padding(.horizontal)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                }
            )
            
        case .squiggle:
            return AnyView(
                Group {
                    SingleCardContentView(content: Squiggle(), viewCard: viewCard)
                        .padding(.horizontal)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                    SingleCardContentView(content: Squiggle(), viewCard: viewCard)
                        .padding(.horizontal)
                        .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                    SingleCardContentView(content: Squiggle(), viewCard: viewCard)
                        .padding(.horizontal)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                }
            )
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
