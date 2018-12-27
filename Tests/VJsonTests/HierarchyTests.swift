//
//  HierarchyTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 03/10/17.
//
//

import XCTest
import VJson


class HierarchyTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    // Testing: public func item(ofType: JType, atPath path: String ...) -> VJson?
    //
    // This implicitly also tests the other function sin Hierarchy.swift
    
    func testItemOfTypeVariadic() {
        
        
        // Create a hierachy that will be tested, it should contain at least an object in an array in an object.
        let json = VJson()
        json["first"] &= 1
        json["array"][0] &= "a0"
        json["array"][1]["second"]["last"] &= "bottom"
        json["array"][2].add(VJson.null(), for: "aNull")
        json["array"][2].add(VJson(3), for: "anInteger")
        json["array"][2].add(VJson(true), for: "aBool")
        json["array"][2].add(VJson("qwerty"), for: "aString")
        
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
    
    func testItems() {
        
        let str = """
        {
            "one" : [
                {},{},{"two":12}
            ],
            "two" : 2,
            "one" : [
                1, 2, 3
            ],
            "two" : 22,
            "one" : [
                {}, {}, {"two":21}
            ]
        }
        """
        
        guard let json = VJson.parse(string: str, onError: nil) else { XCTFail(); return }
        
        let oneTwo = json.items(at: ["one","2","two"])
        
        XCTAssertEqual(oneTwo.count, 2)
        
        if oneTwo[0].intValue != 12 && oneTwo[0].intValue != 21 { XCTFail() }
        if oneTwo[1].intValue != 12 && oneTwo[1].intValue != 21 { XCTFail() }
    }
}
