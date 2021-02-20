//
//  ViewModelGridLayoutTsts.swift
//  SetGame2021Tests
//
//  Created by Markus Seidler on 30/1/21.
//

import XCTest
@testable import SetGame2021

class ViewModelGridLayoutTests: XCTestCase {
    
    var gridConstructor: GridConstructor?
    var gridConstructorZeroWidth: GridConstructor?
    var gridConstructorZeroHeight: GridConstructor?
    var aspectRatio: CGFloat = 0

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        
        let itemCount = 12
        let geoSize = CGSize(width: 400, height: 800)
        aspectRatio = geoSize.width / geoSize.height
        gridConstructor = GridConstructor(itemCount: itemCount, geoSize: geoSize, globalAspectRatio: aspectRatio)
        
        gridConstructorZeroWidth = GridConstructor(itemCount: 10, geoSize: CGSize(width: 0, height: 800), globalAspectRatio: aspectRatio)
        gridConstructorZeroHeight = GridConstructor(itemCount: 10, geoSize: CGSize(width: 400, height: 0), globalAspectRatio: aspectRatio)
        
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
        
        let newGridConstructor = GridConstructor(itemCount: 0, geoSize: CGSize(width: 100, height: 100), globalAspectRatio: aspectRatio)
        XCTAssertEqual(newGridConstructor.rowCount, 0)
        XCTAssertEqual(newGridConstructor.columnCount, 0)
    }
    
    func testGetRowAndColumnCountWithWidthZero() {
        let newGridConstructor = GridConstructor(itemCount: 10, geoSize: CGSize(width: 0, height: 100), globalAspectRatio: aspectRatio)
        XCTAssertEqual(newGridConstructor.rowCount, 0)
        XCTAssertEqual(newGridConstructor.columnCount, 0)
        
    }
    
    func testGetRowAndColumnCountWithHeightZero() {
        let newGridConstructor = GridConstructor(itemCount: 10, geoSize: CGSize(width: 100, height: 0), globalAspectRatio: aspectRatio)
        XCTAssertEqual(newGridConstructor.rowCount, 0)
        XCTAssertEqual(newGridConstructor.columnCount, 0)
    }
    
    func testSizeAspectRatio() {
        let expectedResult: Double = 0.5
        XCTAssertEqual(gridConstructor!.geoSizeAspectRatio, expectedResult)
    }
    
    func testGetRowAndColumnCountWithRegularInstance() {
        XCTAssertEqual(gridConstructor!.rowCount, 4)
        XCTAssertEqual(gridConstructor!.columnCount, 3)
    }
    
    func testGetItemSizeWithRegularInstance() {
        XCTAssertEqual(gridConstructor!.itemSize, CGSize(width: 100.0, height: 200))
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
        XCTAssertEqual(gridConstructor!.location(at: 9), CGPoint(x: 90, y: 720))
    }
    
    
    
    
    
}
