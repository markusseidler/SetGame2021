//
//  SetGame2021Tests.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 14/1/21.
//

import XCTest
@testable import SetGame2021

class SetGame2021Tests: XCTestCase {

    override func setUpWithError() throws {
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
    
    func testNumberOfCardsInSetOfCards() throws {
        let testSet = SetOfCards()
        let expectedResult = 81
        let testResult = testSet.setOfCards.count
        
        XCTAssertEqual(expectedResult, testResult)
        
    }
    
    func testDiversityOfFeatureOne() throws {
        let testSet = SetOfCards()
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureOne == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureOne == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureOne == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityOfFeatureTwo() throws {
        let testSet = SetOfCards()
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureTwo == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureTwo == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureTwo == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityOfFeatureThree() throws {
        let testSet = SetOfCards()
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureThree == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureThree == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureThree == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityOfFeatureFour() throws {
        let testSet = SetOfCards()
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureFour == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureFour == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureFour == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityAllFeatures() throws {
        let testSet = SetOfCards()
        let expectedResult = 1
        let testResultOne = testSet.setOfCards.filter { $0.featureOne == .one && $0.featureTwo == .one && $0.featureThree == .one && $0.featureFour == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureOne == .two && $0.featureTwo == .two && $0.featureThree == .two && $0.featureFour == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureOne == .three && $0.featureTwo == .three && $0.featureThree == .three && $0.featureFour == .three }.count
        let testResultFour = testSet.setOfCards.filter { $0.featureOne == .two && $0.featureTwo == .one && $0.featureThree == .one && $0.featureFour == .three }.count
        let testResultFive = testSet.setOfCards.filter { $0.featureOne == .one && $0.featureTwo == .two && $0.featureThree == .three && $0.featureFour == .two }.count
        let testResultSix = testSet.setOfCards.filter { $0.featureOne == .three && $0.featureTwo == .three && $0.featureThree == .two && $0.featureFour == .one }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
        XCTAssertEqual(testResultFour, expectedResult)
        XCTAssertEqual(testResultFive, expectedResult)
        XCTAssertEqual(testResultSix, expectedResult)
    }
    
    func testResetGameAllFalse() throws {
        let testSet = SetOfCards()
        let testResultIsDealtTrue = testSet.setOfCards.contains {$0.isDealt == true }
        let testResultIsSelectedTrue = testSet.setOfCards.contains {$0.isSelected == true }
        let testResultIsMatchedTrue = testSet.setOfCards.contains {$0.isMatched == true }
        
        XCTAssertFalse(testResultIsDealtTrue)
        XCTAssertFalse(testResultIsSelectedTrue)
        XCTAssertFalse(testResultIsMatchedTrue)
    }
    
    func testDealCardTen() throws {
        var testSet = SetOfCards()
        let expectedResult = 10
        testSet.dealCards(numberOfCards: 10)
        let testResult = testSet.setOfCards.filter { $0.isDealt }.count
        
        XCTAssertEqual(testResult, expectedResult)
    }
    
    func testDealCardHundred() throws {
        var testSet = SetOfCards()
        let expectedResult = 81
        testSet.dealCards(numberOfCards: 100)
        let testResult = testSet.setOfCards.filter { $0.isDealt }.count
        
        XCTAssertEqual(testResult, expectedResult)
    }
    
    func testSelectCard() throws {
        var testSet = SetOfCards()
        testSet.selectCard(at: 5)
        let expectedCount = 1
        let testCount = testSet.setOfCards.filter { $0.isSelected }.count
        
        XCTAssertEqual(testCount, expectedCount)
        XCTAssertTrue(testSet.setOfCards[5].isSelected)
    }
    
    func testDeSelectCard() throws {
        var testSet = SetOfCards()
        
        // first select card
        testSet.selectCard(at: 10)
        let expectedCountSelect = 1
        let testCountSelect = testSet.setOfCards.filter { $0.isSelected }.count
        XCTAssertEqual(testCountSelect, expectedCountSelect)
        XCTAssertTrue(testSet.setOfCards[10].isSelected)
        
        // now deSelect
        testSet.deSelectCard(at: 10)
        let expectedCount = 0
        let testCount = testSet.setOfCards.filter { $0.isSelected }.count
        XCTAssertEqual(testCount, expectedCount)
        XCTAssertFalse(testSet.setOfCards[10].isSelected)
    
    }
    

}
