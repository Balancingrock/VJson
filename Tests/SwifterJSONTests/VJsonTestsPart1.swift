//
//  VJsonTests.swift
//  VJsonTests
//
//  Created by Marinus van der Lugt on 06/05/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

// Note: These test have been developped while inspecting the source code. I.e. white box testing. Goal has been to test all possible conditions such that a high percentage of code coverage is achieved. However some explicit tests have been omitted if the part to test is already tested excessively in other test cases.

import XCTest
@testable import SwifterJSON


class VJsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
    
        let top = VJson() // Create JSON hierarchy
        top["books"][0]["title"] &= "THHGTTG"
        let jsonCode = top.description
        
        do {
            let json = try VJson.parse(string: jsonCode)
            if let title = (json|"books"|0|"title")?.stringValue {
                XCTAssertEqual(title, "THHGTTG")
            } else {
                XCTFail("The title of the first book in the JSON code was not found")
            }
        } catch {
            XCTFail("Parser failed: \(error)")
        }
    }
    
    
    // Testing: public func | (lhs: VJson?, rhs: String?) -> VJson? {...}
    
    func testPipeVJsonString() {
        
        // Execute the string pipe operator on a VJson optional that is nil
        var json: VJson?
        XCTAssertNil(json|"top")
        
        // Execute the string pipe operator with a String optional that is nil
        json = VJson()
        json!["top"] &= 13
        var path: String?
        XCTAssertNil(json|path)
        
        // Execute the string pipe operator with a no-match path
        path = "bottom"
        XCTAssertNil(json|path)
        
        // Execute the string pipe operator with a single matched path
        json!["bottom"] &= 26
        XCTAssertEqual((json|"top")!.intValue!, 13)
        
        // Execute the string pipe operator with a multiple matched path
        json!.add(VJson(17), forName: "top", replace: false)
        XCTAssertEqual((json|"top")!.intValue!, 13)
    }
    
    
    // Testing: public func | (lhs: VJson?, rhs: Int?) -> VJson? {...}
    
    func testPipeVJsonInt() {
        
        // Execute the string pipe operator on a VJson optional that is nil
        var json: VJson?
        XCTAssertNil(json|"top")
        
        // Execute the string pipe operator with an Int optional that is nil
        json = VJson.array()
        json![1] &= 13
        var index: Int?
        XCTAssertNil(json|index)
        
        // Execute the string pipe operator with a no-match path
        index = 2
        XCTAssertNil(json|index)
        
        // Execute the string pipe operator with a matched path
        json![2] &= 26
        XCTAssertEqual((json|1)!.intValue!, 13)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Bool?) {...}
    
    func testAssignJsonBool() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Bool? = true
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.boolValue)
        
        // Execute the assignment with a non-nil argument
        i = false
        json &= i
        XCTAssertEqual(json!.boolValue!, false)
    }
    
    
    // Testing: public func &= (lhs: Bool?, rhs: VJson?) {...}
    
    func testAssignBoolJson() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Bool?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(true)
        val = false
        val &= json
        XCTAssertEqual(val!, true)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Int?) {...}
    
    func testAssignJsonInt() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Int? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: Int?, rhs: VJson?) {...}
    
    func testAssignIntJson() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Int?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }
    
    
    // Testing: public func &= (lhs: VJson?, rhs: Int8?) {...}
    
    func testAssignJsonInt8() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Int8? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }

    
    // Testing: public func &= (lhs: Int8?, rhs: VJson?) {...}
    
    func testAssignInt8Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Int8?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: UInt8?) {...}
    
    func testAssignJsonUInt8() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: UInt8? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }

    
    // Testing: public func &= (lhs: UInt8?, rhs: VJson?) {...}
    
    func testAssignUInt8Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: UInt8?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Int16?) {...}
    
    func testAssignJsonInt16() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Int16? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: Int16?, rhs: VJson?) {...}
    
    func testAssignInt16Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Int16?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: UInt16?) {...}
    
    func testAssignJsonUInt16() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: UInt16? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: UInt16?, rhs: VJson?) {...}
    
    func testAssignUInt16Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: UInt16?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Int32?) {...}
    
    func testAssignJsonInt32() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Int32? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: Int32?, rhs: VJson?) {...}
    
    func testAssignInt32Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Int32?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: UInt32?) {...}
    
    func testAssignJsonUInt32() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: UInt32? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: UInt32?, rhs: VJson?) {...}
    
    func testAssignUInt32Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: UInt32?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Int64?) {...}
    
    func testAssignJsonInt64() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Int64? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: Int64?, rhs: VJson?) {...}
    
    func testAssignInt64Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Int64?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: UInt64?) {...}
    
    func testAssignJsonUInt64() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: UInt64? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
    }
    
    
    // Testing: public func &= (lhs: UInt64?, rhs: VJson?) {...}
    
    func testAssignUInt64Json() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: UInt64?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Float?) {...}
    
    func testAssignJsonFloat() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Float? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.doubleValue!, 3.0)
    }
    
    
    // Testing: public func &= (lhs: Float?, rhs: VJson?) {...}
    
    func testAssignFloatJson() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Float?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10.0)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10.0)

        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: Double?) {...}
    
    func testAssignJsonDouble() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Double? = 1
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.intValue)
        
        // Execute the assignment with a non-nil argument
        i = 3
        json &= i
        XCTAssertEqual(json!.doubleValue!, 3.0)
    }

    
    // Testing: public func &= (lhs: Double?, rhs: VJson?) {...}
    
    func testAssignDoubleJson() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: Double?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson(10.0)
        val = 1
        val &= json
        XCTAssertEqual(val!, 10.0)
        
        // Execute the assignment with a wrong json type
        json = VJson("test")
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: String?) {...}
    
    func testAssignJsonString() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: String? = "test"
        json = VJson(i!)
        i = nil
        json &= i
        XCTAssertNil(json!.stringValue)
        
        // Execute the assignment with a non-nil argument
        i = "test"
        json &= i
        XCTAssertEqual(json!.stringValue!, "test")
    }
    
    
    // Testing: public func &= (lhs: String?, rhs: VJson?) {...}
    
    func testAssignStringJson() {
        
        // Execute the assignment to a nil object with a nil object
        var json: VJson?
        var val: String?
        val &= json
        XCTAssertNil(val)
        
        // Execute the assignment to a nil object with a value
        json = VJson("test")
        val &= json
        XCTAssertEqual(val!, "test")
        
        // Execute the assignment with a wrong json type
        json = VJson(10)
        val &= json
        XCTAssertNil(val)
    }

    
    // Testing: public func &= (lhs: VJson?, rhs: VJson?) {...}
    
    func testAssignJsonJson() {
        
        // Execute the assignment to on a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        json = VJson.null()
        var v: VJson?
        json &= v
        XCTAssertTrue(json!.isNull)
        
        json = VJson.array()
        json &= v
        XCTAssertTrue(json!.nofChildren == 0)

        json = VJson.object()
        json &= v
        XCTAssertTrue(json!.nofChildren == 0)

        // Implicit change of named null to named object with name of null
        json = VJson()
        json!.add(VJson.null("top"))
        XCTAssertTrue((json!|"top")!.isNull)
        XCTAssertEqual(json!.code, "{\"top\":null}")
        v = VJson(3, name: "one")
        json!["top"] &= v
        XCTAssertEqual(json!.code, "{\"top\":3}")
        
        // Implicit change of unnamed null to named object
        json = VJson()
        v = VJson(3, name: "one")
        json!["top"] &= v
        XCTAssertEqual(json!.code, "{\"top\":3}")
        
        // Implicit change of null to given object
        json = VJson.null()
        v = VJson(3)
        json &= v
        XCTAssertEqual(json!.description, "3")
        
        json = VJson.null()
        v = VJson(true)
        json &= v
        XCTAssertEqual(json!.description, "true")

        json = VJson.null()
        v = VJson.null()
        json &= v
        XCTAssertEqual(json!.description, "null")

        json = VJson.null()
        v = VJson("test")
        json &= v
        XCTAssertEqual(json!.description, "\"test\"")

        json = VJson.null()
        v = VJson(["first" : VJson(3)])
        json &= v
        XCTAssertEqual(json!.description, "{\"first\":3}")

        json = VJson.null()
        v = VJson([VJson(3)])
        json &= v
        XCTAssertEqual(json!.description, "[3]")

        // Array always accepts
        json = VJson.array()
        v = VJson(3, name: "one")
        json &= v
        XCTAssertEqual(json!.description, "[3]")
        
        // Object ignores nameless
        json = VJson.object()
        v = VJson(3)
        json &= v
        XCTAssertEqual(json!.description, "{}")
        
        // Object accepts named items
        json = VJson.object()
        v = VJson(3, name: "one")
        json &= v
        XCTAssertEqual(json!.description, "{\"one\":3}")
    }

    
    // Testing: public func == (lhs: VJson, rhs: VJson) -> Bool {...}
    
    func testEquatable() {
        
        // Test same object compare
        var l = VJson(4)
        var r = l
        XCTAssertTrue(l == r)
        
        // Test different type
        l = VJson.null()
        r = VJson(true)
        XCTAssertFalse(l == r)
        r = VJson.null()
        XCTAssertTrue(l == r)
        
        // Test different value for bool
        l = VJson(true)
        r = VJson(false)
        XCTAssertFalse(l == r)
        r = VJson(true)
        XCTAssertTrue(l == r)
        
        // Test different value for number
        l = VJson(1)
        r = VJson(2)
        XCTAssertFalse(l == r)
        r = VJson(1)
        XCTAssertTrue(l == r)

        // Test different value for string
        l = VJson("yes")
        r = VJson("ofcourse")
        XCTAssertFalse(l == r)
        r = VJson("yes")
        XCTAssertTrue(l == r)
        
        // Test number of children & type/value of children
        l = VJson.object()
        r = VJson.object()
        XCTAssertTrue(l == r)
        l["a"] &= 1
        XCTAssertFalse(l == r)
        r["a"] &= 1
        XCTAssertTrue(l == r)
        l["b"][2] &= true
        r["b"][2] &= true
        XCTAssertTrue(l == r)
        r["b"][3] &= "yes"
        XCTAssertFalse(l == r)
    }
    
    
    // Testing: public func != (lhs: VJson, rhs: VJson) -> Bool {...}
    
    func testNotEqual() {
        
        // Test same object compare
        let l = VJson(4)
        let r = VJson(3)
        XCTAssertTrue(l != r)
    }
    
    
    // Testing: public var isNull: Bool {...}
    
    func testIsNull() {
        
        let n = VJson.null()
        XCTAssertTrue(n.isNull)
        
        let b = VJson(true)
        XCTAssertFalse(b.isNull)
        
        let i = VJson(0)
        XCTAssertFalse(i.isNull)
        
        let s = VJson("think")
        XCTAssertFalse(s.isNull)
        
        let o = VJson.object()
        XCTAssertFalse(o.isNull)
        
        let a = VJson.array()
        XCTAssertFalse(a.isNull)
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
    
    
    // Testing: public var isNumber: Bool {...}
    
    func testIsNumber() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isNumber)
        
        let b = VJson(true)
        XCTAssertFalse(b.isNumber)
        
        let i = VJson(0)
        XCTAssertTrue(i.isNumber)
        
        let s = VJson("think")
        XCTAssertFalse(s.isNumber)
        
        let o = VJson.object()
        XCTAssertFalse(o.isNumber)
        
        let a = VJson.array()
        XCTAssertFalse(a.isNumber)
    }
    
    
    // Testing: public var isString: Bool {...}
    
    func testIsString() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isString)
        
        let b = VJson(true)
        XCTAssertFalse(b.isString)
        
        let i = VJson(0)
        XCTAssertFalse(i.isString)
        
        let s = VJson("think")
        XCTAssertTrue(s.isString)
        
        let o = VJson.object()
        XCTAssertFalse(o.isString)
        
        let a = VJson.array()
        XCTAssertFalse(a.isString)
    }
    
    
    // Testing: public var isObject: Bool {...}
    
    func testIsObject() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isObject)
        
        let b = VJson(true)
        XCTAssertFalse(b.isObject)
        
        let i = VJson(0)
        XCTAssertFalse(i.isObject)
        
        let s = VJson("think")
        XCTAssertFalse(s.isObject)
        
        let o = VJson.object()
        XCTAssertTrue(o.isObject)
        
        let a = VJson.array()
        XCTAssertFalse(a.isObject)
    }
    
    
    // Testing: public var isArray: Bool {...}
    
    func testIsArray() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isArray)
        
        let b = VJson(true)
        XCTAssertFalse(b.isArray)
        
        let i = VJson(0)
        XCTAssertFalse(i.isArray)
        
        let s = VJson("think")
        XCTAssertFalse(s.isArray)
        
        let o = VJson.object()
        XCTAssertFalse(o.isArray)
        
        let a = VJson.array()
        XCTAssertTrue(a.isArray)
    }
    
    
    // Testing: public convenience init() {...}
    
    func testInit() {
        
        let json = VJson()
        XCTAssertTrue(json.isObject)
        XCTAssertNil(json.nameValue)
        XCTAssertEqual(json.nofChildren, 0)
    }
    
    
    // Parse operations ar tested elsewhere
    
    
    // Testing: nameValue
    
    func testNameValue() {

        // Without a name
        let json = VJson()
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)
        
        // With a name
        json.nameValue = "aName"
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "aName")
    }
    
    
    // Testing: nullValue
    
    func testNullValue() {
        
        // Creation without name
        var json = VJson.null()
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        XCTAssertTrue(json.nullValue!)
        
        // Creation with name
        json = VJson.null("aName")
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        XCTAssertTrue(json.nullValue!)
        
        // Convert from Number
        json = VJson(1)
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.asNull)
        XCTAssertNil(json.nullValue)
        json.nullValue = true
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        XCTAssertTrue(json.nullValue!)

        // Convert from String
        json = VJson("qwerty")
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.asNull)
        XCTAssertNil(json.nullValue)
        json.nullValue = false
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        XCTAssertTrue(json.nullValue!)

        // Convert from Object
        json = VJson.object("qwerty")
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.asNull)
        XCTAssertNil(json.nullValue)
        json.nullValue = false
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        XCTAssertTrue(json.nullValue!)

        // Convert from Array
        json = VJson.array("qwerty")
        XCTAssertFalse(json.isNull)
        XCTAssertFalse(json.asNull)
        XCTAssertNil(json.nullValue)
        json.nullValue = false
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        XCTAssertTrue(json.nullValue!)
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
    }
    
    // Testing: numberValue, integerValue, doubleValue
    
    func testNumber() {

        // Create with no value and no name
        var num: NSNumber?
        var json = VJson(num)
        var exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        
        // Create with no value and with name
        json = VJson(num, name: "qwerty")
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Create with value and no name
        num = NSNumber(value: 32)
        json = VJson(num)
        exp = NSNumber(value: 32)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.numberValue!, exp)
        XCTAssertFalse(json.hasName)
        
        // Create with value and with name
        num = NSNumber(value: 32)
        json = VJson(num, name: "qwerty")
        exp = NSNumber(value: 32)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.numberValue!, exp)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")

        // Test NULL value as NUMBER
        json = VJson.null("qwerty")
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")

        // Test BOOL(true) value as NUMBER
        json = VJson(true)
        exp = NSNumber(value: 1)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)

        // Test BOOL(false) value as NUMBER
        json = VJson(false)
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)

        // Test STRING("12") value as NUMBER
        json = VJson("12")
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)

        // Test STRING("qwerty") value as NUMBER
        json = VJson("qwerty")
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)
        
        // Assign a NUMBER? = nil
        json = VJson(NSNumber(value: 45))
        num = nil
        json.numberValue = num
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        
        // Assign a NUMBER = 12
        json = VJson(NSNumber(value: 45))
        num = NSNumber(value: 12)
        json.numberValue = num
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.numberValue!, exp)

        // Assign a NUMBER with Int? = nil
        json = VJson(NSNumber(value: 45))
        var inum: Int?
        json.intValue = inum
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asInt, 0)
        XCTAssertNil(json.intValue)

        // Assign a NUMBER with Int? = 12
        json = VJson(NSNumber(value: 45))
        inum = 12
        json.intValue = inum
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asInt, 12)
        XCTAssertEqual(json.intValue!, 12)

        // Assign a NUMBER with Double? = nil
        json = VJson(NSNumber(value: 45))
        var dnum: Double?
        json.doubleValue = dnum
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asDouble, 0.0)
        XCTAssertNil(json.doubleValue)

        // Assign a NUMBER with Double = 1.2
        json = VJson(NSNumber(value: 45))
        dnum = 12.0
        json.intValue = inum
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asDouble, 12)
        XCTAssertEqual(json.doubleValue!, 12.0)
        
        // Test constructor Int
        json = VJson(Int(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt
        json = VJson(UInt(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int8
        json = VJson(Int8(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt8
        json = VJson(UInt8(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int16
        json = VJson(Int16(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt16
        json = VJson(UInt16(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int32
        json = VJson(Int32(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt32
        json = VJson(UInt32(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int64
        json = VJson(Int64(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt64
        json = VJson(UInt64(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Float
        json = VJson(Float(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.doubleValue!, 12)
        
        // Test constructor Double
        json = VJson(Double(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.doubleValue!, 12)
        
        // Test constructor NSNumber
        json = VJson(NSNumber(value: 12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Convert from NULL
        json = VJson.null()
        json &= 1
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isNull)
        XCTAssertEqual(json.asInt, 1)
        XCTAssertEqual(json.intValue!, 1)

        // Do no longer raise fatal errors
        VJson.fatalErrorOnTypeConversion = false // Change manually to check if this works as expected
        
        // Convert from BOOL
        json = VJson(true)
        json &= 12
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isBool)
        XCTAssertEqual(json.asInt, 12)
        XCTAssertEqual(json.intValue!, 12)
        
        // Convert from STRING
        json = VJson("true")
        json &= 23
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isString)
        XCTAssertEqual(json.asInt, 23)
        XCTAssertEqual(json.intValue!, 23)
        
        // Convert from OBJECT
        json = VJson.object()
        json &= 34
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isObject)
        XCTAssertEqual(json.asInt, 34)
        XCTAssertEqual(json.intValue!, 34)
        
        // Convert from ARRAY
        json = VJson.array()
        json &= 45
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isArray)
        XCTAssertEqual(json.asInt, 45)
        XCTAssertEqual(json.intValue!, 45)
    }
    
    
    // Testing: stringValue
    
    func testStringValue() {
        
        // Create with no value and no name
        var str: String?
        var json = VJson(str)
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "null")
        XCTAssertNil(json.stringValue)
        XCTAssertFalse(json.hasName)
        
        // Create with no value and with name
        json = VJson(str, name: "qwerty")
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "null")
        XCTAssertNil(json.stringValue)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Create with value and no name
        str = "qazwsx"
        json = VJson(str)
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qazwsx")
        XCTAssertEqual(json.stringValue!, "qazwsx")
        XCTAssertFalse(json.hasName)
        
        // Create with value and with name
        json = VJson(str, name: "qwerty")
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qazwsx")
        XCTAssertEqual(json.stringValue!, "qazwsx")
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Assign nil
        json = VJson("qwerty")
        json.stringValue = nil
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asString, "null")
        XCTAssertNil(json.stringValue)
        XCTAssertFalse(json.hasName)

        // Assign a string
        json = VJson("qwerty")
        json.stringValue = "qazwsx"
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qazwsx")
        XCTAssertEqual(json.stringValue!, "qazwsx")
        XCTAssertFalse(json.hasName)

        // Assign a string with a double-quote character in it
        str = "qa\"zwsx"
        json = VJson("qwerty")
        json.stringValue = str
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qa\"zwsx")
        XCTAssertEqual(json.stringValue!, "qa\"zwsx")
        XCTAssertFalse(json.hasName)

        // Convert from NULL
        json = VJson.null()
        json.stringValue = "qwerty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNull)
        XCTAssertEqual(json.asString, "qwerty")
        XCTAssertEqual(json.stringValue!, "qwerty")
        
        // Do no longer raise fatal errors
        VJson.fatalErrorOnTypeConversion = false // Change manually to check if this works as expected
        
        // Convert from BOOL
        json = VJson(true)
        json.stringValue = "werty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isBool)
        XCTAssertEqual(json.asString, "werty")
        XCTAssertEqual(json.stringValue!, "werty")
        
        // Convert from NUMBER
        json = VJson(12)
        json.stringValue = "qerty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asString, "qerty")
        XCTAssertEqual(json.stringValue!, "qerty")
        
        // Convert from OBJECT
        json = VJson.object()
        json.stringValue = "qwrty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isObject)
        XCTAssertEqual(json.asString, "qwrty")
        XCTAssertEqual(json.stringValue!, "qwrty")
        
        // Convert from ARRAY
        json = VJson.array()
        json.stringValue = "qwety"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertEqual(json.asString, "qwety")
        XCTAssertEqual(json.stringValue!, "qwety")
    }
    
    
    // Testing: public var hasChildren: Bool {...}
    
    func testHasChildren() {
        
        // Test the NULL
        var json = VJson.null()
        XCTAssertFalse(json.hasChildren)
        
        // Test the BOOL
        json = VJson(true)
        XCTAssertFalse(json.hasChildren)

        // Test the NUMBER
        json = VJson(12)
        XCTAssertFalse(json.hasChildren)
        
        // Test the STRING
        json = VJson("qwerty")
        XCTAssertFalse(json.hasChildren)
        
        // Test an empty OBJECT
        json = VJson.object()
        XCTAssertFalse(json.hasChildren)

        // Test an empty ARRAY
        json = VJson.array()
        XCTAssertFalse(json.hasChildren)
        
        // Test a non-empty OBJECT
        json = VJson.object()
        json.add(VJson(true), forName: "qwerty")
        XCTAssertTrue(json.hasChildren)
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson(true))
        XCTAssertTrue(json.hasChildren)
    }
    
    
    // Testing: public var nofChildren: Int {...}
    
    func testNofChildren() {
        
        // Test the NULL
        var json = VJson.null()
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test the BOOL
        json = VJson(true)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test the NUMBER
        json = VJson(12)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test the STRING
        json = VJson("qwerty")
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test an empty OBJECT
        json = VJson.object()
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test an empty ARRAY
        json = VJson.array()
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test a non-empty OBJECT
        json = VJson.object()
        json.add(VJson(true), forName: "qwerty")
        XCTAssertEqual(json.nofChildren, 1)
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson(true))
        json.append(VJson("qwert"))
        XCTAssertEqual(json.nofChildren, 2)
    }

    
    // Testing: public var arrayValue: Array<VJson>? {...}
    
    func testArrayValue() {
        
        // Test the NULL
        var json = VJson.null()
        XCTAssertNil(json.arrayValue)
        
        // Test the BOOL
        json = VJson(true)
        XCTAssertNil(json.arrayValue)
        
        // Test the NUMBER
        json = VJson(12)
        XCTAssertNil(json.arrayValue)
        
        // Test the STRING
        json = VJson("qwerty")
        XCTAssertNil(json.arrayValue)
        
        // Test an empty OBJECT
        json = VJson.object()
        XCTAssertEqual(json.arrayValue!.count, 0)
        
        // Test an empty ARRAY
        json = VJson.array()
        XCTAssertEqual(json.arrayValue!.count, 0)
        
        // Test a non-empty OBJECT
        json = VJson.object()
        json.add(VJson(true), forName: "qwerty")
        if let arr = json.arrayValue {
            XCTAssertEqual(arr.count, 1)
            if arr[0].isBool {
                XCTAssertEqual(arr[0].boolValue!, true)
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson(true))
        json.append(VJson(23))
        if let arr = json.arrayValue {
            XCTAssertEqual(arr.count, 2)
            XCTAssertEqual(arr[0].boolValue!, true)
            XCTAssertEqual(arr[1].intValue!, 23)
        } else {
            XCTFail()
        }
    }
    
    
    // Testing: public var dictionaryValue: Dictionary<String, VJson>? {...}
    
    func testDictionaryValue() {
        
        // Test the NULL
        var json = VJson.null()
        XCTAssertNil(json.dictionaryValue)
        
        // Test the BOOL
        json = VJson(true)
        XCTAssertNil(json.dictionaryValue)
        
        // Test the NUMBER
        json = VJson(12)
        XCTAssertNil(json.dictionaryValue)
        
        // Test the STRING
        json = VJson("qwerty")
        XCTAssertNil(json.dictionaryValue)
        
        // Test an empty OBJECT
        json = VJson.object()
        XCTAssertEqual(json.dictionaryValue!.count, 0)
        
        // Test an empty ARRAY
        json = VJson.array()
        XCTAssertNil(json.dictionaryValue)
        
        // Test a non-empty OBJECT
        json = VJson.object()
        json.add(VJson(true), forName: "qwerty")
        if let dict = json.dictionaryValue {
            XCTAssertEqual(dict.count, 1)
            XCTAssertEqual(dict["qwerty"]!.boolValue!, true)
        } else {
            XCTFail()
        }
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson(true))
        json.append(VJson(23))
        XCTAssertNil(json.dictionaryValue)
    }

    
    // Testing of convenience init(_ children: [VJson?], name: String? = nil) {...}
    
    func testInitWithJsonArray() {
    
        // Without children, without name
        var json = VJson([VJson?]())
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        
        // Without children, with name
        json = VJson([VJson?](), name: "qwerty")
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // With children including a nil, without name, not including nil option set to false
        var nilv: VJson?
        var arr = Array<VJson?>()
        arr.append(VJson.null())
        arr.append(VJson(12))
        arr.append(nilv)
        arr.append(VJson(true))
        json = VJson(arr)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertTrue(json.arrayValue![1].intValue! == 12)
        XCTAssertTrue(json.arrayValue![2].boolValue!)
        
        // With children including a nil, without name, not including nil option set to true
        json = VJson(arr, includeNil: true)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertTrue(json.arrayValue![1].intValue! == 12)
        XCTAssertTrue(json.arrayValue![2].isNull)
        XCTAssertTrue(json.arrayValue![3].boolValue!)
        
        // Remove compilation warning
        nilv = VJson(1)
    }
    
    
    // Testing of convenience init(_ children: [VJsonSerializable?], name: String? = nil) {...}
    
    func testInitWithJsonSerializableArray() {
        
        class Assist: VJsonSerializable {
            let a: Int
            var json: VJson {
                return VJson(a)
            }
            init(val: Int) {
                a = val
            }
        }
        
        // Without children, without name
        var json = VJson([VJsonSerializable?]())
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        
        // Without children, with name
        json = VJson([VJsonSerializable?](), name: "qwerty")
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // With children including a nil, without name, not including nil option set to false
        var nilv: Assist?
        var arr = Array<VJsonSerializable?>()
        arr.append(Assist(val: 2))
        arr.append(Assist(val: 3))
        arr.append(nilv)
        arr.append(Assist(val: 4))
        json = VJson(arr)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.arrayValue![0].intValue! == 2)
        XCTAssertTrue(json.arrayValue![1].intValue! == 3)
        XCTAssertTrue(json.arrayValue![2].intValue! == 4)
        
        // With children including a nil, without name, not including nil option set to true
        json = VJson(arr, includeNil: true)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertTrue(json.arrayValue![0].intValue! == 2)
        XCTAssertTrue(json.arrayValue![1].intValue! == 3)
        XCTAssertTrue(json.arrayValue![2].isNull)
        XCTAssertTrue(json.arrayValue![3].intValue! == 4)
        
        // Remove compilation warning
        nilv = Assist(val: 1)
    }

    
    // Testing: convenience init(_ children: [String:VJson], name: String? = nil) {...}
    
    func testInitWithJsonDictionary() {
        
        // Without children, without name
        var json = VJson([String:VJson]())
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        
        // Without children, with name
        json = VJson([String:VJson](), name: "qwerty")
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // With key/value pairs, without name
        var dict = Dictionary<String,VJson>()
        dict["key1"] = VJson(1)
        dict["key2"] = VJson(2)
        dict["key3"] = VJson(3)
        json = VJson(dict)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.children(withName: "key1")[0].intValue! == 1)
        XCTAssertTrue(json.children(withName: "key2")[0].intValue! == 2)
        XCTAssertTrue(json.children(withName: "key3")[0].intValue! == 3)
    }
    
    
    // Testing: convenience init(_ children: [String:VJsonSerializable], name: String? = nil) {...}
    
    func testInitWithVJsonSerializableDictionary() {
        
        
        class Assist: VJsonSerializable {
            let a: Int
            var json: VJson {
                return VJson(a)
            }
            init(val: Int) {
                a = val
            }
        }

        // Without children, without name
        var json = VJson([String:VJsonSerializable]())
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        
        // Without children, with name
        json = VJson([String:VJson](), name: "qwerty")
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // With key/value pairs, without name
        var dict = Dictionary<String,VJsonSerializable>()
        dict["key1"] = Assist(val: 1)
        dict["key2"] = Assist(val: 2)
        dict["key3"] = Assist(val: 3)
        json = VJson(dict)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.children(withName: "key1")[0].intValue! == 1)
        XCTAssertTrue(json.children(withName: "key2")[0].intValue! == 2)
        XCTAssertTrue(json.children(withName: "key3")[0].intValue! == 3)
    }

    
    // Testing: func arrayToObject() -> VJson? {...}
    
    func testArrayToObject() {
        
        // Valid conversion
        var arr = Array<VJson?>()
        arr.append(VJson.null("one"))
        arr.append(VJson(12, name: "two"))
        arr.append(VJson(true, name: "three"))
        var json = VJson(arr)
        if json.arrayToObject() {
            XCTAssertTrue(json.isObject)
            XCTAssertEqual(json.nofChildren, 3)
            XCTAssertTrue(json.children(withName: "one")[0].isNull)
            XCTAssertTrue(json.children(withName: "two")[0].intValue! == 12)
            XCTAssertTrue(json.children(withName: "three")[0].boolValue!)
        } else {
            XCTFail()
        }
        
        // Invalid converion
        arr = Array<VJson?>()
        arr.append(VJson.null("one"))
        arr.append(VJson(12, name: "two"))
        arr.append(VJson(true))
        json = VJson(arr)
        XCTAssertFalse(json.arrayToObject())
        
        // Illegal conversions
        json = VJson.object()
        XCTAssertFalse(json.arrayToObject())
        json = VJson.null()
        XCTAssertFalse(json.arrayToObject())
        json = VJson(true)
        XCTAssertFalse(json.arrayToObject())
        json = VJson(1)
        XCTAssertFalse(json.arrayToObject())
        json = VJson("qwerty")
        XCTAssertFalse(json.arrayToObject())
    }
    
    
    // Testing: func objectToArray() -> Bool {...}
    
    func testObjectToArray() {
        
        // Sucessful conversion OBJECT to ARRAY, 1 element
        var dict = Dictionary<String,VJson>()
        dict["key1"] = VJson(1)
        var json = VJson(dict)
        XCTAssertTrue(json.objectToArray())
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertTrue(json.arrayValue![0].intValue! == 1)

        // Illegal conversions
        json = VJson.array()
        XCTAssertFalse(json.objectToArray())
        json = VJson.null()
        XCTAssertFalse(json.objectToArray())
        json = VJson(true)
        XCTAssertFalse(json.objectToArray())
        json = VJson(1)
        XCTAssertFalse(json.objectToArray())
        json = VJson("qwerty")
        XCTAssertFalse(json.objectToArray())
    }
}
