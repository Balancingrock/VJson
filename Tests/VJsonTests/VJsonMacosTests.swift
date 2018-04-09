//
//  VJsonMacosTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 21/09/17.
//
//

import XCTest
@testable import VJson

class VJsonMacosTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit() {

        var json = VJson(type: .null)
        
        XCTAssertTrue(json.type == .null)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children == nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)
        
        
        json = VJson(type: .null, name: "test")
        
        XCTAssertTrue(json.type == .null)
        XCTAssertTrue(json.name == "test")
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children == nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)

        
        json = VJson(type: .bool)
        
        XCTAssertTrue(json.type == .bool)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children == nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)

        
        json = VJson(type: .number)
        
        XCTAssertTrue(json.type == .number)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children == nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)

        
        json = VJson(type: .string)
        
        XCTAssertTrue(json.type == .string)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children == nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)

        
        json = VJson(type: .array)
        
        XCTAssertTrue(json.type == .array)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children != nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)

        
        json = VJson(type: .object)
        
        XCTAssertTrue(json.type == .object)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children != nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)

        
        json = VJson()
        
        XCTAssertTrue(json.type == .object)
        XCTAssertTrue(json.name == nil)
        XCTAssertTrue(json.bool == nil)
        XCTAssertTrue(json.string == nil)
        XCTAssertTrue(json.number == nil)
        XCTAssertTrue(json.children != nil)
        XCTAssertTrue(json.parent == nil)
        XCTAssertTrue(json.createdBySubscript == false)
    }
}
