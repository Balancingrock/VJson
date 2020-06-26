//
//  ArrayObjectTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 25/09/17.
//
//

import XCTest
@testable import VJson


class ArrayObjectTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    // Testing: public var arrayValue: Array<VJson>? {...}
    
    func testArrayValue() {
        
        // Test the NULL
        var json = VJson.null()
        XCTAssertEqual(json.arrayValue.count, 0)
        
        // Test the BOOL
        json = VJson(true)
        XCTAssertEqual(json.arrayValue.count, 0)
        
        // Test the NUMBER
        json = VJson(12)
        XCTAssertEqual(json.arrayValue.count, 0)
        
        // Test the STRING
        json = VJson("qwerty")
        XCTAssertEqual(json.arrayValue.count, 0)
        
        // Test an empty OBJECT
        json = VJson.object()
        XCTAssertEqual(json.arrayValue.count, 0)
        
        // Test an empty ARRAY
        json = VJson.array()
        XCTAssertEqual(json.arrayValue.count, 0)
        
        // Test a non-empty OBJECT
        json = VJson.object()
        json.add(VJson(true), for: "qwerty")
        let arr = json.arrayValue
        XCTAssertEqual(arr.count, 1)
        if arr[0].isBool {
            XCTAssertEqual(arr[0].boolValue!, true)
        } else {
            XCTFail()
        }
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson(true))
        json.append(VJson(23))
        let aarr = json.arrayValue
        XCTAssertEqual(aarr.count, 2)
        XCTAssertEqual(aarr[0].boolValue!, true)
        XCTAssertEqual(aarr[1].intValue!, 23)
    }
    
    
    // Testing: public var dictionaryValue: Dictionary<String, VJson>? {...}
    
    func testDictionaryValue() {
        
        // Test the NULL
        var json = VJson.null()
        XCTAssertEqual(json.dictionaryValue.count, 0)
        
        // Test the BOOL
        json = VJson(true)
        XCTAssertEqual(json.dictionaryValue.count, 0)
        
        // Test the NUMBER
        json = VJson(12)
        XCTAssertEqual(json.dictionaryValue.count, 0)
        
        // Test the STRING
        json = VJson("qwerty")
        XCTAssertEqual(json.dictionaryValue.count, 0)
        
        // Test an empty OBJECT
        json = VJson.object()
        XCTAssertEqual(json.dictionaryValue.count, 0)
        
        // Test an empty ARRAY
        json = VJson.array()
        XCTAssertEqual(json.dictionaryValue.count, 0)
        
        // Test a non-empty OBJECT
        json = VJson.object()
        json.add(VJson(true), for: "qwerty")
        let dict = json.dictionaryValue
        XCTAssertEqual(dict.count, 1)
        XCTAssertEqual(dict["qwerty"]!.boolValue!, true)
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson("one", name: "nameone"))
        json.append(VJson(23))
        XCTAssertEqual(json.dictionaryValue.count, 1)
        XCTAssertEqual(json.dictionaryValue["nameone"]!.stringValue!, "one")
    }

    
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
        json.add(VJson(true), for: "qwerty")
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
        json.add(VJson(true), for: "qwerty")
        XCTAssertEqual(json.nofChildren, 1)
        
        // Test a non-empty ARRAY
        json = VJson.array()
        json.append(VJson(true))
        json.append(VJson("qwert"))
        XCTAssertEqual(json.nofChildren, 2)
    }
    
    
    // Testing: public func removeAllChildren()
    
    func testRemoveAllChildren() {
        
        // Test for empty array
        var json = VJson.array()
        json.undoManager = UndoManager()
        json.removeAllChildren()
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test for filled array
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        json = VJson(arr)
        json.undoManager = UndoManager()
        json.removeAllChildren()
        XCTAssertEqual(json.nofChildren, 0)
        #if !os(Linux)
        json.undoManager!.undo()
        XCTAssertEqual(json.nofChildren, 2)
        #endif
        
        // Test for empty OBJECT
        json = VJson.object()
        json.undoManager = UndoManager()
        json.removeAllChildren()
        XCTAssertEqual(json.nofChildren, 0)
        #if !os(Linux)
        json.undoManager!.undo()
        XCTAssertEqual(json.nofChildren, 0)
        #endif
        
        // Test for filled OBJECT
        json = VJson.object()
        json.undoManager = UndoManager()
        json.add(VJson(0), for: "qwerty")
        #if !os(Linux)
        json.undoManager!.removeAllActions()
        json.removeAllChildren()
        XCTAssertEqual(json.nofChildren, 0)
        json.undoManager!.undo()
        #endif
        XCTAssertEqual(json.nofChildren, 1)
    }

    // Testing: public func remove(childrenEqualTo: VJson?) -> Int
    
    func testRemoveChildrenEqualTo() {
        

        // Test with a nil parameter
        // Expected: Return nil
        var arr: Array<VJson?> = []
        arr.append(VJson(1))
        arr.append(VJson(2))
        arr.append(VJson(3))
        arr.append(VJson(2))
        var json = VJson(arr)
        json.undoManager = UndoManager()
        var e: VJson?
        XCTAssertEqual(json.removeChildren(equalTo: e), 0)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        XCTAssertEqual(json.arrayValue[3].intValue!, 2)
        
        // Test with non-nil, not existing value
        // Expected: Return nil
        e = VJson(4)
        #if !os(Linux)
        json.undoManager!.removeAllActions()
        #endif
        XCTAssertEqual(json.removeChildren(equalTo: e), 0)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        XCTAssertEqual(json.arrayValue[3].intValue!, 2)
        
        // Test with non-nil, existing value
        // Expected: Return nil
        e = VJson(2)
        #if !os(Linux)
        json.undoManager!.removeAllActions()
        #endif
        XCTAssertNotNil(json.removeChildren(equalTo: e))
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 3)
        
        
        // Test with non-nil on an object
        // Expected: No change
        json = VJson.object()
        json.undoManager = UndoManager()
        json.add(VJson(1), for: "one", replace: false)
        json.add(VJson(2), for: "two", replace: false)
        json.add(VJson(3), for: "three", replace: false)
        json.add(VJson(2), for: "two", replace: false)
        e = VJson(4)
        #if !os(Linux)
        json.undoManager!.removeAllActions()
        #endif
        XCTAssertEqual(json.removeChildren(equalTo: e), 0)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.items(with: "one")[0].intValue, 1)
        XCTAssertEqual(json.items(with: "two")[0].intValue, 2)
        XCTAssertEqual(json.items(with: "three")[0].intValue, 3)
        XCTAssertEqual(json.items(with: "two")[0].intValue, 2)
        
        // Test with non-nil on an object
        // Expected: No change
        json = VJson.object()
        json.undoManager = UndoManager()
        json.add(VJson(1), for: "one", replace: false)
        json.add(VJson(2), for: "two", replace: false)
        json.add(VJson(3), for: "three", replace: false)
        json.add(VJson(2), for: "two", replace: false)
        e = VJson(2, name: "two")
        #if !os(Linux)
        json.undoManager!.removeAllActions()
        #endif
        XCTAssertEqual(json.removeChildren(equalTo: e), 2)
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.items(with: "one")[0].intValue, 1)
        XCTAssertEqual(json.items(with: "three")[0].intValue, 3)
    }

    
    // Testing: convenience init(_ children: [String:VJson], name: String? = nil) {...}
    
    func testInitWithJsonDictionary() {
        
        // Without children, without name
        var json = VJson(items: [String:VJson]())
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertFalse(json.hasChildren)
        
        // Without children, with name
        json = VJson(items: [String:VJson](), name: "qwerty")
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
        json = VJson(items: dict)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.items(with: "key1")[0].intValue! == 1)
        XCTAssertTrue(json.items(with: "key2")[0].intValue! == 2)
        XCTAssertTrue(json.items(with: "key3")[0].intValue! == 3)
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
        json = VJson(items: [String:VJson](), name: "qwerty")
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
        XCTAssertTrue(json.items(with: "key1")[0].intValue! == 1)
        XCTAssertTrue(json.items(with: "key2")[0].intValue! == 2)
        XCTAssertTrue(json.items(with: "key3")[0].intValue! == 3)
    }
}
