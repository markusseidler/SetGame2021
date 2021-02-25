//
//  ViewModelLogicTests.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 20/2/21.
//

import XCTest
import SwiftUI
@testable import SetGame2021

class ViewModelLogicTests: XCTestCase {
    
    var game: SetGame!

    override func setUpWithError() throws {
        
        game = SetGame()
        
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
    
    func testDealCardsWithNoDealtViewCards() {
        
        let newLocalGame = SetGame()
        let countOfFaceUpCards = newLocalGame.isDealtViewCards.count
        newLocalGame.dealCards()
        let countOfNewFaceUpCards = newLocalGame.isDealtViewCards.count
        
        XCTAssertEqual(countOfFaceUpCards, 0)
        XCTAssertEqual(countOfNewFaceUpCards, 12)
        
    }
    
    func testDealCardsWithDealtViewCards() {
        
        let newLocalGame = SetGame()
        let countOfFaceUpCards = newLocalGame.isDealtViewCards.count
        newLocalGame.dealCards()
        newLocalGame.dealCards()
        let countOfNewFaceUpCards = newLocalGame.isDealtViewCards.count
        
        XCTAssertEqual(countOfFaceUpCards, 0)
        XCTAssertEqual(countOfNewFaceUpCards, 15)
    }
    
    func testDealCardsWithNoCardsDisplayed() {
        
        game.newGame()
        let countOfFaceUpCards = game.isFaceUpViewCards.count
        game.dealAndDisplayCards()
        let countOfNewFaceUpCards = game.isFaceUpViewCards.count
        
        XCTAssertEqual(countOfFaceUpCards, 0)
        XCTAssertEqual(countOfNewFaceUpCards, 12)
        
    }
    
    func testDealCardsWithAlreadyCardsDisplayed() {
       
        game.newGame()
        let countOfFaceUpCards = game.isFaceUpViewCards.count
        game.dealAndDisplayCards()
        game.dealAndDisplayCards()
        let countOfNewFaceUpCards = game.isFaceUpViewCards.count
        
        XCTAssertEqual(countOfFaceUpCards, 0)
        XCTAssertEqual(countOfNewFaceUpCards, 15)
        
    }
    
    func testAddingFivePointsToScore() {
        game.newGame()
        game.addToScore(5)
        XCTAssertEqual(game.totalScore, 5)
    }
    
    func testAddingFivePointsToScoreTwice() {
        game.newGame()
        game.addToScore(5)
        game.addToScore(5)
        XCTAssertEqual(game.totalScore, 10)
    }
    
    func testDeductingFivePointsToScore() {
        game.newGame()
        game.deductFromScore(5)
        XCTAssertEqual(game.totalScore, 0)
    }
    
    func testAddingFivePointsAndDeductTwiceFivePoints() {
        game.newGame()
        game.addToScore(5)
        game.deductFromScore(5)
        game.deductFromScore(5)
        XCTAssertEqual(game.totalScore, 0)
    }
    
    func testAddingFivePointsTwiceAndDeductFivePoints() {
        game.newGame()
        game.addToScore(5)
        game.addToScore(5)
        game.deductFromScore(5)
        XCTAssertEqual(game.totalScore, 5)
    }
    
    func testScoreDecayOfCurrentRound() {
//        https://stackoverflow.com/questions/59321364/swift-unit-testing-a-method-that-includes-timer
        
        XCTAssertEqual(game.currentRoundScore, 10)
        game.startScoreDecay()
       
        let expectation = self.expectation(description: "score is 0")
        DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 12)
        
        XCTAssertEqual(game.currentRoundScore, 0)
    }

}
