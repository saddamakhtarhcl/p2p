//
//  RadarAnimationLayerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class RadarAnimationLayerTest: XCTestCase {
    var radarLayer: RadarAnimationLayer!
    override func setUp() {
        super.setUp()
        radarLayer = RadarAnimationLayer(color: UIColor(colorCode:"FFFFFF"))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        radarLayer = nil
        super.tearDown()
    }
    
    func testExample() {
        radarLayer.animationDuration = 0.2
        radarLayer.fillAlpha = 0.1
        radarLayer.color = UIColor.red
        radarLayer.animate(startPoint: CGPoint(x: 0.0, y: 0.0),
                           diameter: 100.0 + 80.0,
                           parentLayer: CALayer())
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
