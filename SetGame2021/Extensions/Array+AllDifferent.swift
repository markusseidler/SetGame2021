//
//  Array+AllDifferent.swift
//  SetGame2021
//
//  Created by Markus Seidler on 15/1/21.
//

import Foundation

extension Array where Element: Hashable {
    func allDifferent() -> Bool {
//        self.dropFirst().allSatisfy { $0 != self.first}
        self.count == Set(self).count
    }
}
