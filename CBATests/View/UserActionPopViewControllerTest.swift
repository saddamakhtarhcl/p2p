//
//  UserActionPopViewControllerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class UserActionPopViewControllerTest: XCTestCase {
    var userActionPopObj: UserActionPopViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userActionPopObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserActionPopViewController") as? UserActionPopViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userActionPopObj = nil
        super.tearDown()
    }
    
    func testUserActionPopViewController() {
        userActionPopObj.viewDidLoad()
        userActionPopObj.createStackView()
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        userActionPopObj.changeSelection(recognizer)
        
        userActionPopObj.didReceiveMemoryWarning()
        
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
