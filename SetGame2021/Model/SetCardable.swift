//
//  SetCardable.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import Foundation

protocol SetCardable {
    var quantity: Quantity { get }
    var shape: Shapes { get }
    var shading: Shading { get }
    var cardColor: CardColor { get }
}
