//
//  AddBeneficiaryViewControllerTest.swift
//  CBATests
//
//  Created by Nandhakumar on 21/02/18.
//  Copyright © 2018 HCL. All rights reserved.
//

import XCTest
@testable import CBA
class AddBeneficiaryViewControllerTest: XCTestCase {
    var beneficiaryObj: AddBeneficiaryViewController!
    override func setUp() {
        super.setUp()
        beneficiaryObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddBeneficiaryViewController") as? AddBeneficiaryViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        beneficiaryObj = nil
        super.tearDown()
    }
    
    func testAddBeneficiary() {
        beneficiaryObj.viewDidLoad()
        beneficiaryObj.didReceiveMemoryWarning()
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
