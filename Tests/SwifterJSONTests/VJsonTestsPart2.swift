//
//  VJsonTestsPart2.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 06/07/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

import XCTest
@testable import SwifterJSON

infix operator &= // Needs to be repeated here, the one defined in vjson.swift somehow is not included at this level
infix operator | : LeftAssociative // Needs to be repeated here, the one defined in vjson.swift somehow is not included at this level

class VJsonTestsPart2: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
        XCTAssertNil(json.insert(e, at: 1))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test insert with non-nil at valid index
        // Expected: Inserted at proper position, non-nil return
        e = VJson(4)
        XCTAssertEqual(json.insert(e, at: 1), e)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 4)
        XCTAssertEqual(json.arrayValue![2].intValue!, 2)
        XCTAssertEqual(json.arrayValue![3].intValue!, 3)

        // Test insert with non-nil at invalid index
        // Expected: No change, return nil
        e = VJson(4)
        XCTAssertNil(json.insert(e, at: 100))
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 4)
        XCTAssertEqual(json.arrayValue![2].intValue!, 2)
        XCTAssertEqual(json.arrayValue![3].intValue!, 3)
        
        // Test insert with non-nil to an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), forName: "one")
        XCTAssertNil(json.insert(VJson(2), at: 0))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(withName: "one")[0].intValue, 1)
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
        XCTAssertNil(json.append(e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test append with non-nil
        // Expected: Append at end, non-nil return
        e = VJson(4)
        XCTAssertEqual(json.append(e), e)
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        XCTAssertEqual(json.arrayValue![3].intValue!, 4)
        
        // Test append with non-nil to an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), forName: "one")
        XCTAssertNil(json.append(VJson(2)))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(withName: "one")[0].intValue, 1)
        
        // Test: Append to a NULL
        // Expected: NULL is transformed into an ARRAY automatically
        json = VJson.null()
        json.append(VJson(1))
        XCTAssertFalse(json.isNull)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
    }
    
    
    // Testing: public func replace(childAt index: Int, with child: VJson? ) -> VJson?
    
    func testReplace() {
        
        // Test replace with a nil parameter
        // Expected: No change, return nil
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        arr.append(VJson(3))
        var json = VJson(arr)
        var e: VJson?
        XCTAssertNil(json.replace(at: 1, with: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test replace with non-nil
        // Expected: replaced at the proper place, non-nil return
        e = VJson(4)
        XCTAssertEqual(json.replace(at: 1, with: e), e)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 4)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)

        // Test replace with non-nil index out of range
        // Expected: No change, return nil
        e = VJson(5)
        XCTAssertNil(json.replace(at: 7, with: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 4)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)

        // Test replace with non-nil to an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), forName: "one")
        XCTAssertNil(json.replace(at: 0, with: VJson(2)))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(withName: "one")[0].intValue, 1)
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
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test with non-nil, not existing value
        // Expected: Return nil
        e = VJson(4)
        XCTAssertNil(json.index(of: e))
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test with non-nil, existing value, same object as in array
        // Expected: Return nil
        e = json.arrayValue![1]
        XCTAssertEqual(json.index(of: e), 1)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test with non-nil, existing value, object with same value
        // Expected: Return nil
        e = VJson(2)
        XCTAssertEqual(json.index(of: e), 1)
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        
        // Test replace with non-nil to an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), forName: "one")
        XCTAssertNil(json.index(of: VJson(2)))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.children(withName: "one")[0].intValue, 1)
    }
    
    
    // Testing: public func remove(child: VJson?) -> Bool
    
    func testRemove() {
        
        // Test with a nil parameter
        // Expected: Return nil
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        arr.append(VJson(3))
        arr.append(VJson(2))
        var json = VJson(arr)
        var e: VJson?
        XCTAssertFalse(json.remove(e))
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        XCTAssertEqual(json.arrayValue![3].intValue!, 2)
        
        // Test with non-nil, not existing value
        // Expected: Return nil
        e = VJson(4)
        XCTAssertFalse(json.remove(e))
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertEqual(json.arrayValue![2].intValue!, 3)
        XCTAssertEqual(json.arrayValue![3].intValue!, 2)
        
        // Test with non-nil, existing value
        // Expected: Return nil
        e = VJson(2)
        XCTAssertTrue(json.remove(e))
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 3)
        
        
        // Test with non-nil on an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), forName: "one", replace: false)
        json.add(VJson(2), forName: "two", replace: false)
        json.add(VJson(3), forName: "three", replace: false)
        json.add(VJson(2), forName: "two", replace: false)
        e = VJson(4)
        XCTAssertFalse(json.remove(e))
        XCTAssertEqual(json.nofChildren, 4)
        XCTAssertEqual(json.children(withName: "one")[0].intValue, 1)
        XCTAssertEqual(json.children(withName: "two")[0].intValue, 2)
        XCTAssertEqual(json.children(withName: "three")[0].intValue, 3)
        XCTAssertEqual(json.children(withName: "two")[0].intValue, 2)

        // Test with non-nil on an object
        // Expected: No change
        json = VJson.object()
        json.add(VJson(1), forName: "one", replace: false)
        json.add(VJson(2), forName: "two", replace: false)
        json.add(VJson(3), forName: "three", replace: false)
        json.add(VJson(2), forName: "two", replace: false)
        e = VJson(2, name: "two")
        XCTAssertTrue(json.remove(e))
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.children(withName: "one")[0].intValue, 1)
        XCTAssertEqual(json.children(withName: "three")[0].intValue, 3)
    }
    
    
    // Testing: public func removeAll()
    
    func testRemoveAll() {
        
        // Test for empty array
        var json = VJson.array()
        json.removeAll()
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test for filled array
        var arr = [VJson?]()
        arr.append(VJson(1))
        arr.append(VJson(2))
        json = VJson(arr)
        json.removeAll()
        XCTAssertEqual(json.nofChildren, 0)

        // Test for empty OBJECT
        json = VJson.object()
        json.removeAll()
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test for filled OBJECT
        json = VJson.object()
        json.add(VJson(0), forName: "qwerty")
        json.removeAll()
        XCTAssertEqual(json.nofChildren, 0)
    }
    
    
    // Testing: public func add(child: VJson?, forName name: String? = nil, replace: Bool = true) -> VJson?
    
    func testAdd() {
        
        // Add a nil, do not specify a name and do not specify replace
        // Expected: Return nil and no change in the object
        var json = VJson.object()
        var a: VJson?
        XCTAssertNil(json.add(a))
        XCTAssertEqual(json.nofChildren, 0)
        
        // Add a value without a name, do not specify a name and do not specify replace
        // Expected: Return nil and no change in the object
        json = VJson.object()
        a = VJson(true)
        XCTAssertNil(json.add(a))
        XCTAssertEqual(json.nofChildren, 0)

        // Add a value with a name, do not specify a name and do not specify replace
        // Expected: Return added value and item added to the object
        json = VJson.object()
        a = VJson(true, name: "qwerty")
        XCTAssertEqual(json.add(a), a)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0], a)

        // Add a value without a name, specify a name and do not specify replace
        // Expected: Return added value and item added to the object, name of item changed to reflect the name it was added under
        json = VJson.object()
        a = VJson(true)
        var b = json.add(a, forName: "qwerty")
        XCTAssertTrue(a === b)
        XCTAssertTrue(a == b)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0], a)
        XCTAssertEqual(json.arrayValue![0].nameValue!, "qwerty")
        
        // Add a value with a name, specify a different name and do not specify replace
        // Expected: Return added value and item added to the object, name of item changed to reflect the name it was added under
        json = VJson.object()
        a = VJson(true, name: "qazwsx")
        b = json.add(a, forName: "qwerty")
        XCTAssertTrue(a === b)
        XCTAssertTrue(a == b)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0], a)
        XCTAssertEqual(json.arrayValue![0].nameValue!, "qwerty")
        
        // Add two items under a different name and specify replace
        // Expected: Both items should be present
        json = VJson.object()
        a = VJson(1, name: "one")
        b = VJson(2, name: "two")
        XCTAssertEqual(json.add(a, replace: true), a)
        XCTAssertEqual(json.add(b, replace: true), b)
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue![0], a)
        XCTAssertEqual(json.arrayValue![1], b)
        
        // Add two items under the same name and specify replace
        // Expected: Onlythe last item should be present
        json = VJson.object()
        a = VJson(1, name: "one")
        b = VJson(2, name: "one")
        XCTAssertEqual(json.add(a), a)
        XCTAssertEqual(json.add(b), b)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0], b)
        
        // Add two items under the same name and specify no replace
        // Expected: Both items should be present
        json = VJson.object()
        a = VJson(1, name: "one")
        b = VJson(2, name: "one")
        XCTAssertEqual(json.add(a, replace: false), a)
        XCTAssertEqual(json.add(b, replace: false), b)
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue![0], a)
        XCTAssertEqual(json.arrayValue![1], b)
        
        // Add a value with a name to a NULL item
        // Expected: Return added value, NULL changed to OBJECT, added item returned
        json = VJson.null()
        a = VJson(true, name: "qwerty")
        XCTAssertEqual(json.add(a), a)
        XCTAssertTrue(json.isObject)
        XCTAssertFalse(json.isNull)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0], a)
    }
    
    
    // Testing: public func removeChildrenWith(name: String) -> Bool
    
    func testRemoveChildren() {
        
        // Test: Remove children from an empty object
        // Expected: No Change
        var json = VJson.object()
        XCTAssertFalse(json.removeChildren(withName: "qwerty"))
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test: Use name for non-existing children
        // Expected: No Change
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "three"))
        XCTAssertFalse(json.removeChildren(withName: "four"))
        XCTAssertEqual(json.nofChildren, 3)
        
        // Test: Remove a single child
        // Expected: 1 Child removed
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "three"))
        XCTAssertTrue(json.removeChildren(withName: "three"))
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue![0].intValue, 1)
        XCTAssertEqual(json.arrayValue![1].intValue, 2)

        // Test: Remove two childs
        // Expected: 2 Childs removed
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "one"), replace: false)
        XCTAssertTrue(json.removeChildren(withName: "one"))
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue, 2)

        // Test: Try to remove a child from an ARRAY item
        // Expected: No change
        json = VJson.array()
        json.append(VJson(1, name: "one"))
        json.append(VJson(2, name: "two"))
        json.append(VJson(3, name: "one"))
        XCTAssertFalse(json.removeChildren(withName: "two"))
        XCTAssertEqual(json.nofChildren, 3)
    }
    
    
    // Testing: public func children(withName: String) -> [VJson]
    
    func testChildren() {
        
        // Test: Empty OBJECT
        // Expected: Empty array
        var json = VJson.object()
        XCTAssertEqual(json.children(withName: "qwerty").count, 0)
        
        // Test: Empty ARRAY
        // Expected: Empty array
        json = VJson.array()
        json.append(VJson(0))
        json.append(VJson(1))
        XCTAssertEqual(json.children(withName: "qwerty").count, 0)

        // Test: Non empty OBJECT, name does not occur
        // Expected: Empty array
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "one"), replace: false)
        XCTAssertEqual(json.children(withName: "qwerty").count, 0)

        // Test: Non empty OBJECT, name occurs twice
        // Expected: Empty array
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "one"), replace: false)
        XCTAssertEqual(json.children(withName: "one").count, 2)
        XCTAssertEqual(json.children(withName: "one")[0].intValue!, 1)
        XCTAssertEqual(json.children(withName: "one")[1].intValue!, 3)
    }
    
    
    // Testing: Generator & Sequence
    
    func testGenerator() {
        
        // Itterate over NULL
        // Expected: Zero passes
        var json = VJson.null()
        for _ in json {
            XCTFail("NULL should not itterate")
        }
        
        // Itterate over BOOL
        // Expected: Zero passes
        json = VJson(true)
        for _ in json {
            XCTFail("BOOL should not itterate")
        }

        // Itterate over STRING
        // Expected: Zero passes
        json = VJson("qwerty")
        for _ in json {
            XCTFail("STRING should not itterate")
        }

        // Itterate over NUMBER
        // Expected: Zero passes
        json = VJson(1)
        for _ in json {
            XCTFail("NUMBER should not itterate")
        }

        // Itterate over empty ARRAY
        // Expected: Zero passes
        json = VJson.array()
        for _ in json {
            XCTFail("Empty ARRAY should not itterate")
        }
        
        // Itterate over empty OBJECT
        // Expected: Zero passes
        json = VJson.object()
        for _ in json {
            XCTFail("Empty OBJECT should not itterate")
        }
        
        // Itterate over ARRAY with two item
        json = VJson([VJson(1), VJson(2)])
        var found1 = false
        var found2 = false
        var loopCount = 0
        for j in json {
            if j.intValue! == 1 { found1 = true }
            if j.intValue! == 2 { found2 = true }
            loopCount += 1
        }
        if !(found1 && found2) {
            XCTFail("Missed at least one item")
        }
        if loopCount > 2 {
            XCTFail("Too many itterations")
        }
        
        // Itterate over OBJECT with two item
        json = VJson(["one":VJson(1), "two":VJson(2)])
        found1 = false
        found2 = false
        loopCount = 0
        for j in json {
            if j.intValue! == 1 { found1 = true }
            if j.intValue! == 2 { found2 = true }
            loopCount += 1
        }
        if !(found1 && found2) {
            XCTFail("Missed at least one item")
        }
        if loopCount > 2 {
            XCTFail("Too many itterations")
        }
        
        // Itterate over an array but remove an item before the item is reached
        // Expected: The removed item should not be included in the loop
        let three = VJson(3)
        json = VJson([VJson(1), VJson(2), three])
        found1 = false
        found2 = false
        loopCount = 0
        for j in json {
            if j.intValue! == 1 { found1 = true; json.remove(three) }
            if j.intValue! == 2 { found2 = true }
            loopCount += 1
        }
        if !(found1 && found2) {
            XCTFail("Missed at least one item")
        }
        if loopCount > 2 {
            XCTFail("Too many itterations")
        }
    }
    
    
    // Testing: public subscript(index: Int) -> VJson
    // Note: Subscript accessors should only be used for the creation of a JSON hierarchy, not for interrogation or reading. Side effects are not tested.
    
    func testSubscriptInt() {
        
        // Create an item in an ARRAY
        // Expected: An array with three values, dummy values are created
        var json = VJson.array()
        json[2] &= 2
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertTrue(json.arrayValue![1].isNull)
        XCTAssertEqual(json.arrayValue![2].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNull)
        XCTAssertTrue(json[2].isNumber)
        
        // Check type conversion from NULL
        json = VJson.null()
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)

        // Switch fatal errors on type conversion off
        VJson.fatalErrorOnTypeConversion = false        // Manually switch on/off for effect
        
        // Check type conversion from BOOL
        json = VJson(true)
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)

        // Check type conversion from NUMBER
        json = VJson(4)
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)

        // Check type conversion from STRING
        json = VJson("qwerty")
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue![0].isNull)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)

        // Check type conversion from OBJECT
        json = VJson(["one" : VJson(1), "two" : VJson(2)])
        json[2] &= true
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue![0].intValue!, 1)
        XCTAssertEqual(json.arrayValue![1].intValue!, 2)
        XCTAssertTrue(json.arrayValue![2].boolValue!)
        XCTAssertTrue(json[0].isNumber)
        XCTAssertTrue(json[1].isNumber)
        XCTAssertTrue(json[2].isBool)
    }
    
    
    // Testing: public subscript(key: String) -> VJson
    // Note: Subscript accessors should only be used for the creation of a JSON hierarchy, not for interrogation or reading. Side effects are not tested.
    
    func testSubscriptString() {
        
        // Create an item in an OBJECT
        // Expected: An object with one value
        var json = VJson.object()
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from NULL
        json = VJson.null()
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Switch fatal errors on type conversion off
        VJson.fatalErrorOnTypeConversion = false        // Manually switch on/off for effect
        
        // Check type conversion from BOOL
        json = VJson(true)
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from NUMBER
        json = VJson(4)
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from STRING
        json = VJson("qwerty")
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from ARRAY
        json = VJson([VJson(1), VJson(2)])
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue![0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
    }
    
    
    // Testing: public func item(ofType: JType, atPath path: [String]) -> VJson?
    
    func testItemOfTypeArray() {
        
        
        // Create a hierachy that will be tested, it should contain at least an object in an array in an object.
        let json = VJson()
        json["first"] &= 1
        json["array"][0] &= "a0"
        json["array"][1]["second"]["last"] &= "bottom"
        json["array"][2].add(VJson.null(), forName: "aNull")
        json["array"][2].add(VJson(3), forName: "anInteger")
        json["array"][2].add(VJson(true), forName: "aBool")
        json["array"][2].add(VJson("qwerty"), forName: "aString")
        
        // Test confirming cases
        
        if let first = json.item(of: VJson.JType.number, at: ["first"]) {
            XCTAssert(first.isNumber)
            XCTAssertEqual(first.intValue!, 1)
        } else {
            XCTFail("First not found")
        }
        
        if let array = json.item(of: VJson.JType.array, at: ["array"]) {
            XCTAssertTrue(array.isArray)
            XCTAssertEqual(array.nofChildren, 3)
        } else {
            XCTFail("Array not found")
        }
        
        if let string = json.item(of: VJson.JType.string, at: ["array", "0"]) {
            XCTAssert(string.isString)
            XCTAssertEqual(string.stringValue!, "a0")
        } else {
            XCTFail("String not found")
        }
        
        if let object = json.item(of: VJson.JType.object, at: ["array", "1"]) {
            XCTAssert(object.isObject)
            XCTAssertEqual(object.nofChildren, 1)
        } else {
            XCTFail("Object not found")
        }
        
        if let object = json.item(of: VJson.JType.object, at: ["array", "1", "second"]) {
            XCTAssert(object.isObject)
            XCTAssertEqual(object.nofChildren, 1)
        } else {
            XCTFail("Second Object not found")
        }
        
        if let string = json.item(of: VJson.JType.string, at: ["array", "1", "second", "last"]) {
            XCTAssert(string.isString)
            XCTAssertEqual(string.stringValue!, "bottom")
        } else {
            XCTFail("last String not found")
        }

        if let aNull = json.item(of: VJson.JType.null, at: ["array", "2", "aNull"]) {
            XCTAssert(aNull.isNull)
        } else {
            XCTFail("aNull not found")
        }
        
        if let anInt = json.item(of: VJson.JType.number, at: ["array", "2", "anInteger"]) {
            XCTAssert(anInt.isNumber)
            XCTAssertEqual(anInt.intValue!, 3)
        } else {
            XCTFail("anInt not found")
        }

        if let aBool = json.item(of: VJson.JType.bool, at: ["array", "2", "aBool"]) {
            XCTAssert(aBool.isBool)
            XCTAssertTrue(aBool.boolValue!)
        } else {
            XCTFail("aBool not found")
        }

        if let aString = json.item(of: VJson.JType.string, at: ["array", "2", "aString"]) {
            XCTAssert(aString.isString)
            XCTAssertEqual(aString.stringValue!, "qwerty")
        } else {
            XCTFail("aString not found")
        }

        // Test missing cases
        
        XCTAssertNil(json.item(of: VJson.JType.null, at: ["array", "2"]))
        XCTAssertNil(json.item(of: VJson.JType.bool, at: ["array", "2"]))
        XCTAssertNil(json.item(of: VJson.JType.number, at: ["array", "2"]))
        XCTAssertNil(json.item(of: VJson.JType.string, at: ["array", "2"]))
        XCTAssertNil(json.item(of: VJson.JType.object, at: ["array", "0"]))
        XCTAssertNil(json.item(of: VJson.JType.array, at: ["first", "2"]))
    }
    
    
    // Testing: public func item(ofType: JType, atPath path: String ...) -> VJson?
    
    func testItemOfTypeVariadic() {
        
        
        // Create a hierachy that will be tested, it should contain at least an object in an array in an object.
        let json = VJson()
        json["first"] &= 1
        json["array"][0] &= "a0"
        json["array"][1]["second"]["last"] &= "bottom"
        json["array"][2].add(VJson.null(), forName: "aNull")
        json["array"][2].add(VJson(3), forName: "anInteger")
        json["array"][2].add(VJson(true), forName: "aBool")
        json["array"][2].add(VJson("qwerty"), forName: "aString")
        
        // Test confirming cases
        
        if let first = json.item(of: VJson.JType.number, at: "first") {
            XCTAssert(first.isNumber)
            XCTAssertEqual(first.intValue!, 1)
        } else {
            XCTFail("First not found")
        }
        
        if let array = json.item(of: VJson.JType.array, at: "array") {
            XCTAssertTrue(array.isArray)
            XCTAssertEqual(array.nofChildren, 3)
        } else {
            XCTFail("Array not found")
        }
        
        if let string = json.item(of: VJson.JType.string, at: "array", "0") {
            XCTAssert(string.isString)
            XCTAssertEqual(string.stringValue!, "a0")
        } else {
            XCTFail("String not found")
        }
        
        if let object = json.item(of: VJson.JType.object, at: "array", "1") {
            XCTAssert(object.isObject)
            XCTAssertEqual(object.nofChildren, 1)
        } else {
            XCTFail("Object not found")
        }
        
        if let object = json.item(of: VJson.JType.object, at: "array", "1", "second") {
            XCTAssert(object.isObject)
            XCTAssertEqual(object.nofChildren, 1)
        } else {
            XCTFail("Second Object not found")
        }
        
        if let string = json.item(of: VJson.JType.string, at: "array", "1", "second", "last") {
            XCTAssert(string.isString)
            XCTAssertEqual(string.stringValue!, "bottom")
        } else {
            XCTFail("last String not found")
        }
        
        if let aNull = json.item(of: VJson.JType.null, at: "array", "2", "aNull") {
            XCTAssert(aNull.isNull)
        } else {
            XCTFail("aNull not found")
        }
        
        if let anInt = json.item(of: VJson.JType.number, at: "array", "2", "anInteger") {
            XCTAssert(anInt.isNumber)
            XCTAssertEqual(anInt.intValue!, 3)
        } else {
            XCTFail("anInt not found")
        }
        
        if let aBool = json.item(of: VJson.JType.bool, at: "array", "2", "aBool") {
            XCTAssert(aBool.isBool)
            XCTAssertTrue(aBool.boolValue!)
        } else {
            XCTFail("aBool not found")
        }
        
        if let aString = json.item(of: VJson.JType.string, at: "array", "2", "aString") {
            XCTAssert(aString.isString)
            XCTAssertEqual(aString.stringValue!, "qwerty")
        } else {
            XCTFail("aString not found")
        }
        
        // Test missing cases
        
        XCTAssertNil(json.item(of: VJson.JType.null, at: "array", "2"))
        XCTAssertNil(json.item(of: VJson.JType.bool, at: "array", "2"))
        XCTAssertNil(json.item(of: VJson.JType.number, at: "array", "2"))
        XCTAssertNil(json.item(of: VJson.JType.string, at: "array", "2"))
        XCTAssertNil(json.item(of: VJson.JType.object, at: "array", "0"))
        XCTAssertNil(json.item(of: VJson.JType.array, at: "first", "2"))
    }

    
    // Testing: public var description: String
    
    func testDescription() {
        
        // NULL
        XCTAssertEqual(VJson.null().description, "null")
        XCTAssertEqual(VJson.null("name").description, "null")
        
        // BOOL
        XCTAssertEqual(VJson(true).description, "true")
        XCTAssertEqual(VJson(false).description, "false")
        XCTAssertEqual(VJson(false, name: "name").description, "false")
        
        // NUMBER
        XCTAssertEqual(VJson(23).description, "23")
        XCTAssertEqual(VJson(23.45).description, "23.45")
        XCTAssertEqual(VJson(23.45, name: "name").description, "23.45")
        
        // STRING
        XCTAssertEqual(VJson("qwerty").description, "\"qwerty\"")
        XCTAssertEqual(VJson("qwerty", name: "name").description, "\"qwerty\"")
        
        // ARRAY
        var json = VJson.array()
        XCTAssertEqual(json.description, "[]")
        json.append(VJson(1))
        XCTAssertEqual(json.description, "[1]")
        json.append(VJson("qwerty"))
        XCTAssertEqual(json.description, "[1,\"qwerty\"]")

        // OBJECT
        json = VJson.object()
        XCTAssertEqual(json.description, "{}")
        json.add(VJson(true), forName: "name")
        XCTAssertEqual(json.description, "{\"name\":true}")
        json.add(VJson(45), forName: "num")
        XCTAssertEqual(json.description, "{\"name\":true,\"num\":45}")
        
        // ARRAY in OBJECT
        json = VJson()
        json["arr"][0] &= 1
        json["arr"][1] &= 2
        json["arr"][2] &= 3
        XCTAssertEqual(json.description, "{\"arr\":[1,2,3]}")
        
        // OBJECT in ARRAY
        json = VJson.array()
        json[0]["one"] &= 1
        json[0]["two"] &= 2
        json[2] &= false
        XCTAssertEqual(json.description, "[{\"one\":1,\"two\":2},null,false]")
    }
    
    
    // Testing: public var copy: VJson
    
    func testCopy() {
        
        
        // NULL
        var json = VJson.null()
        var cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isNull)
        
        json = VJson.null("qwerty")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isNull)
        XCTAssertEqual(cp.nameValue!, "qwerty")
        
        
        // BOOL
        json = VJson(true)
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isBool)
        XCTAssertTrue(cp.boolValue!)
        
        json = VJson(false, name: "qwerty")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isBool)
        XCTAssertFalse(cp.boolValue!)
        XCTAssertEqual(cp.nameValue!, "qwerty")

        
        // NUMBER
        json = VJson(45.67)
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isNumber)
        XCTAssertEqual(cp.doubleValue!, 45.67)
        
        json = VJson(45.67, name: "qwerty")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isNumber)
        XCTAssertEqual(cp.doubleValue!, 45.67)
        XCTAssertEqual(cp.nameValue!, "qwerty")
        
        
        // STRING
        json = VJson("string")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isString)
        XCTAssertEqual(cp.stringValue!, "string")
        
        json = VJson("string", name: "qwerty")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isString)
        XCTAssertEqual(cp.stringValue!, "string")
        XCTAssertEqual(cp.nameValue!, "qwerty")

        
        // ARRAY
        json = VJson.array()
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isArray)
        
        json = VJson.array("qwerty")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isArray)
        XCTAssertEqual(cp.nameValue!, "qwerty")

        json.append(VJson(2))
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isArray)
        XCTAssertEqual(cp.nameValue!, "qwerty")
        XCTAssertEqual(cp.nofChildren, json.nofChildren)
        XCTAssertFalse(cp.arrayValue![0] === json.arrayValue![0])
        XCTAssertTrue(cp.arrayValue![0] == json.arrayValue![0])

        
        // OBJECT
        json = VJson.object()
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isObject)
        
        json = VJson.object("qwerty")
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isObject)
        XCTAssertEqual(cp.nameValue!, "qwerty")
        
        json.add(VJson(2, name: "str"))
        cp = json.copy
        XCTAssertFalse(cp === json)
        XCTAssertTrue(cp.isObject)
        XCTAssertEqual(cp.nameValue!, "qwerty")
        XCTAssertEqual(cp.nofChildren, json.nofChildren)
        XCTAssertFalse(cp.arrayValue![0] === json.arrayValue![0])
        XCTAssertTrue(cp.arrayValue![0] == json.arrayValue![0])
    }
}
