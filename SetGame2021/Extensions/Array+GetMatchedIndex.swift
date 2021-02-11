//
//  Array+GetMatchedIndex.swift
//  SetGame2021
//
//  Created by Markus Seidler on 15/1/21.
//

import Foundation

// checks if the id of the Element is matching any Element in the original array
extension Array where Element: Identifiable {
    func getMatchedIndexByID(of matchingElement: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matchingElement.id {
                return index
            }
        }
        return nil
    }
}

// checks if the four feature of the SetCard are matching any SetCard in the original array
extension Array where Element: SetCardable {
    func getMatchedIndexBySetCardFeatures(of matchingSetCard: SetCardable) -> Int? {
        for index in 0..<self.count {
            if self[index].featureOne == matchingSetCard.featureOne && self[index].featureTwo == matchingSetCard.featureTwo && self[index].featureThree == matchingSetCard.featureThree && self[index].featureFour == matchingSetCard.featureFour {
                return index
            }
        }
        return nil
    }
}



