//
//  SingleCardContentView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 2/2/21.
//

import SwiftUI

//https://programmingwithswift.com/pass-swiftui-view-as-argument-to-another-view/

//https://www.hackingwithswift.com/example-code/language/how-to-fix-the-error-protocol-can-only-be-used-as-a-generic-constraint-because-it-has-self-or-associated-type-requirements

struct SingleCardContentView<Content: Shape>: View {
    
    let content: Content
    let viewCard: ViewCardable
    
    var body: some View {
        ZStack {
            content
                .stroke(viewCard.color, style: lineStyle)
            content
                .fillWithShading(viewCard: viewCard)
        }
    }
    
    // MARK: - Private View Constants
    let lineStyle = StrokeStyle(lineWidth: 2, lineCap: .round)
}

struct SingleCardContentView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardContentView(content: Squiggle(), viewCard: SetGame.ViewCard.exampleSquiggleTwo)
    }
}
