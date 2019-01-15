//
//  SplitBillsTests.swift
//  SplitBillsTests
//
//  Created by Anthony Tse on 1/12/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import XCTest
@testable import SplitBills

class SplitBillsTests: XCTestCase {

//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    //MARK: Bill Class Tests
    func testBillInitializationSucceeds() {
        let test1 = Bill.init(amount: "12.73", name: "Anthony", date: "01/13/2019", description: "Pizza")
        XCTAssertNotNil(test1)
        
        let test2 = Bill.init(amount: "49.83", name: "Ram", date: "12/13/2018", description: "Electric Bill")
        XCTAssertNotNil(test2)
        let test3 = Bill.init(amount: "18.94", name: "Trisha", date: "12/13/2014", description: "Uber")
        XCTAssertNotNil(test3)
    }
}
