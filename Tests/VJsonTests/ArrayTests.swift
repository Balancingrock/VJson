//
//  ArrayTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 21/09/17.
//
//

import XCTest
@testable import VJson

extension String: VJsonSerializable {
    public var json: VJson {
        return VJson(self)
    }
}

class ArrayTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        json = VJson.array()
        
        VJson.undoManager = UndoManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        VJson.undoManager = nil

        super.tearDown()
    }

    var json: VJson = VJson.array()
    
    
    func testInit() {
        
        XCTAssertTrue(json.isArray)
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
        XCTAssertTrue(json.children(with: "key1")[0].intValue! == 1)
        XCTAssertTrue(json.children(with: "key2")[0].intValue! == 2)
        XCTAssertTrue(json.children(with: "key3")[0].intValue! == 3)
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
        XCTAssertTrue(json.children(with: "key1")[0].intValue! == 1)
        XCTAssertTrue(json.children(with: "key2")[0].intValue! == 2)
        XCTAssertTrue(json.children(with: "key3")[0].intValue! == 3)
    }

    
    func testChildAt() {
        
        XCTAssertNil(json.child(at: 2))
        
        json = VJson([VJson(1), VJson(2), VJson(3), VJson(2)])
        
        XCTAssertNotNil(json.child(at: 2))
        
        if let child = json.child(at: 2) {
            if let val = child.intValue {
                XCTAssertEqual(val, 3)
            } else {
                XCTFail("Cannot read integer value")
            }
        } else {
            XCTFail("Cannot read child at index 2")
        }
        
        XCTAssertNil(json.child(at: 4))
    }
    
        
    // Testing: public func indexOf(child: VJson?) -> Int?
    
    func testIndexOf() {
        
        // Test indexOf with a nil parameter
        // Expected: Return nil
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        arr.append(VJson(3))
        var json = VJson(arr)
        var e: VJson?
        XCTAssertNil(json.index(of: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test with non-nil, not existing value
        // Expected: Return nil
        e = VJson(4)
        XCTAssertNil(json.index(of: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test with non-nil, existing value, same object as in array
        // Expected: Return nil
        e = json.arrayValue[1]
        XCTAssertEqual(json.index(ofChildrenEqualTo: e)[0], 1)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test with non-nil, existing value, object with same value
        // Expected: Return nil
        e = VJson(2)
        XCTAssertEqual(json.index(ofChildrenEqualTo: e)[0], 1)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test replace with non-nil to an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), for: "one")
        XCTAssertNil(json.index(of: VJson(2)))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(with: "one")[0].intValue, 1)
    }

    
    
    func testIndexOfChildrenEqualTo() {
        
        json = VJson([VJson(1), VJson(2), VJson(3), VJson(2)])
        
        var arr = json.index(ofChildrenEqualTo: VJson(0))
        
        XCTAssertEqual(arr.count, 0)
        
        arr = json.index(ofChildrenEqualTo: VJson(1))
        
        if arr.count != 1 {
            XCTFail("Epected 1 result")
        } else {
            XCTAssertEqual(arr[0], 0)
        }
        
        
        arr = json.index(ofChildrenEqualTo: VJson(3))
        
        if arr.count != 1 {
            XCTFail("Epected 1 result")
        } else {
            XCTAssertEqual(arr[0], 2)
        }

        
        arr = json.index(ofChildrenEqualTo: VJson(2))
        
        if arr.count != 2 {
            XCTFail("Epected 2 results")
        } else {
            XCTAssertEqual(arr[0], 1)
            XCTAssertEqual(arr[1], 3)
        }
    }
    
    
    func testRemove() {
        
        let child = VJson(5)

        json = VJson([VJson(1), child, VJson(3), VJson(2)])

        XCTAssertFalse(json.remove(VJson(1)))
        
        XCTAssertEqual(json.nofChildren, 4)
        
        let rem = json.remove(child)
        
        XCTAssertNotNil(rem)
        XCTAssertEqual(json.nofChildren, 3)
        
        VJson.undoManager!.undo()
        
        XCTAssertEqual(json.nofChildren, 4)
        
        XCTAssertEqual(json[1], child)
    }
    
    func testRemoveAt() {
        
        json = VJson([VJson(1), VJson(2), VJson(3), VJson(4)])

        XCTAssertNil(json.remove(at: 4))
        
        let rem = json.remove(at: 3)
        if let rem = rem {
            if let i = rem.intValue {
                XCTAssertEqual(i, 4)
            } else {
                XCTFail("Expected integer")
            }
        } else {
            XCTFail("Unable to remove item")
        }
        
        VJson.undoManager!.undo()
        
        XCTAssertEqual(json.nofChildren, 4)
        
        if let i = json[3].intValue {
            XCTAssertEqual(i, 4)
        } else {
            XCTFail("Expected integer value")
        }
    }
    
    
    // Testing: public func replace(at index: Int, with child: VJson? ) -> VJson?
    
    func testReplace() {
        
        // Test replace with a nil parameter
        // Expected: No change, return nil
        var arr = [VJson?]()
        arr.append(VJson(1))
        let eJson = VJson(2)
        arr.append(eJson)
        arr.append(VJson(3))
        var json = VJson(arr)
        var e: VJson?
        XCTAssertNil(json.replace(at: 1, with: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test replace with non-nil
        // Expected: replaced at the proper place, non-nil return
        e = VJson(4)
        XCTAssertEqual(json.replace(at: 1, with: e), eJson)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 4)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test replace with non-nil index out of range
        // Expected: No change, return nil
        e = VJson(5)
        XCTAssertNil(json.replace(at: 7, with: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 4)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test replace with non-nil to an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), for: "one")
        XCTAssertNil(json.replace(at: 0, with: VJson(2)))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(with: "one")[0].intValue, 1)
    }

        
    // Testing: public func insert(child: VJson?, at index: Int) -> VJson?
    
    func testInsert() {
        
        // Test insert with a nil parameter
        // Expected: No change, return nil
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        arr.append(VJson(3))
        var json = VJson(arr)
        var e: VJson?
        XCTAssertFalse(json.insert(e, at: 1))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test insert with non-nil at valid index
        // Expected: Inserted at proper position, non-nil return
        e = VJson(4)
        XCTAssertTrue(json.insert(e, at: 1))
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 4)
        XCTAssertEqual(json.arrayValue[2].intValue!, 2)
        XCTAssertEqual(json.arrayValue[3].intValue!, 3)
        
        // Test insert with non-nil at invalid index
        // Expected: No change, return nil
        e = VJson(4)
        XCTAssertFalse(json.insert(e, at: 100))
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 4)
        XCTAssertEqual(json.arrayValue[2].intValue!, 2)
        XCTAssertEqual(json.arrayValue[3].intValue!, 3)
        
        // Test insert with non-nil to an object (test raises fatalError due to type conversion)
        // Expected: No change
        //json = VJson.object()
        //json.add(VJson(1), for: "one")
        //XCTAssertNil(json.insert(VJson(2), at: 0))
        //XCTAssertEqual(json.nofChildren, 1)
        //XCTAssertEqual(json.children(with: "one")[0].intValue, 1)
        
        
        // Undo testing
        VJson.undoManager!.removeAllActions()
        json = VJson([VJson(1), VJson(3), VJson(4)])
        
        let child = VJson(5)
        
        let comp2 = VJson([VJson(5), VJson(1), VJson(3), VJson(4)])
        let comp3 = VJson([VJson(1), VJson(5), VJson(3), VJson(4)])
        
        let t2 = json.duplicate
        XCTAssertTrue(t2.insert(child, at: 0))
        XCTAssertEqual(t2, comp2)
        VJson.undoManager!.undo()
        XCTAssertEqual(t2, json)
        
        let t3 = json.duplicate
        XCTAssertTrue(t3.insert(child, at: 1))
        XCTAssertEqual(t3, comp3)
        VJson.undoManager!.undo()
        XCTAssertEqual(t3, json)
        
        XCTAssertFalse(t3.insert(child, at: -1))
        VJson.undoManager!.undo()
        XCTAssertEqual(t3, json)
    }

    
    // Testing: public func append(child: VJson?) -> VJson?
    
    func testAppend() {
        
        // Test append with a nil parameter
        // Expected: No change, return nil
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        arr.append(VJson(3))
        var json = VJson(arr)
        var e: VJson?
        json.append(e)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        
        // Test append with non-nil
        // Expected: Append at end, non-nil return
        e = VJson(4)
        json.append(e)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertEqual(json.arrayValue[2].intValue!, 3)
        XCTAssertEqual(json.arrayValue[3].intValue!, 4)
        
        // Test append with non-nil to an object
        // Expected: No change
        json = VJson.object()
        XCTAssertNotNil(json.add(VJson(1), for: "one"))
        json.append(VJson(2))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(with: "one")[0].intValue, 1)
        
        // Test: Append to a NULL
        // Expected: NULL is transformed into an ARRAY automatically
        json = VJson.null()
        json.append(VJson(1))
        XCTAssertFalse(json.isNull)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0].intValue!, 1)
        
        // Undo test
        VJson.undoManager = UndoManager()
        json = VJson.array()
        json.append(VJson(0))
        XCTAssertEqual(json.nofChildren, 1)
        VJson.undoManager?.undo()
        XCTAssertEqual(json.nofChildren, 0)
    }

    func testAppendArray() {
        
        json = VJson.null()
        
        let arr: Array<VJson?> = [VJson(1), VJson(2), nil, VJson(4)]
        
        let exp1 = VJson([VJson(1), VJson(2), VJson.null(), VJson(4)])
        let exp2 = VJson([VJson(1), VJson(2), VJson(4)])
        
        json.append(arr, includeNil: true)
        XCTAssertEqual(exp1, json)
        
        VJson.undoManager?.undo()
        
        json.append(arr)
        XCTAssertEqual(exp2, json)
    }
    
    func testAppendSer() {
        
        json = VJson.null()
        
        let one = "one"
        let two = "two"
        
        let comp1 = VJson([VJson("one"), VJson("two")])
        
        json.append(one)
        
        XCTAssertTrue(json.isArray)
        
        json.append(two)
        
        XCTAssertEqual(json, comp1)
        
        VJson.undoManager?.undo()
        
        XCTAssertTrue(json.isNull)
    }
    
    func testAppendArraySer() {
        
        json = VJson.null()
        
        let arr: Array<String?> = ["one", "two", nil, "four"]
        
        let exp1 = VJson([VJson("one"), VJson("two"), VJson.null(), VJson("four")])
        let exp2 = VJson([VJson("one"), VJson("two"), VJson("four")])
        
        json.append(arr, includeNil: true)
        XCTAssertEqual(exp1, json)
        
        VJson.undoManager?.undo()
        
        json.append(arr)
        XCTAssertEqual(exp2, json)
    }
}
