//
//  View+Stacked.swift
//  SetGame2021
//
//  Created by Markus Seidler on 21/1/21.
//

import SwiftUI

//https://www.hackingwithswift.com/books/ios-swiftui/building-a-stack-of-cards

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(position) * 0.1
        return self.offset(CGSize(width: 0, height: offset))
    }
}
