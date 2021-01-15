//
//  Array+GetMatchedIndex.swift
//  SetGame2021
//
//  Created by Markus Seidler on 15/1/21.
//

import Foundation

extension Array where Element: Identifiable {
    func getMatchedIndex(of matchingElement: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matchingElement.id {
                return index
            }
        }
        return nil
    }
}


