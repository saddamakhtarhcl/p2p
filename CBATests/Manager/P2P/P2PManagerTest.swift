//
//  P2PManagerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class P2PManagerTest: XCTestCase {
    var p2pManagerObj: P2PManager!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        p2pManagerObj = P2PManager(withName: "Unit Test")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        p2pManagerObj = nil
        super.tearDown()
    }
    
    func testBroadcast() {
        let bleExpectation = expectation(description: "BLE-Broadcast")
        let bleStopExpectation = expectation(description: "BLE-StopBroadcast")
        p2pManagerObj.startBroadcast { (isStartedBroadcasting, error) in
            if self.p2pManagerObj.isBroadcasting == true {
                bleExpectation.fulfill()
                
                self.p2pManagerObj.stopBroadcast()
                if self.p2pManagerObj.isBroadcasting == false {
                    bleStopExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            //
        }
        
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testScan() {
        
        let bleExpectation = expectation(description: "BLE-Scan")
        let bleStopExpectation = expectation(description: "BLE-StopScan")
        
        p2pManagerObj.scan(callBack: { (isStartedScaning) in
            if self.p2pManagerObj.isScanning == true {
                bleExpectation.fulfill()
                
                self.p2pManagerObj.stopScan()
                if self.p2pManagerObj.isScanning == false {
                    bleStopExpectation.fulfill()
                }
            }
        }) { (peerId) in
            //XCTAssertNotNil(peerId)
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            //
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
