//
//  Array+ContainsViewCard.swift
//  SetGame2021
//
//  Created by Markus Seidler on 13/2/21.
//

import Foundation

extension Array where Element: ViewCardable {
    func containsViewCard(_ viewCard: ViewCardable) -> Bool {
        for card in self {
            if card.color == viewCard.color && card.cardShading == viewCard.cardShading && card.cardShape == viewCard.cardShape && card.quantity == viewCard.quantity {
                return true
            }
        }
        return false
    }
}
