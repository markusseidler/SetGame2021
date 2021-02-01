//
//  CardViewable.swift
//  SetGame2021
//
//  Created by Markus Seidler on 18/1/21.
//

import SwiftUI

protocol CardViewable: View {
    
//    var baseWidth: CGFloat { get }
    var viewCard: SetGame.ViewCard { get }
    
}
