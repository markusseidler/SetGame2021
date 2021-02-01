//
//  NewGridView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 1/2/21.
//

import SwiftUI

struct NewGridView<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var itemArray: [Item]
    private var viewForSingleItem: (Item) -> ItemView
    
    init(_ itemArray: [Item], viewForSingleItem: @escaping (Item) -> ItemView) {
        self.itemArray = itemArray
        self.viewForSingleItem = viewForSingleItem
    }
    
    var body: some View {
        GeometryReader { geo in
            ForEach(itemArray) { item in
                buildFrameAndPositionForSingleItemView(for: item, in: GridConstructor(itemCount: itemArray.count, geoSize: geo.size))
            }
        }
    }
    
    func buildFrameAndPositionForSingleItemView(for item: Item, in gridConstructor: GridConstructor) -> some View {
        
        let index = itemArray.getMatchedIndexByID(of: item)!
        
        return viewForSingleItem(item)
            .frame(width: gridConstructor.itemSize.width, height: gridConstructor.itemSize.height, alignment: .center)
            .position(gridConstructor.location(at: index))
    }
}

struct NewGridView_Previews: PreviewProvider {
    
    struct myNumber: Identifiable {
        var integer: Int
        var id = UUID()
    }
    
    static var previews: some View {
        
        NewGridView([myNumber(integer: 1), myNumber(integer: 2), myNumber(integer: 3), myNumber(integer: 4), myNumber(integer: 5)]) { (number) in
            Text("\(number.integer)")
        }
    }
}
