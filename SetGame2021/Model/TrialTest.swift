//
//  TrialTest.swift
//  SetGame2021
//
//  Created by Markus Seidler on 4/2/21.
//

import SwiftUI

struct TrialTest {
    
    func testCheckFeatureThreeNoMatch() {
        
        for _ in 0..<100 {
            var testSet = SetOfCards()
            
            // select three cards false on featureThree
            let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one))
            let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .one, featureFour: .one))
            let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .one))
            let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
            let _ = indexArray.map { testSet.selectCard(at: $0)}
            
            // check Match - and expect false
            testSet.checkSelectedCardsIfMatchAndChange()

    //        print(testSet.setOfCards[indexCardOne!], testSet.setOfCards[indexCardTwo!], testSet.setOfCards[indexCardThree!])
            
            let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }
            
//            if testResult {
//                print(testSet.setOfCards[indexCardOne!], testSet.setOfCards[indexCardTwo!], testSet.setOfCards[indexCardThree!])
//            }
            
            print(testResult)
        }
        
        
    }
}
