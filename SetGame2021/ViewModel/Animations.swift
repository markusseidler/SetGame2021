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
    
    static func veryFast(action: @escaping () -> Void) {
        easeInOut(duration: 0.1, action: action)
    }
    
    static func fast(action: @escaping () -> Void) {
        easeInOut(duration: 0.5, action: action)
    }
    
    static func standardDelayed(action: @escaping () -> Void ) {
        easeInOutDelayed(duration: 1.0, delay: 1.0, action: action)
    }
    
    static func fastStaggered(actionOne: @escaping () -> Void, actionTwo: @escaping () -> Void, actionThree: @escaping () -> Void) {
        
        easeInOut(duration: 0.5, action: actionOne)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            easeInOut(duration: 0.5) {
                actionTwo()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            easeInOut(duration: 0.5) {
                actionThree()
            }
        }
    }
    
    static private func easeInOut(duration: Double, action: @escaping () -> Void ) {
        withAnimation(Animation.easeInOut(duration: duration)) {
            action()
        }
    }
    
    static private func easeInOutDelayed(duration: Double, delay: Double, action: @escaping () -> Void ) {
        withAnimation(Animation.easeInOut(duration: duration).delay(delay)) {
            action()
        }
    }

}
