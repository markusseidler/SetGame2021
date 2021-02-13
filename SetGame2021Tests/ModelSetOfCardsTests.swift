//
//  SetGame2021Tests.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 14/1/21.
//

import XCTest
@testable import SetGame2021

class ModelSetOfCardsTests: XCTestCase {
    
    var testSet: SetOfCards!
    var testSetNotShuffled: SetOfCards!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        testSet = SetOfCards()
        testSetNotShuffled = SetOfCards(shuffleCards: false)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
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
        let expectedResult = 81
        let testResult = testSet.setOfCards.count
        
        XCTAssertEqual(expectedResult, testResult)
        
    }
    
    func testDiversityOfFeatureOne() throws {
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureOne == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureOne == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureOne == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityOfFeatureTwo() throws {
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureTwo == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureTwo == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureTwo == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityOfFeatureThree() throws {
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureThree == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureThree == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureThree == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityOfFeatureFour() throws {
        let expectedResult = 27
        let testResultOne = testSet.setOfCards.filter { $0.featureFour == .one }.count
        let testResultTwo = testSet.setOfCards.filter { $0.featureFour == .two }.count
        let testResultThree = testSet.setOfCards.filter { $0.featureFour == .three }.count
        
        XCTAssertEqual(testResultOne, expectedResult)
        XCTAssertEqual(testResultTwo, expectedResult)
        XCTAssertEqual(testResultThree, expectedResult)
    }
    
    func testDiversityAllFeatures() throws {
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
        let testResultIsDealtTrue = testSet.setOfCards.contains {$0.isDealt == true }
        let testResultIsSelectedTrue = testSet.setOfCards.contains {$0.isSelected == true }
        let testResultIsMatchedTrue = testSet.setOfCards.contains {$0.isMatched == true }
        
        XCTAssertFalse(testResultIsDealtTrue)
        XCTAssertFalse(testResultIsSelectedTrue)
        XCTAssertFalse(testResultIsMatchedTrue)
    }
    
    func testDealCardTen() throws {
        let expectedResult = 10
        testSet.dealCards(numberOfCards: 10)
        let testResult = testSet.isDealtCards.count
        
        XCTAssertEqual(testResult, expectedResult)
    }
    
    func testDealCardHundred() throws {
        let expectedResult = 81
        testSet.dealCards(numberOfCards: 100)
        let testResult = testSet.isDealtCards.count
        
        XCTAssertEqual(testResult, expectedResult)
    }
    
    func testSelectCard() throws {
        testSet.selectCard(at: 5)
        let expectedCount = 1
        let testCount = testSet.isSelectedCards.count
        
        XCTAssertEqual(testCount, expectedCount)
        XCTAssertTrue(testSet.setOfCards[5].isSelected)
    }
    
    func testDeSelectCard() throws {
        
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
    
    func testCheckFeatureOneNoMatch() {
        
        // select three cards false on featureOne
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .one))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .three, featureThree: .three, featureFour: .one))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}
        
        // check Match - and expect false
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }
        
        XCTAssertFalse(testResult)
        
    }
    
    func testCheckFeatureTwoNoMatch() {
        
        // select three cards false on featureTwo
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .one))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .three, featureTwo: .one, featureThree: .three, featureFour: .one))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}
        
        // check Match - and expect false
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }
        
        XCTAssertFalse(testResult)
        
    }
    
    func testCheckFeatureThreeNoMatch() {
        
        // select three cards false on featureThree
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .one, featureFour: .one))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .one))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}
        
        // check Match - and expect false
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }
        
        XCTAssertFalse(testResult)
        
    }
    
    func testCheckFeatureFourNoMatch() {
        
        // select three cards false on featureFour
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .one, featureFour: .two))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .three, featureTwo: .three, featureThree: .one, featureFour: .one))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}
        
        // check Match - and expect false
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }
        
        XCTAssertFalse(testResult)
        
    }
    
    func testCheckMatchAllDifferent() {
        
        // select three cards true with features all different
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .two, featureThree: .three, featureFour: .one))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .three, featureTwo: .three, featureThree: .one, featureFour: .two))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .one, featureThree: .two, featureFour: .three))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}
        
        // check Match - and expect true
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }
        
        XCTAssertTrue(testResult)
        
    }
    
    func testCheckMatchFeatureOneTwoThreeEqual() {

        // select three cards true with features all equal except FeatureFour
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .two, featureThree: .three, featureFour: .one))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .two, featureThree: .three, featureFour: .two))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .two, featureThree: .three, featureFour: .three))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}

        // check Match - and expect true
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }

        XCTAssertTrue(testResult)

    }
    
    func testCheckMatchFeatureTwoThreeFourEqual() {

        // select three cards true with features all equal except FeatureOne
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .one, featureTwo: .two, featureThree: .three, featureFour: .three))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .three, featureFour: .three))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .three, featureTwo: .two, featureThree: .three, featureFour: .three))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}

        // check Match - and expect true
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }

        XCTAssertTrue(testResult)

    }
    
    func testMoveToWasUsedCards() {
        
        // select three cards true with features all equal except FeatureTwo
        let indexCardOne = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .one, featureThree: .three, featureFour: .three))
        let indexCardTwo = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .two, featureThree: .three, featureFour: .three))
        let indexCardThree = testSet.setOfCards.getMatchedIndexBySetCardFeatures(of: SetCard(featureOne: .two, featureTwo: .three, featureThree: .three, featureFour: .three))
        let indexArray = [indexCardOne!, indexCardTwo!, indexCardThree!]
        let _ = indexArray.map { testSet.selectCard(at: $0)}
        
        // check Match - and expect true
        testSet.checkSelectedCardsIfMatchAndChange()
        let testResult = [testSet.setOfCards[indexCardOne!].isMatched, testSet.setOfCards[indexCardTwo!].isMatched, testSet.setOfCards[indexCardThree!].isMatched].allSatisfy { $0 }

        XCTAssertTrue(testResult)
        
        // change to wasUsed
        testSet.moveToWasUsedCards()
        let expectedCount = 0
        let expectedCountWasUsed = 3
        let countSelectedCards = testSet.isSelectedCards.count
        let countMatchedCards = testSet.isMatchedCards.count
        let countWasUsedCards = testSet.wasUsedCards.count
        
        XCTAssertEqual(countSelectedCards, expectedCount)
        XCTAssertEqual(countMatchedCards, expectedCount)
        XCTAssertEqual(countWasUsedCards, expectedCountWasUsed)
    }
    
    func testPositiveContainsSetCard() {
        let cardOne = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one)
        let cardTwo = SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .two)
        let cardThree = SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .three)
        
        let cardArray = [cardOne, cardTwo, cardThree]
        let doesContain = cardArray.containsSetCard(SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one))
        
        XCTAssertTrue(doesContain)
    }
    
    func testNegativeContainsSetCard() {
        let cardOne = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one)
        let cardTwo = SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .two)
        let cardThree = SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .three)
        
        let cardArray = [cardOne, cardTwo, cardThree]
        let doesContain = cardArray.containsSetCard(SetCard(featureOne: .one, featureTwo: .one, featureThree: .two, featureFour: .three))
        
        XCTAssertFalse(doesContain)
    }
    
    
    func testGetUniqueSetCombinations() {
        let cardOne = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one)
        let cardTwo = SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .two)
        let cardThree = SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .three)
        let cardFour = SetCard(featureOne: .one, featureTwo: .two, featureThree: .three, featureFour: .one)
        let cardFive = SetCard(featureOne: .one, featureTwo: .three, featureThree: .two, featureFour: .one)

        let cardArray = [cardOne, cardTwo, cardThree, cardFour, cardFive]

        let expectedResult = [[cardFour, cardFive, cardTwo], [cardOne, cardThree, cardFour], [cardTwo, cardOne, cardFour], [cardTwo, cardThree, cardFour], [cardThree, cardFour, cardFive], [cardOne, cardFive, cardTwo], [cardFive, cardOne, cardFour], [cardThree, cardFive, cardTwo], [cardFive, cardOne, cardThree], [cardThree, cardTwo, cardOne]]

        let actualResult = testSet.getUniqueSetCombinations(in: cardArray)
        
        let foundExpectedSetsInActualResult = actualResult.containsFullSet(expectedResult)!.filter { $0 == true }
        let foundActualSetsInExpectedResult = expectedResult.containsFullSet(actualResult)!.filter { $0 == true }
        
        XCTAssertEqual(expectedResult.count, foundExpectedSetsInActualResult.count)
        XCTAssertEqual(actualResult.count, foundActualSetsInExpectedResult.count)
        
    }
    
    func testCheckWhereAreMatchedSets() {
        let cardOne = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .one)
        let cardTwo = SetCard(featureOne: .two, featureTwo: .two, featureThree: .two, featureFour: .two)
        let cardThree = SetCard(featureOne: .three, featureTwo: .three, featureThree: .three, featureFour: .three)
        let cardOneMatchA = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .two)
        let cardOneMatchB = SetCard(featureOne: .one, featureTwo: .one, featureThree: .one, featureFour: .three)

        let cardArray = [cardOne, cardTwo, cardThree, cardOneMatchA, cardOneMatchB]
        let expectedResult = [[cardOne, cardOneMatchA, cardOneMatchB], [cardOne, cardTwo, cardThree]]
        
        let doesContain = testSet.checkWhereAreMatchedSets(in: cardArray)?.containsFullSet(expectedResult)?.allSatisfy { $0 }
        
        XCTAssertTrue(doesContain!)
    }
    
    func testChangingCheatMatchedCardsToTrueAndThenToFalse() {

        testSetNotShuffled.dealCards(numberOfCards: 12)
        testSetNotShuffled.turnAllCardsFaceUp()
        testSetNotShuffled.cheatMatchingCardsChangedToIsCheatedTrue()

        var isCheatedCardCount = testSetNotShuffled.isFaceUpCards.filter { $0.isCheated }.count
        XCTAssertEqual(isCheatedCardCount, 12)
        
        testSetNotShuffled.changeAllCardsToIsCheatedFalse()
        isCheatedCardCount = testSetNotShuffled.isFaceUpCards.filter { $0.isCheated }.count
        XCTAssertEqual(isCheatedCardCount, 0)

    }
}
