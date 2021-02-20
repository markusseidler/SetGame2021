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
    
    static func standard(action: @escaping () -> Void) {
        easeInOut(duration: 1.0, action: action)
    }
    
    static func fast(action: @escaping () -> Void) {
        easeInOut(duration: 0.1, action: action)
    }
    
    static func standardDelayed(action: @escaping () -> Void ) {
        withAnimation(Animation.easeInOut(duration: 1.0).delay(0.3)) {
            action()
        }
    }
    
    static private func easeInOut(duration: Double, action: @escaping () -> Void ) {
        withAnimation(Animation.easeInOut(duration: duration)) {
            action()
        }
    }
}
