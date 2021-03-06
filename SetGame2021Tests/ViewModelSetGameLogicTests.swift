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
    var gameNotShuffled: SetGame!

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        
        game = SetGame()
        gameNotShuffled = SetGame(shuffleCards: false)
        
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
        game.addToTotalScore(5)
        XCTAssertEqual(game.totalScore, 5)
    }
    
    func testAddingFivePointsToScoreTwice() {
        game.newGame()
        game.addToTotalScore(5)
        game.addToTotalScore(5)
        XCTAssertEqual(game.totalScore, 10)
    }
    
    func testDeductingFivePointsToScore() {
        game.newGame()
        game.deductFromTotalScore(5)
        XCTAssertEqual(game.totalScore, 0)
    }
    
    func testAddingFivePointsAndDeductTwiceFivePoints() {
        game.newGame()
        game.addToTotalScore(5)
        game.deductFromTotalScore(5)
        game.deductFromTotalScore(5)
        XCTAssertEqual(game.totalScore, 0)
    }
    
    func testAddingFivePointsTwiceAndDeductFivePoints() {
        game.newGame()
        game.addToTotalScore(5)
        game.addToTotalScore(5)
        game.deductFromTotalScore(5)
        XCTAssertEqual(game.totalScore, 5)
    }
    
    func testScoreDecayOfCurrentRound() {
//        https://stackoverflow.com/questions/59321364/swift-unit-testing-a-method-that-includes-timer
        
        XCTAssertEqual(game.currentRoundScore, 100)
        game.startScoreDecay()
       
        let expectation = self.expectation(description: "score is 90")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 11)
        
        XCTAssertEqual(game.currentRoundScore, 90)
    }
    
    func testScoreDecayStop() {
        
        XCTAssertEqual(game.currentRoundScore, 100)
        game.startScoreDecay()
        
        let expectation = self.expectation(description: "score is 97")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.game.stopScoreDecay()
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4)
        
        XCTAssertEqual(game.currentRoundScore, 97)
        
    }
    
    func testCheckHowManySetsAreAvailable() {
        XCTAssertEqual(game.countOfAvailableSetsInUsedCards,1080)
    }
    
    func testCheckHowManySetsAreAvailableWithChanges() {
        
        for index in 0..<20 {
            let card = gameNotShuffled.allViewCards[index]
            gameNotShuffled.chooseCard(card)
            
            if index % 3 == 2 {
                gameNotShuffled.checkIfMatch {} positiveActionTwo: {} positiveActionThree: {} negativeAction: {}
            }
        }
        XCTAssertEqual(gameNotShuffled.countOfAvailableSetsInUsedCards, 489)
    }
    
    func testCheatOnOff() {
        
        gameNotShuffled.dealCards()
        gameNotShuffled.dealAndDisplayCards()
        
        XCTAssertEqual(gameNotShuffled.countOfAvailableSetsDisplayed, 0)
        XCTAssertEqual(gameNotShuffled.isFaceUpViewCards.count, 12)
        XCTAssertEqual(gameNotShuffled.isFaceUpViewCards.filter { $0.isCheated }.count, 0)
    
        gameNotShuffled.cheatOn()
        
        XCTAssertEqual(gameNotShuffled.isFaceUpViewCards.count, 12)
        XCTAssertEqual(gameNotShuffled.countOfAvailableSetsDisplayed, 13)
        XCTAssertEqual(gameNotShuffled.isFaceUpViewCards.map { $0.isCheated }.count, 12)
        
        gameNotShuffled.cheatOff()
        
        XCTAssertEqual(gameNotShuffled.isFaceUpViewCards.count, 12)
        XCTAssertEqual(gameNotShuffled.countOfAvailableSetsDisplayed, 13)
        XCTAssertEqual(gameNotShuffled.isFaceUpViewCards.map { $0.isCheated }.count, 12)
    }
}
