//
//  LazyGridView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 21/1/21.
//

import SwiftUI

struct LazyGridView: View {
    
    @StateObject var game: SetGame
    
    var body: some View {
        GeometryReader { geometry in
            let viewMinLength = min(geometry.size.width, geometry.size.height)
            
            let itemBaseWidth = viewMinLength / 5
            
            ScrollView {
                LazyVGrid(columns: getColumns(itemWidth: itemBaseWidth)) {
                    ForEach(game.allViewCards) {card in
                        CardView(baseWidth: itemBaseWidth, viewCard: card)
                    }
                }
            }
        }
        
    }
    
    func getColumns(itemWidth: CGFloat) -> [GridItem] {
        [GridItem(.adaptive(minimum: itemWidth))]
    }
}

struct LazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridView(game: SetGame())
    }
}
