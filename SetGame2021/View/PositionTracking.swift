//
//  PositionTracking.swift
//  SetGame2021
//
//  Created by Markus Seidler on 3/2/21.
//

import SwiftUI

struct PositionPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
    
    typealias Value = CGRect
}

struct PositionTrackingModifier: ViewModifier {
    
    private var preferenceTracker: some View {
        GeometryReader { geo in
            Color.clear.preference(key: PositionPreferenceKey.self, value: geo.frame(in: .global))
        }
    }
   
    func body(content: Content) -> some View {
        content
            .background(preferenceTracker)
    }
}

extension View {
    func trackPosition() -> some View {
        self.modifier(PositionTrackingModifier())
    }
}


