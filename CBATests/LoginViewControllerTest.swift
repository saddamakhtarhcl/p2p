//
//  LoginViewControllerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class LoginViewControllerTest: XCTestCase {
    var loginControllerObj: LoginViewController!
    override func setUp() {
        super.setUp()
        loginControllerObj = LoginViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginControllerObj = nil
        super.tearDown()
    }
    
    func testLoginControllerExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //loginControllerObj.txtClientNumber.text = "700701"
        loginControllerObj.viewDidLoad()
        loginControllerObj.loginBtnTapped(UIButton())
        loginControllerObj.txtClientNumber?.text = "700701"
        loginControllerObj.loginBtnTapped(UIButton())
        loginControllerObj.didReceiveMemoryWarning()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
