//
//  DuplicateTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 22/09/17.
//
//

import XCTest
@testable import VJson


class DuplicateTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInt() {

        let json = VJson(1)
        
        let dup = json.duplicate
        
        XCTAssertTrue(dup.type == .number)
        XCTAssertTrue(dup.name == nil)
        XCTAssertTrue(dup.bool == nil)
        XCTAssertTrue(dup.string == nil)
        XCTAssertTrue(dup.number != nil)
        XCTAssertTrue(dup.children == nil)
        XCTAssertTrue(dup.parent == nil)
        XCTAssertTrue(dup.createdBySubscript == false)
        XCTAssertTrue(dup.intValue! == 1)
    }
    
    func testBool() {
        
        let json = VJson(true)
        
        let dup = json.duplicate
        
        XCTAssertTrue(dup.type == .bool)
        XCTAssertTrue(dup.name == nil)
        XCTAssertTrue(dup.bool != nil)
        XCTAssertTrue(dup.string == nil)
        XCTAssertTrue(dup.number == nil)
        XCTAssertTrue(dup.children == nil)
        XCTAssertTrue(dup.parent == nil)
        XCTAssertTrue(dup.createdBySubscript == false)
        XCTAssertTrue(dup.boolValue!)
    }

    func testString() {
        
        let json = VJson("test")
        
        let dup = json.duplicate
        
        XCTAssertTrue(dup.type == .string)
        XCTAssertTrue(dup.name == nil)
        XCTAssertTrue(dup.bool == nil)
        XCTAssertTrue(dup.string != nil)
        XCTAssertTrue(dup.number == nil)
        XCTAssertTrue(dup.children == nil)
        XCTAssertTrue(dup.parent == nil)
        XCTAssertTrue(dup.createdBySubscript == false)
        XCTAssertTrue(dup.stringValue! == "test")
    }

    func testNull() {
        
        let json = VJson.null("name")
        
        let dup = json.duplicate
        
        XCTAssertTrue(dup.type == .null)
        XCTAssertTrue(dup.nameValue == "name")
        XCTAssertTrue(dup.bool == nil)
        XCTAssertTrue(dup.string == nil)
        XCTAssertTrue(dup.number == nil)
        XCTAssertTrue(dup.children == nil)
        XCTAssertTrue(dup.parent == nil)
        XCTAssertTrue(dup.createdBySubscript == false)
    }

    func testArray() {
        
        let json = VJson([VJson(1), VJson(true), VJson("test")], name: "name")
        json.append(VJson([VJson("sub1"), VJson("sub2")]))
        
        let dup = json.duplicate
        
        XCTAssertFalse(dup === json)
        
        XCTAssertTrue(dup.type == .array)
        XCTAssertTrue(dup.nameValue == "name")
        XCTAssertTrue(dup.bool == nil)
        XCTAssertTrue(dup.string == nil)
        XCTAssertTrue(dup.number == nil)
        XCTAssertTrue(dup.children != nil)
        XCTAssertTrue(dup.parent == nil)
        XCTAssertTrue(dup.createdBySubscript == false)
        XCTAssertTrue(dup.children!.count == 4)
        
        let first = json[0]
        XCTAssertTrue(first.type == .number)
        XCTAssertTrue(first.name == nil)
        XCTAssertTrue(first.bool == nil)
        XCTAssertTrue(first.string == nil)
        XCTAssertTrue(first.number != nil)
        XCTAssertTrue(first.children == nil)
        XCTAssertTrue(first.parent === json)
        XCTAssertTrue(first.createdBySubscript == false)
        XCTAssertTrue(first.intValue == 1)
        
        let second = json[1]
        XCTAssertTrue(second.type == .bool)
        XCTAssertTrue(second.name == nil)
        XCTAssertTrue(second.bool != nil)
        XCTAssertTrue(second.string == nil)
        XCTAssertTrue(second.number == nil)
        XCTAssertTrue(second.children == nil)
        XCTAssertTrue(second.parent === json)
        XCTAssertTrue(second.createdBySubscript == false)
        XCTAssertTrue(second.boolValue == true)

        let third = json[2]
        XCTAssertTrue(third.type == .string)
        XCTAssertTrue(third.name == nil)
        XCTAssertTrue(third.bool == nil)
        XCTAssertTrue(third.string != nil)
        XCTAssertTrue(third.number == nil)
        XCTAssertTrue(third.children == nil)
        XCTAssertTrue(third.parent === json)
        XCTAssertTrue(third.createdBySubscript == false)
        XCTAssertTrue(third.stringValue == "test")

        let fourth = json[3]
        XCTAssertTrue(fourth.type == .array)
        XCTAssertTrue(fourth.name == nil)
        XCTAssertTrue(fourth.bool == nil)
        XCTAssertTrue(fourth.string == nil)
        XCTAssertTrue(fourth.number == nil)
        XCTAssertTrue(fourth.children != nil)
        XCTAssertTrue(fourth.parent === json)
        XCTAssertTrue(fourth.createdBySubscript == false)
        XCTAssertTrue(fourth.children!.count == 2)

        let sub1 = fourth[0]
        XCTAssertTrue(sub1.type == .string)
        XCTAssertTrue(sub1.name == nil)
        XCTAssertTrue(sub1.bool == nil)
        XCTAssertTrue(sub1.string != nil)
        XCTAssertTrue(sub1.number == nil)
        XCTAssertTrue(sub1.children == nil)
        XCTAssertTrue(sub1.parent === fourth)
        XCTAssertTrue(sub1.createdBySubscript == false)
        XCTAssertTrue(sub1.stringValue == "sub1")
        
        let sub2 = fourth[1]
        XCTAssertTrue(sub2.type == .string)
        XCTAssertTrue(sub2.name == nil)
        XCTAssertTrue(sub2.bool == nil)
        XCTAssertTrue(sub2.string != nil)
        XCTAssertTrue(sub2.number == nil)
        XCTAssertTrue(sub2.children == nil)
        XCTAssertTrue(sub2.parent === fourth)
        XCTAssertTrue(sub2.createdBySubscript == false)
        XCTAssertTrue(sub2.stringValue == "sub2")
    }

}
