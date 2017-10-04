//
//  EquatableTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 22/09/17.
//
//

import XCTest
@testable import VJson

class EquatableTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test() {

        var json = VJson(1)
        
        var comp = VJson(2)
        
        XCTAssertTrue(json == json)
        XCTAssertFalse(json == comp)
        
        comp &= 1
        XCTAssertTrue(json == comp)
        
        comp &= 1.0
        XCTAssertTrue(json == comp)

        comp = VJson(1, name: "test")
        XCTAssertFalse(json == comp)

        comp = VJson("test")
        XCTAssertFalse(json == comp)
        
        comp = VJson(true)
        XCTAssertFalse(json == comp)
        
        comp = VJson.array()
        XCTAssertFalse(json == comp)
        
        json = VJson([VJson(1), VJson(false), VJson.null("test")])
        comp = VJson([VJson(1), VJson(false), VJson.null("test")])
        XCTAssertTrue(json == comp)
        
        comp = VJson([VJson(1), VJson(false), VJson.null("Test")])
        XCTAssertFalse(json == comp)
    }
}
