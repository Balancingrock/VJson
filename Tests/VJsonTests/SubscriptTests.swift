//
//  SubscriptTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 04/10/17.
//
//

import XCTest
import VJson

class SubscriptTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    // Testing: public subscript(index: Int) -> VJson
    // Note: Subscript accessors should only be used for the creation of a JSON hierarchy, not for interrogation or reading. Side effects are not tested.
    
    func testSubscriptInt() {
        
        // Create an item in an ARRAY
        // Expected: An array with three values, dummy values are created
        var json = VJson.array()
        json[2] &= 2
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.arrayValue[0].isNull)
        XCTAssertTrue(json.arrayValue[1].isNull)
        XCTAssertEqual(json.arrayValue[2].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNull)
        XCTAssertTrue(json[2].isNumber)
        
        // Check type conversion from NULL
        json = VJson.null()
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue[0].isNull)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)
        
        // Switch fatal errors on type conversion off
        VJson.fatalErrorOnTypeConversion = false        // Manually switch on/off for effect
        
        // Check type conversion from BOOL
        json = VJson(true)
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue[0].isNull)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)
        
        // Check type conversion from NUMBER
        json = VJson(4)
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue[0].isNull)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)
        
        // Check type conversion from STRING
        json = VJson("qwerty")
        json[1] &= 2
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssertTrue(json.arrayValue[0].isNull)
        XCTAssertEqual(json.arrayValue[1].intValue!, 2)
        XCTAssertTrue(json[0].isNull)
        XCTAssertTrue(json[1].isNumber)
        
        // Check type conversion from OBJECT
        json = VJson(items: ["one" : VJson(1), "two" : VJson(2)])
        json[2] &= true
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertTrue(json.arrayValue[0].isNumber)
        XCTAssertTrue(json.arrayValue[1].isNumber)
        XCTAssertTrue(json.arrayValue[2].boolValue!)
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
        XCTAssertEqual(json.arrayValue[0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from NULL
        json = VJson.null()
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Switch fatal errors on type conversion off
        VJson.fatalErrorOnTypeConversion = false        // Manually switch on/off for effect
        
        // Check type conversion from BOOL
        json = VJson(true)
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from NUMBER
        json = VJson(4)
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from STRING
        json = VJson("qwerty")
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json.arrayValue[0].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
        
        // Check type conversion from ARRAY
        json = VJson([VJson(1), VJson(2)])
        json["two"] &= 2
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssertEqual(json.arrayValue[2].intValue!, 2)
        XCTAssertTrue(json["two"].isNumber)
    }
}
