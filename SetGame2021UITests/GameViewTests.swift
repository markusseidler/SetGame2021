//
//  SetGame2021UITests.swift
//  SetGame2021UITests
//
//  Created by Markus Seidler on 14/1/21.
//

import XCTest
@testable import SetGame2021

//https://medium.com/twinkl-educational-publishers/accessible-swiftui-for-easy-ui-testing-f2e7b8824b39
//https://www.vadimbulavin.com/snapshot-testing-swiftui-views/
//https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet

// TODO: - How to test views appearing on screen? views which are not buttons or texts?
// TODO: - work on game flow logic... three selected -> check match -> unselect... or fly away
`

class GameViewTests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.app = XCUIApplication()
        app.launch()
        sleep(5)
        
        continueAfterFailure = false
        

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
      
    }

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func testNewGameWithFirstDeal() {
        let newGameButton = app.buttons["newGameButton"]
        let firstDealButton = app.buttons["firstDealButton"]
        
        XCTAssertTrue(newGameButton.exists)
        XCTAssertTrue(firstDealButton.exists)
        
        newGameButton.tap()
        firstDealButton.tap()
        
        
        
        sleep(8)
        
//        XCTAssertTrue(app.staticTexts["singleCardView"].exists)

        
    }
    
    
}
