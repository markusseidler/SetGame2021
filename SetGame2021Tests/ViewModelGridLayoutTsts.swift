//
//  ViewModelGridLayoutTsts.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 30/1/21.
//

import XCTest
@testable import SetGame2021

class ViewModelGridLayoutTsts: XCTestCase {
    
    var gridLayout: GridConstructor?

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        
        let itemCount = 12
        let geoSize = CGSize(width: 400, height: 800)
        gridLayout = GridConstructor(itemCount: itemCount, geoSize: geoSize)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        gridLayout = nil
        
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
    
    func testStructInitiation() {
        XCTAssertTrue(gridLayout != nil)
    }
    
    func testGetRowAndColumnCountWithItemCountZero() {
        let newGridLayout = GridConstructor(itemCount: 0, geoSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(newGridLayout.rowCount, 0)
        XCTAssertEqual(newGridLayout.columnCount, 0)
    }
    
    func testGetRowAndColumnCountWithWidthZero() {
        let newGridLayout = GridConstructor(itemCount: 10, geoSize: CGSize(width: 0, height: 100))
        XCTAssertEqual(newGridLayout.rowCount, 0)
        XCTAssertEqual(newGridLayout.columnCount, 0)
        
    }
    
    func testGetRowAndColumnCountWithHeightZero() {
        let newGridLayout = GridConstructor(itemCount: 10, geoSize: CGSize(width: 100, height: 0))
        XCTAssertEqual(newGridLayout.rowCount, 0)
        XCTAssertEqual(newGridLayout.columnCount, 0)
    }
    
    func testSizeAspectRatio() {
        let expectedResult: Double = 0.5
        XCTAssertEqual(gridLayout!.geoSizeAspectRatio, expectedResult)
    }
    
    func testGetRowAndColumnCountWithRegularInstance() {
        XCTAssertEqual(gridLayout!.rowCount, 3)
        XCTAssertEqual(gridLayout!.columnCount, 4)
    }
    
    
    
    
    
}
