//
//  LinearGradient+Extensions.swift
//  SetGame2021
//
//  Created by Markus Seidler on 27/2/21.
//

import SwiftUI

extension LinearGradient {
    static let active = LinearGradient(gradient: Gradient(colors: [Color.rainbowRed, Color.rainbowOrange, Color.rainbowYellow, Color.rainbowGreen, Color.rainbowTurquoise, Color.rainbowBlue, Color.rainbowPink, Color.rainbowViolet]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let passive = LinearGradient(gradient: Gradient(colors: [Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
