//
//  Array+AllEqual.swift
//  SetGame2021
//
//  Created by Markus Seidler on 15/1/21.
//

import Foundation

extension Array where Element: Equatable {
    func allEqual() -> Bool {
        self.dropFirst().allSatisfy { $0 == self.first}
    }
}

