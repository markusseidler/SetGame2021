//
//  Oval.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

struct Oval: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = min(rect.height, rect.width) / 5
        let leftCenter = CGPoint(x: rect.midX / 2, y: rect.midY)
        let rightCenter = CGPoint(x: rect.midX + rect.midX / 2, y: rect.midY)
        let rightCenterUp = CGPoint(x: rect.midX + rect.midX / 2, y: rect.midY - radius)
        let leftCenterDown = CGPoint(x: rect.midX / 2, y: rect.midY + radius)
        
        path.addArc(center: leftCenter, radius: radius, startAngle: Angle.radians(0.5 * .pi), endAngle: Angle.radians(1.5 * .pi), clockwise: false)
        path.addLine(to: rightCenterUp)
        path.addArc(center: rightCenter, radius: radius, startAngle: Angle.radians(1.5 * .pi), endAngle: Angle.radians(0.5 * .pi), clockwise: false)
        path.addLine(to: leftCenterDown)
        
        
        
        return path
    }
}

struct Oval_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.blue.opacity(0.4))
            Oval()
//                .fill(Color.white)
                .stroke(Color.black)
        }
    }
}
