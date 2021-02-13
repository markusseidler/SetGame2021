//
//  ViewModelSetGameTests.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 13/2/21.
//

import XCTest
import SwiftUI
@testable import SetGame2021

class ViewModelSetGameTests: XCTestCase {
    
    var testSetGame: SetGame!

    override func setUpWithError() throws {
        
        self.testSetGame = SetGame()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCardIsInCheatMatchingSet() {
        let cardOne = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one)
        let cardTwo = SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .two)
        let cardThree = SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .three)
        let cardOneMatchA = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .two)
        let cardOneMatchB = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .three)
        
        let cardArray = [cardOne, cardTwo, cardThree, cardOneMatchA, cardOneMatchB]

        let viewCard = SetGame.ViewCard(color: Color.rainbowBlue, quantity: 1, cardShape: .diamond, cardShading: .none, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        
        let viewCardTwo = SetGame.ViewCard(color: Color.rainbowGreen, quantity: 3, cardShape: .squiggle, cardShading: .striped, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        
        let viewCardThree = SetGame.ViewCard(color: Color.rainbowRed, quantity: 3, cardShape: .oval, cardShading: .solid, isDealt: true, isFaceUp: true, turnAround: false, isSelected: false, isMatched: false, wasUsed: false, id: UUID())
        
//        testSetGame.cheatCardIsMatching(viewCard, in: cardArray)
//        testSetGame.cheatCardIsMatching(viewCardTwo, in: cardArray)
//        testSetGame.cheatCardIsMatching(viewCardThree, in: cardArray)
//        
//        XCTAssertTrue(viewCard.isCheated)
//        XCTAssertTrue(viewCardTwo.isCheated)
//        XCTAssertFalse(viewCard.isCheated)
        
    }
    
    func checkResetAllHaveIsCheatedFalse() {
        
    }

}
