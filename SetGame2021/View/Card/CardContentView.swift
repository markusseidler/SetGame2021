//
//  GroupOfCardContentView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 6/2/21.
//

import SwiftUI

struct CardContentView: View {
    var viewCard: SetGame.ViewCard
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        if verticalSizeClass == .regular {
            return AnyView(VStack {
                GroupSingleCardContentView
                    .padding()
            })
            .padding(.horizontal)
        } else {
            return AnyView(HStack {
                GroupSingleCardContentView
                    .padding()
            })
            .padding(.vertical)
        }
    }
    
    
    var GroupSingleCardContentView: some View {
        switch viewCard.cardShape {
        case .diamond:
            return AnyView(
                Group {
                    SingleCardContentView(content: Diamond(), viewCard: viewCard)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                    SingleCardContentView(content: Diamond(), viewCard: viewCard)
                        .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                    SingleCardContentView(content: Diamond(), viewCard: viewCard)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                })
        case .oval:
            return AnyView(
                Group {
                    SingleCardContentView(content: Oval(), viewCard: viewCard)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                    SingleCardContentView(content: Oval(), viewCard: viewCard)
                        .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                    SingleCardContentView(content: Oval(), viewCard: viewCard)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                })
        case .squiggle:
            return AnyView(
                Group {
                    SingleCardContentView(content: Squiggle(), viewCard: viewCard)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                    SingleCardContentView(content: Squiggle(), viewCard: viewCard)
                        .opacity(viewCard.quantity == 3 || viewCard.quantity == 1 ? 1 : 0)
                    SingleCardContentView(content: Squiggle(), viewCard: viewCard)
                        .opacity(viewCard.quantity > 1 ? 1 : 0)
                })
        }
    }
    
}

struct GroupOfCardContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentView(viewCard: SetGame.ViewCard.exampleSquiggleThree)
    }
}

