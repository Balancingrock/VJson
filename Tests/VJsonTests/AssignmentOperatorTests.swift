//
//  AssignmentOperatorTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 26/09/17.
//
//

import XCTest
@testable import VJson


class AssignmentOperatorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.boolValue)
        json!.undoManager!.undo()
        if json!.isBool {
            XCTAssertTrue(json!.boolValue!)
        } else {
            XCTFail("Expected a JSON BOOL")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = false
        json &= i
        XCTAssertEqual(json!.boolValue!, false)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        
        // Execute the assignment to a VJson object that is nil
        var json: VJson?
        json &= 1
        XCTAssertNil(json)
        
        // Execute the assignment with a nil argument
        var i: Int? = 1
        json = VJson(i!)
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.intValue)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.intValue!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.int8Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.int8Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }

        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.intValue)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.uint8Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }

        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.int16Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.int16Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.uint16Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.uint16Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.int32Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.int32Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.uint32Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.uint32Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.int64Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.int64Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.uint64Value)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.uint64Value!, 1)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.intValue!, 3)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.doubleValue)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.doubleValue!, 1.0)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.doubleValue!, 3.0)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.doubleValue)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isNumber {
            XCTAssertEqual(json!.doubleValue!, 1.0)
        } else {
            XCTFail("Expected a JSON NUMBER")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = 3
        json &= i
        XCTAssertEqual(json!.doubleValue!, 3.0)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        i = nil
        json!.undoManager!.removeAllActions()
        json &= i
        XCTAssertNil(json!.stringValue)
        XCTAssertTrue(json!.isNull)
        json!.undoManager!.undo()
        if json!.isString {
            XCTAssertEqual(json!.stringValue!, "test")
        } else {
            XCTFail("Expected a JSON STRING")
        }
        
        // Execute the assignment with a non-nil argument
        json = VJson.null()
        json!.undoManager = UndoManager()
        i = "test"
        json &= i
        XCTAssertEqual(json!.stringValue!, "test")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
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
        json!.undoManager = UndoManager()
        var v: VJson?
        json &= v
        XCTAssertTrue(json!.isNull)
        
        json = VJson.array()
        json!.undoManager = UndoManager()
        json &= v
        XCTAssertTrue(json!.nofChildren == 0)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isArray)
        
        json = VJson.object()
        json!.undoManager = UndoManager()
        json &= v
        XCTAssertTrue(json!.nofChildren == 0)
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isObject)
        
        // Implicit change of named null to named object with name of null
        json = VJson()
        json!.undoManager = UndoManager()
        json!.add(VJson.null("top"))
        XCTAssertTrue((json!|"top")!.isNull)
        XCTAssertEqual(json!.code, "{\"top\":null}")
        v = VJson(3, name: "one")
        json!.undoManager!.removeAllActions()
        json!["top"] &= v
        XCTAssertEqual(json!.code, "{\"top\":3}")
        json!.undoManager!.undo()
        XCTAssertEqual(json!.code, "{\"top\":null}")
        
        // Implicit change of unnamed null to named object
        json = VJson.null() // was VJson()
        json!.undoManager = UndoManager()
        v = VJson(3, name: "one")
        json!["top"] &= v
        XCTAssertEqual(json!.code, "{\"top\":3}")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
        
        // Implicit change of null to given object
        json = VJson.null()
        json!.undoManager = UndoManager()
        v = VJson(3)
        json &= v
        XCTAssertEqual(json!.description, "3")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)

        json = VJson.null()
        json!.undoManager = UndoManager()
        v = VJson(true)
        json &= v
        XCTAssertEqual(json!.description, "true")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
        
        json = VJson.null()
        json!.undoManager = UndoManager()
        v = VJson.null()
        json &= v
        XCTAssertEqual(json!.description, "null")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
        
        json = VJson.null()
        json!.undoManager = UndoManager()
        v = VJson("test")
        json &= v
        XCTAssertEqual(json!.description, "\"test\"")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
        
        json = VJson.null()
        json!.undoManager = UndoManager()
        v = VJson(items: ["first" : VJson(3)])
        json!.undoManager!.removeAllActions()
        json &= v
        XCTAssertEqual(json!.description, "{\"first\":3}")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
        
        json = VJson.null()
        json!.undoManager = UndoManager()
        v = VJson([VJson(3)])
        json &= v
        XCTAssertEqual(json!.description, "[3]")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isNull)
        
        // Array always accepts
        json = VJson.array()
        json!.undoManager = UndoManager()
        v = VJson(3, name: "one")
        json &= v
        XCTAssertEqual(json!.description, "[3]")
        json!.undoManager!.undo()
        XCTAssertTrue(json!.isArray)
        
        // Object ignores nameless
        json = VJson.object()
        json!.undoManager = UndoManager()
        v = VJson(3)
        json &= v
        XCTAssertEqual(json!.description, "{}")
        json!.undoManager!.undo()
        XCTAssertEqual(json!.description, "{}")
        
        // Object accepts named items
        json = VJson.object()
        json!.undoManager = UndoManager()
        v = VJson(3, name: "one")
        json &= v
        XCTAssertEqual(json!.description, "{\"one\":3}")
        json!.undoManager!.undo()
        XCTAssertEqual(json!.description, "{}")
    }
}
