//
//  SizePreferenceKey.swift
//  SetGame2021
//
//  Created by Markus Seidler on 2/2/21.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
    typealias Value = CGSize
}

struct SizeModifier: ViewModifier {
    
    private var sizeView: some View {
        GeometryReader { geo in
            Color.clear.preference(key: SizePreferenceKey.self, value: geo.size)
        }
    }

    func body(content: Content) -> some View {
        content
            .background(sizeView)
    }
}

extension View {
    func trackingCGSize() -> some View {
        self.modifier(SizeModifier())
    }
}
