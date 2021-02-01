//
//  NewGridView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 1/2/21.
//

// TODO: Create

import SwiftUI

struct NewGridView<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var itemArray: [Item]
    private var viewForSingleItem: (Item) -> ItemView
    
    init(_ itemArray: [Item], viewForSingleItem: @escaping (Item) -> ItemView) {
        self.itemArray = itemArray
        self.viewForSingleItem = viewForSingleItem
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NewGridView_Previews: PreviewProvider {
    
    struct myNumber: Identifiable {
        var integer: Int
        var id = UUID()
    }
    
    static var previews: some View {
        
        NewGridView([myNumber(integer: 1), myNumber(integer: 2)]) { (number) in
            Text("\(number.integer)")
        }
    }
}
