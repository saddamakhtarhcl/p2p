//
//  UserInfoProviderTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class UserInfoProviderTest: XCTestCase {
    var user: Users!
    override func setUp() {
        super.setUp()
        user = Users.instanceFromFile("users") as? Users
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        user = nil
        super.tearDown()
    }
    
    func testExample() {
        user = Users.instanceFromDictionary(user.dictionaryRepresentation()) as? Users
        
        XCTAssertNotNil(user)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
