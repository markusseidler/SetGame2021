//
//  CardViewable.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/1/21.
//

import SwiftUI

protocol CardViewable {
    associatedtype Content
    associatedtype ContentShading
    
    var baseLength: CGFloat { get }
    var featureColor: Color { get }
    var featureQuantity: Int { get }
    var featureShape: Content { get }
    var featureShading: ContentShading { get }
    
}
