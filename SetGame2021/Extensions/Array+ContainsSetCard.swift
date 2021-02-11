//
//  Array+ContainsSetCard.swift
//  SetGame2021
//
//  Created by Markus Seidler on 11/2/21.
//

import Foundation

extension Array where Element: SetCardable {
    func containsSetCard(_ setCard: SetCardable) -> Bool {
        for card in self {
            if card.featureOne == setCard.featureOne && card.featureTwo == setCard.featureTwo && card.featureThree == setCard.featureThree && card.featureFour == setCard.featureFour {
                return true
            }
        }
        return false
    }
}
