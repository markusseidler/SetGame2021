//
//  Array+ContainsFullSet.swift
//  SetGame2021
//
//  Created by Markus Seidler on 11/2/21.
//

import Foundation

extension Array where Element == [SetCard] {
    func containsFullSet(_ setCardArray: [[SetCardable]]) -> [Bool]? {
        
        var results = [Bool]()
        
        for setA in setCardArray {
            for setB in self {
                guard setA.count == 3 && setB.count == 3 else { return nil }
                
                if setB.containsSetCard(setA[0])
                 && setB.containsSetCard(setA[1])
                    && setB.containsSetCard(setA[2]) {
                    results.append(true)
                }
            }
        }
        
        if !results.isEmpty {
            return results
        } else {
            return nil
        }
        
    }
    
}
