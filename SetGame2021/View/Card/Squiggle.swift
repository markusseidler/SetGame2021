//
//  Squiggle.swift
//  SetGame2021
//
//  Created by Markus Seidler on 19/1/21.
//

import SwiftUI

//https://forums.swift.org/t/viewmodifier-where-content-is-shape-and-needs-stroke/38176

// 150, 170, 340, 30

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let centerOffset: CGFloat = min(rect.height, rect.width) / 5
        
        
        let radius = rect.width / 5
        let leftLeftAngle = Angle(degrees: 180)
        let rightLeftAngle = Angle(degrees: 330)
        let leftRightAngle = Angle(degrees: 150)
        let rightRightAngle = Angle(degrees: 0)
        let leftViewCenterUp = CGPoint(x: rect.midX / 2, y: rect.midY - centerOffset)
        let rightViewCenterUp = CGPoint(x: rect.midX + rect.midX / 2, y: rect.midY - centerOffset)
        let leftViewCenterDown = CGPoint(x: rect.midX / 2, y: rect.midY + centerOffset)
        let rightViewCenterDown = CGPoint(x: rect.midX + rect.midX / 2, y: rect.midY + centerOffset)
        
        path.addArc(center: rightViewCenterDown, radius: radius, startAngle: rightRightAngle, endAngle: leftRightAngle, clockwise: false)
        path.addArc(center: leftViewCenterDown, radius: radius, startAngle: rightLeftAngle, endAngle: leftLeftAngle, clockwise: true)
        path.addArc(center: leftViewCenterUp, radius: radius, startAngle: leftLeftAngle, endAngle: rightLeftAngle, clockwise: false)
        path.addArc(center: rightViewCenterUp, radius: radius, startAngle: leftRightAngle, endAngle: rightRightAngle, clockwise: true)
        path.addLine(to: CGPoint(x: rightViewCenterDown.x + radius, y: rect.midY + centerOffset))
        
        return path
    }
    
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.blue.opacity(0.4))
            Squiggle()
//                .fill(Color.white)
                .stroke()
                .padding()
        }
        
    }
}
