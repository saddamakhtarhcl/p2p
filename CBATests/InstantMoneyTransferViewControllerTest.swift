//
//  InstantMoneyTransferViewControllerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class InstantMoneyTransferViewControllerTest: XCTestCase {
    var instantMoneyObj: InstantMoneyTransferViewController!
    override func setUp() {
        super.setUp()
        instantMoneyObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstantMoneyTransferViewController") as? InstantMoneyTransferViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        instantMoneyObj = nil
        super.tearDown()
    }
    
    func testInstantMoneyTransfer() {
        instantMoneyObj.viewDidLoad()
        instantMoneyObj.didReceiveMemoryWarning()
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
