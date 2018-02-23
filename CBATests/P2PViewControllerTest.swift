//
//  P2PViewControllerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class P2PViewControllerTest: XCTestCase {
    var p2pControllerObj: P2PViewController?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        App.user = UserInfo()
        App.user.userToken = "700701"
        
        p2pControllerObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "P2PViewController") as? P2PViewController
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        p2pControllerObj = nil
        super.tearDown()
    }
    
    func testP2PControllerExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        p2pControllerObj?.viewDidLoad()
        //p2pControllerObj?.viewWillLayoutSubviews()
        p2pControllerObj?.didReceiveMemoryWarning()
        
        //        let switchObj = UISwitch()
        //        switchObj.isOn = true
        //        p2pControllerObj?.switchValueChange(switchObj)
        //        switchObj.isOn = false
        //        p2pControllerObj?.switchValueChange(switchObj)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
