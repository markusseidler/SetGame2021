//
//  ViewModelGridLayoutTsts.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 30/1/21.
//

import XCTest
@testable import SetGame2021

class ViewModelGridLayoutTsts: XCTestCase {
    
    var gridConstructor: GridConstructor?
    var gridConstructorZeroWidth: GridConstructor?
    var gridConstructorZeroHeight: GridConstructor?

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        
        let itemCount = 12
        let geoSize = CGSize(width: 400, height: 800)
        gridConstructor = GridConstructor(itemCount: itemCount, geoSize: geoSize)
        
        gridConstructorZeroWidth = GridConstructor(itemCount: 10, geoSize: CGSize(width: 0, height: 800))
        gridConstructorZeroHeight = GridConstructor(itemCount: 10, geoSize: CGSize(width: 400, height: 0))
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        gridConstructor = nil
        
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
        XCTAssertTrue(gridConstructor != nil)
    }
    
    func testGetRowAndColumnCountWithItemCountZero() {
        let newGridConstructor = GridConstructor(itemCount: 0, geoSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(newGridConstructor.rowCount, 0)
        XCTAssertEqual(newGridConstructor.columnCount, 0)
    }
    
    func testGetRowAndColumnCountWithWidthZero() {
        let newGridConstructor = GridConstructor(itemCount: 10, geoSize: CGSize(width: 0, height: 100))
        XCTAssertEqual(newGridConstructor.rowCount, 0)
        XCTAssertEqual(newGridConstructor.columnCount, 0)
        
    }
    
    func testGetRowAndColumnCountWithHeightZero() {
        let newGridConstructor = GridConstructor(itemCount: 10, geoSize: CGSize(width: 100, height: 0))
        XCTAssertEqual(newGridConstructor.rowCount, 0)
        XCTAssertEqual(newGridConstructor.columnCount, 0)
    }
    
    func testSizeAspectRatio() {
        let expectedResult: Double = 0.5
        XCTAssertEqual(gridConstructor!.geoSizeAspectRatio, expectedResult)
    }
    
    func testGetRowAndColumnCountWithRegularInstance() {
        XCTAssertEqual(gridConstructor!.rowCount, 3)
        XCTAssertEqual(gridConstructor!.columnCount, 4)
    }
    
    func testGetItemSizeWithRegularInstance() {
        XCTAssertEqual(gridConstructor!.itemSize, CGSize(width: 100.0, height: 800.0 / 3.0))
    }
    
    func testGetItemSizeWithZeroWidthOrZeroHeight() {
        
        XCTAssertEqual(gridConstructorZeroWidth!.itemSize, CGSize.zero)
        XCTAssertEqual(gridConstructorZeroHeight!.itemSize, CGSize.zero)
    }
    
    func testLocationOfItemWithZeroWidthOrZeroHeight() {
        XCTAssertEqual(gridConstructorZeroWidth!.location(at: 3), CGPoint.zero)
        XCTAssertEqual(gridConstructorZeroHeight!.location(at: 3), CGPoint.zero)
    }
    
    func testLocationOfItemWithRegularInstance() {
        XCTAssertEqual(gridConstructor!.location(at: 9), CGPoint(x: 150, y: (800 / 3.0) * 2.5))
    }
    
    
    
    
    
}
