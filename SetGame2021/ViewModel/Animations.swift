//
//  Animations.swift
//  SetGame2021
//
//  Created by Markus Seidler on 16/1/21.
//

import SwiftUI

struct Animations {
    
    static func delayedAction(by delayingIndex: Double, duration: Double,  action: @escaping() -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * delayingIndex) {
            withAnimation(.easeInOut(duration: duration)) {
                action()
            }
        }
    }
}
