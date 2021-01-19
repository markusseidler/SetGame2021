//
//  View+LabelVM.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

extension View {
    func convertToStandardLabel(size: CGSize, opacity: Double, color: Color = .secondary, widthPercentage: CGFloat = 30) -> some View {
        self.modifier(LabelVM(geometrySize: size, opacityLevel: opacity, color: color, widthPercentage: widthPercentage))
    }
}
