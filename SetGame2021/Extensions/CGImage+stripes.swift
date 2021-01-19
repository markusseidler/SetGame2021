//
//  CGImage+stripes.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

// https://stackoverflow.com/questions/63130755/custom-cross-hatched-background-shape-or-view-in-swiftui

extension CGImage {
    static func stripes(colors: (UIColor, UIColor), width: CGFloat, ratio: CGFloat) -> CGImage {
        let filter = CIFilter.stripesGenerator()
        filter.color0 = CIColor(color: colors.0)
        filter.color1 = CIColor(color: colors.1)
        filter.width = Float(width - width * ratio)
        filter.center = CGPoint(x: width, y: 0)
        let size = CGSize(width: width + width * ratio, height: 1)
        let bounds = CGRect(origin: .zero, size: size)
        
        return CIContext().createCGImage((filter.outputImage?.clamped(to: bounds))!, from: bounds)!
        
        
    }
}
