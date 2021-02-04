//
//  Diamond.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

struct Diamond: Shape {
    
    private let yAxisScalingFactor: CGFloat = 0.5
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let yMaxScaled = (rect.maxY - rect.midY) * yAxisScalingFactor + rect.midY
        let yMinScaled = rect.midY - (rect.midY - rect.minY) * yAxisScalingFactor
        
        let xCenterYMinScaled = CGPoint(x: rect.midX, y: yMinScaled)
        let xCenterYMaxScaled = CGPoint(x: rect.midX, y: yMaxScaled)
        let xMinYCenter = CGPoint(x: rect.minX, y: rect.midY)
        let xMaxYCenter = CGPoint(x: rect.maxX, y: rect.midY)
        
        path.move(to: xCenterYMinScaled)
        path.addLine(to: xMaxYCenter)
        path.addLine(to: xCenterYMaxScaled)
        path.addLine(to: xMinYCenter)
        path.addLine(to: xCenterYMinScaled)
    
        return path
    }

}


struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.blue.opacity(0.4))
            Diamond()
//                .fill(Color.white)
                .stroke(Color.black)
        }
        
    }
}
