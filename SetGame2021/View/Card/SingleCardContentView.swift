//
//  SingleCardContentView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 2/2/21.
//

import SwiftUI

//https://programmingwithswift.com/pass-swiftui-view-as-argument-to-another-view/

struct SingleCardContentView<Content: Shape>: View {
    
    let content: Content
    let viewCard: ViewCardable
    
    var body: some View {
        ZStack {
            content
                .stroke(viewCard.color)
            content
                .fillWithShading(viewCard: viewCard)
        }
    }
}

struct SingleCardContentView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardContentView(content: Squiggle(), viewCard: SetGame.ViewCard.exampleSquiggleTwo)
    }
}
