//
//  BackgroundViewViewTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class BackgroundViewViewTest: XCTestCase {
    var backGroundViewObj: SpiralView?
    override func setUp() {
        super.setUp()
        //backGroundViewObj = BackgroundViewView(coder: <#NSCoder#>)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        backGroundViewObj = nil
        super.tearDown()
    }
    
    func testBackGroundView() {
        // backGroundViewObj.drawLevelLayers()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
