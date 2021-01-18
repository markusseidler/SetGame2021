//
//  ViewCard.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/1/21.
//

import SwiftUI

protocol ViewCardable {
    // Specific to Set Card in the ViewModel and View. Four features per card.
    
    var color: Color { get }
    var quantity: Int { get }
    var cardShape: SetGame.CardShapes { get }
    var cardShading: SetGame.CardShading { get }
    
}
