//
//  ObjectTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 03/10/17.
//
//

import XCTest
import VJson


class ObjectTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    
    // Testing: public func children(withName: String) -> [VJson]
    
    func testChildren() {
        
        // Test: Empty OBJECT
        // Expected: Empty array
        var json = VJson.object()
        XCTAssertEqual(json.items(with: "qwerty").count, 0)
        
        // Test: Empty ARRAY
        // Expected: Empty array
        json = VJson.array()
        json.append(VJson(0))
        json.append(VJson(1))
        XCTAssertEqual(json.items(with: "qwerty").count, 0)
        
        // Test: Non empty OBJECT, name does not occur
        // Expected: Empty array
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "one"), replace: false)
        XCTAssertEqual(json.items(with: "qwerty").count, 0)
        
        // Test: Non empty OBJECT, name occurs twice
        // Expected: Empty array
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "one"), replace: false)
        XCTAssertEqual(json.items(with: "one").count, 2)
        XCTAssertEqual(json.items(with: "one")[0].intValue!, 1)
        XCTAssertEqual(json.items(with: "one")[1].intValue!, 3)
    }

    
    // Testing: public func add(_ child: VJson?, forName name: String? = nil, replace: Bool = true) -> VJson?
    
    func testAdd() {
        
        // Add a nil, do not specify a name and do not specify replace
        // Expected: Return nil and no change in the object
        var json = VJson.object()
        var a: VJson?
        json.add(a)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Add a value without a name, do not specify a name and do not specify replace
        // Expected: Return nil and no change in the object
        json = VJson.object()
        a = VJson(true)
        json.add(a)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Add a value with a name, do not specify a name and do not specify replace
        // Expected: Return added value and item added to the object
        json = VJson.object()
        a = VJson(true, name: "qwerty")
        json.add(a)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0], a)
        
        // Add a value without a name, specify a name and do not specify replace
        // Expected: Return added value and item added to the object, name of item changed to reflect the name it was added under
        json = VJson.object()
        a = VJson(true)
        json.add(a, for: "qwerty")
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0], a)
        XCTAssertEqual(json.arrayValue[0].nameValue!, "qwerty")
        
        // Add a value with a name, specify a different name and do not specify replace
        // Expected: Return added value and item added to the object, name of item changed to reflect the name it was added under
        json = VJson.object()
        a = VJson(true, name: "qazwsx")
        json.add(a, for: "qwerty")
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0], a)
        XCTAssertEqual(json.arrayValue[0].nameValue!, "qwerty")
        
        // Add two items under a different name and specify replace
        // Expected: Both items should be present
        json = VJson.object()
        a = VJson(1, name: "one")
        var b = VJson(2, name: "two")
        json.add(a, replace: true)
        json.add(b, replace: true)
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue[0], a)
        XCTAssertEqual(json.arrayValue[1], b)
        
        // Add two items under the same name and specify replace
        // Expected: Onlythe last item should be present
        json = VJson.object()
        a = VJson(1, name: "one")
        b = VJson(2, name: "one")
        json.add(a)
        json.add(b)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0], b)
        
        // Add two items under the same name and specify no replace
        // Expected: Both items should be present
        json = VJson.object()
        a = VJson(1, name: "one")
        b = VJson(2, name: "one")
        json.add(a, replace: false)
        json.add(b, replace: false)
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue[0], a)
        XCTAssertEqual(json.arrayValue[1], b)
        
        // Add a value with a name to a NULL item
        // Expected: Return added value, NULL changed to OBJECT, added item returned
        json = VJson.null()
        a = VJson(true, name: "qwerty")
        json.add(a)
        XCTAssertTrue(json.isObject)
        XCTAssertFalse(json.isNull)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0], a)
    }
    
    
    // Testing: public func removeChildrenWith(name: String) -> Bool
    
    func testRemoveChildrenWith() {
        
        // Test: Remove children from an empty object
        // Expected: No Change
        var json = VJson.object()
        XCTAssertEqual(json.removeItems(forName: "qwerty"), 0)
        XCTAssertEqual(json.nofChildren, 0)
        
        // Test: Use name for non-existing children
        // Expected: No Change
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "three"))
        XCTAssertEqual(json.removeItems(forName: "four"), 0)
        XCTAssertEqual(json.nofChildren, 3)
        
        // Test: Remove a single child
        // Expected: 1 Child removed
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "three"))
        XCTAssertEqual(json.removeItems(forName: "three"), 1)
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertEqual(json.arrayValue[0].intValue, 1)
        XCTAssertEqual(json.arrayValue[1].intValue, 2)
        
        // Test: Remove two childs
        // Expected: 2 Childs removed
        json = VJson.object()
        json.add(VJson(1, name: "one"))
        json.add(VJson(2, name: "two"))
        json.add(VJson(3, name: "one"), replace: false)
        XCTAssertEqual(json.removeItems(forName: "one"), 2)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0].intValue, 2)
        
        // Test: Try to remove a child from an ARRAY item
        // Expected: No change
        json = VJson.array()
        json.append(VJson(1, name: "one"))
        json.append(VJson(2, name: "two"))
        json.append(VJson(3, name: "one"))
        XCTAssertEqual(json.removeItems(forName: "two"), 0)
        XCTAssertEqual(json.nofChildren, 3)
    }

    func testFlatten_nop() {
        
        let txt =
            """
            {
                "one": 1,
                "two": 2
            }
            """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
        
        let exp = json!.code
        
        json!.flatten()
        
        XCTAssertEqual(json!.code, exp)
    }
    
    func testFlatten_object() {
        
        let txt =
        """
        {
            "one":1,
            "two":{"deep":5}
        }
        """
        
        let exp = """
        {"one":1,"two.deep":5}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten()
        
        XCTAssertEqual(json!.code, exp)
    }
    
    func testFlatten_array() {
        
        let txt =
        """
        {
            "one":1,
            "two":["deep",5]}
        }
        """
        
        let exp =
        """
        {"one":1,"two[0]":"deep","two[1]":5}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten()
        
        XCTAssertEqual(json!.code, exp)
    }

    func testFlatten_arrayKeepNo() {
        
        let txt =
        """
        {
            "one":1,
            "two":["deep",{"three":6}]}
        }
        """
        
        let exp =
        """
        {"one":1,"two[0]":"deep","two[1].three":6}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten(VJson.FlattenOptions.keepPrimitiveArray)
        
        XCTAssertEqual(json!.code, exp)
    }

    func testFlatten_arrayKeepYes() {
        
        let txt =
        """
        {
            "one":1,
            "two":["deep",5]}
        }
        """
        
        let exp =
        """
        {"one":1,"two":["deep",5]}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten(VJson.FlattenOptions.keepPrimitiveArray)
        
        XCTAssertEqual(json!.code, exp)
    }

    func testFlatten_arrayArrayKeepYes() {
        
        let txt =
        """
        {
            "one":1,
            "two":[[1, 2], 3]}
        }
        """
        
        let exp =
        """
        {"one":1,"two[0]":[1,2],"two[1]":3}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten(VJson.FlattenOptions.keepPrimitiveArray)
        
        XCTAssertEqual(json!.code, exp)
    }

    func testFlatten_arrayArray() {
        
        let txt =
        """
        {
            "one":1,
            "two":[[1, 2], 3]}
        }
        """
        
        let exp =
        """
        {"one":1,"two[0][0]":1,"two[0][1]":2,"two[1]":3}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten()
        
        XCTAssertEqual(json!.code, exp)
    }

    func testFlatten_arrayArrayReplace() {
        
        let txt =
        """
        {
            "one":1,
            "two":[[1, 2], 3]}
        }
        """
        
        let exp =
        """
        {"one":1,"two*0)*0)":1,"two*0)*1)":2,"two*1)":3}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten(.leftArray("*"), .rightArray(")"))
        
        XCTAssertEqual(json!.code, exp)
    }

    func testFlatten_arrayArrayDot() {
        
        let txt =
        """
        {
            "one":1,
            "two":[[1, 2], 3]}
        }
        """
        
        let exp =
        """
        {"one":1,"two.0.0":1,"two.0.1":2,"two.1":3}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)
                
        json!.flatten(.useDotArray, .separator("-"))
        
        XCTAssertEqual(json!.code, exp)
    }

    func testUnflattenNop() {
        
        let txt =
        """
        {
            "one":1,
            "two":2,
            "arr":[1,2,3]
        }
        """
        
        let exp =
        """
        {"one":1,"two":2,"arr":[1,2,3]}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)

        json!.unflatten()
        
        XCTAssertEqual(json!.code, exp)
    }
    
    func testUnflattenObj() {
        
        let txt =
        """
        {
            "one":1,
            "two.three":2,
            "arr":[1,2,3]
        }
        """
        
        let exp =
        """
        {"one":1,"arr":[1,2,3],"two":{"three":2}}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)

        json!.unflatten()
        
        XCTAssertEqual(json!.code, exp)
    }

    
    func testUnflattenObjObj() {
        
        let txt =
        """
        {
            "one":1,
            "two.three.four":2,
            "arr":[1,2,3]
        }
        """
        
        let exp =
        """
        {"one":1,"arr":[1,2,3],"two":{"three":{"four":2}}}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)

        json!.unflatten()
        
        XCTAssertEqual(json!.code, exp)
    }

    
    func testUnflattenArr() {
        
        let txt =
        """
        {
            "one":1,
            "two[2]":2,
            "arr":[1,2,3]
        }
        """
        
        let exp =
        """
        {"one":1,"arr":[1,2,3],"two":[null,null,2]}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)

        json!.unflatten()
        
        XCTAssertEqual(json!.code, exp)
    }

    
    func testUnflattenArrArr() {
        
        let txt =
        """
        {
            "one":1,
            "two[1][1]":2,
            "arr":[1,2,3]
        }
        """
        
        let exp =
        """
        {"one":1,"arr":[1,2,3],"two":[null,[null,2]]}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)

        json!.unflatten()
        
        XCTAssertEqual(json!.code, exp)
    }

    func testUnflattenArrObjArr() {
        
        let txt =
        """
        {
            "one":1,
            "two[1].obj[1]":2,
            "arr":[1,2,3]
        }
        """
        
        let exp =
        """
        {"one":1,"arr":[1,2,3],"two":[null,{"obj":[null,2]}]}
        """
        
        let json = try? VJson.parse(string: txt)
        
        XCTAssertNotNil(json)

        json!.unflatten()
        
        XCTAssertEqual(json!.code, exp)
    }

}
