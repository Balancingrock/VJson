//
//  BoolTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 29/09/17.
//
//

import XCTest
import VJson

class BoolTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Testing: public var isBool: Bool {...}
    
    func testIsBool() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isBool)
        
        let b = VJson(true)
        XCTAssertTrue(b.isBool)
        
        let i = VJson(0)
        XCTAssertFalse(i.isBool)
        
        let s = VJson("think")
        XCTAssertFalse(s.isBool)
        
        let o = VJson.object()
        XCTAssertFalse(o.isBool)
        
        let a = VJson.array()
        XCTAssertFalse(a.isBool)
    }

    
    // Testing: public var asBool: Bool {...}
    
    func testAsBool() {
        
        let n = VJson.null()
        XCTAssertFalse(n.asBool)
        
        var b = VJson(true)
        XCTAssertTrue(b.asBool)
        
        b = VJson(false)
        XCTAssertFalse(b.asBool)

        var i = VJson(0)
        XCTAssertFalse(i.asBool)
        
        i = VJson(1)
        XCTAssertTrue(i.asBool)

        i = VJson(2)
        XCTAssertTrue(i.asBool)

        var s = VJson("think")
        XCTAssertFalse(s.asBool)

        s = VJson("false")
        XCTAssertFalse(s.asBool)

        s = VJson("true")
        XCTAssertTrue(s.asBool)

        let o = VJson.object()
        XCTAssertFalse(o.asBool)
        
        let a = VJson.array()
        XCTAssertFalse(a.asBool)
    }

    
    // Testing: boolValue
    
    func testBoolValue() {
        
        // Creation without name, without value
        var b: Bool?
        var json = VJson(b)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertNil(json.boolValue)
        
        // Creation with name, without value
        json = VJson(b, name: "aName")
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertNil(json.boolValue)
        
        // Creation without name, with value
        b = true
        json = VJson(b)
        XCTAssertTrue(json.isBool)
        XCTAssertTrue(json.asBool)
        XCTAssertTrue(json.boolValue!)
        
        // Creation with name, with value
        b = false
        json = VJson(b, name: "aName")
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertFalse(json.boolValue!)
        
        // Check type interpretation for NULL
        json = VJson.null()
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.asBool)
        
        // Check type interpretation for NUMBER 0
        json = VJson(0)
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.asBool)
        
        // Check type interpretation for NUMBER 1
        json = VJson(1)
        XCTAssertFalse(json.isBool)
        XCTAssertTrue(json.asBool)
        
        // Check type interpretation for NUMBER 222 (i.e. non-zero)
        json = VJson(222)
        XCTAssertFalse(json.isBool)
        XCTAssertTrue(json.asBool)
        
        // Check type interpretation for string "anything"
        json = VJson("anything")
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.asBool)
        
        // Check type interpretation for string "true"
        json = VJson("true")
        XCTAssertFalse(json.isBool)
        XCTAssertTrue(json.asBool)
        
        // Check type interpretation for object
        json = VJson.object()
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.asBool)
        
        // Check type interpretation for array
        json = VJson.array()
        XCTAssertFalse(json.isBool)
        XCTAssertFalse(json.asBool)
        
        // Convert from NULL
        json = VJson.null()
        json &= true
        XCTAssertTrue(json.isBool)
        XCTAssertTrue(json.asBool)
        XCTAssertFalse(json.isNull)
        XCTAssertTrue(json.boolValue!)
        
        // Do no longer raise fatal errors
        VJson.fatalErrorOnTypeConversion = false // Change manually to check if this works as expected
        
        // Convert from NUMBER
        json = VJson(2)
        json &= false
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertFalse(json.isNumber)
        XCTAssertFalse(json.boolValue!)
        XCTAssertNil(json.intValue)
        
        // Convert from STRING
        json = VJson("true")
        json &= false
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertFalse(json.isNumber)
        XCTAssertFalse(json.boolValue!)
        XCTAssertNil(json.stringValue)
        
        // Convert from OBJECT
        json = VJson.object()
        json &= false
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.boolValue!)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Convert from ARRAY
        json = VJson.array()
        json &= false
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertFalse(json.isArray)
        XCTAssertFalse(json.boolValue!)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test undo/redo
        VJson.undoManager = UndoManager()
        json = VJson(true)
        XCTAssertTrue(json.boolValue!)
        json.boolValue = false
        XCTAssertFalse(json.boolValue!)
        VJson.undoManager!.undo()
        XCTAssertTrue(json.boolValue!)
        VJson.undoManager!.redo()
        XCTAssertFalse(json.boolValue!)
    }

}
