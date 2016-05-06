//
//  VJsonTests.swift
//  VJsonTests
//
//  Created by Marinus van der Lugt on 06/05/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

import XCTest
@testable import VJson

class VJsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*    func testExample() {
     
     let top = VJson.createJsonHierarchy()
     top["books"][0]["title"].stringValue = "THHGTTG"
     let myJsonString = top.description
     
     // Use the above generated string to read JSON code
     
     let data = myJsonString.dataUsingEncoding(NSUTF8StringEncoding)!
     do {
     let json = try VJson.createJsonHierarchy(UnsafePointer<UInt8>(data.bytes), length: data.length)
     if let title = json["books"][0]["title"].stringValue {
     print("The title of the first book is: " + title)
     } else {
     print("The title of the first book in myJsonString was not found")
     }
     } catch let error as VJson.Exception {
     print(error.description)
     } catch {}
     }*/
    
    func testNull() {
        
        var json = VJson.createNull(name: nil)
        var expDesc = "null"
        let expStr = "null"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.asString, expStr)
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        
        json = VJson.createNull(name: "MyName")
        expDesc = "\"MyName\":null"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.asString, expStr)
        XCTAssertTrue(json.isNull)
        XCTAssertTrue(json.asNull)
        
        XCTAssertNil(json.stringValue)
        XCTAssertNil(json.boolValue)
        XCTAssertNil(json.integerValue)
        XCTAssertNil(json.doubleValue)
        XCTAssertNil(json.numberValue)
    }
    
    func testBool() {
        
        var json = VJson.createBool(value: false, name: nil)
        var expDesc = "false"
        var expStr = "false"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.asString, expStr)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.asBool)
        XCTAssertEqual(json.boolValue, false)
        
        json = VJson.createBool(value: true, name: "MyName")
        expDesc = "\"MyName\":true"
        expStr = "true"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.asString, expStr)
        XCTAssertTrue(json.isBool)
        XCTAssertTrue(json.asBool)
        XCTAssertEqual(json.boolValue, true)
        
        XCTAssertNil(json.stringValue)
        XCTAssertNil(json.nullValue)
        XCTAssertNil(json.integerValue)
        XCTAssertNil(json.doubleValue)
        XCTAssertNil(json.numberValue)
        
    }
    
    func testNumber() {
        
        var json = VJson.createNumber(value: true, name: nil)
        var expDesc = "1"
        var expStr = "1"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isNumber)
        XCTAssertNotNil(json.numberValue)
        XCTAssertEqual(json.numberValue?.boolValue, true)
        XCTAssertEqual(json.numberValue?.integerValue, 1)
        XCTAssertEqual(json.numberValue?.doubleValue, 1.0)
        XCTAssertEqual(json.asString, expStr)
        
        json = VJson.createNumber(value: false, name: "MyName")
        expDesc = "\"MyName\":0"
        expStr = "0"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isNumber)
        XCTAssertNotNil(json.numberValue)
        XCTAssertEqual(json.numberValue?.boolValue, false)
        XCTAssertEqual(json.numberValue?.integerValue, 0)
        XCTAssertEqual(json.numberValue?.doubleValue, 0.0)
        XCTAssertEqual(json.asString, expStr)
        
        XCTAssertNil(json.stringValue)
        XCTAssertNil(json.nullValue)
        XCTAssertNil(json.boolValue)
        
        json = VJson.createNumber(value: 2, name: nil)
        expDesc = "2"
        expStr = "2"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isNumber)
        XCTAssertNotNil(json.numberValue)
        XCTAssertEqual(json.numberValue?.boolValue, true)
        XCTAssertEqual(json.numberValue?.integerValue, 2)
        XCTAssertEqual(json.numberValue?.doubleValue, 2.0)
        XCTAssertEqual(json.asString, expStr)
        
        json = VJson.createNumber(value: 3.3, name: nil)
        expDesc = "3.3"
        expStr = "3.3"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isNumber)
        XCTAssertNotNil(json.numberValue)
        XCTAssertEqual(json.numberValue?.boolValue, true)
        XCTAssertEqual(json.numberValue?.integerValue, 3)
        XCTAssertEqual(json.numberValue?.doubleValue, 3.3)
        XCTAssertEqual(json.asString, expStr)
        
        json = VJson.createNumber(value: NSNumber(double: 4.4), name: nil)
        expDesc = "4.4"
        expStr = "4.4"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isNumber)
        XCTAssertNotNil(json.numberValue)
        XCTAssertEqual(json.numberValue?.boolValue, true)
        XCTAssertEqual(json.numberValue?.integerValue, 4)
        XCTAssertEqual(json.numberValue?.doubleValue, 4.4)
        XCTAssertEqual(json.asString, expStr)
    }
    
    func testString() {
        
        var json = VJson.createString(value: "strstr", name: nil)
        var expDesc = "\"strstr\""
        var expStr = "strstr"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.stringValue, expStr)
        XCTAssertEqual(json.asString, expStr)
        
        json = VJson.createString(value: "strstr", name: "MyName")
        expDesc = "\"MyName\":\"strstr\""
        expStr = "strstr"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.stringValue, expStr)
        XCTAssertEqual(json.asString, expStr)
        
        XCTAssertNil(json.numberValue)
        XCTAssertNil(json.nullValue)
        XCTAssertNil(json.boolValue)
        XCTAssertNil(json.integerValue)
        XCTAssertNil(json.doubleValue)
    }
    
    func testArray() {
        
        var json = VJson.createArray(name: nil)
        
        var expDesc = "[]"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertNil(json.nameValue)
        
        json = VJson.createArray(name: "MyName")
        
        expDesc = "\"MyName\":[]"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertNotNil(json.nameValue)
        
        XCTAssertNil(json.numberValue)
        XCTAssertNil(json.nullValue)
        XCTAssertNil(json.boolValue)
        XCTAssertNil(json.integerValue)
        XCTAssertNil(json.doubleValue)
        XCTAssertEqual(json.asString, "")
        
        json = VJson.createArray(withChildren: [VJson.createBool(value: true, name: nil)], name: nil)!
        expDesc = "[true]"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isArray)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertNil(json.nameValue)
        
        XCTAssertNil(VJson.createArray(withChildren: [VJson.createBool(value: true, name: "theBool")], name: "aBool"))
    }
    
    
    func testObject() {
        
        
        // 1: Name = nil, no content
        
        var json = VJson.createObject(name: nil)
        
        var expDesc = "{}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertNil(json.nameValue)
        
        XCTAssertNil(json.numberValue)
        XCTAssertNil(json.nullValue)
        XCTAssertNil(json.boolValue)
        XCTAssertNil(json.integerValue)
        XCTAssertNil(json.doubleValue)
        XCTAssertEqual(json.asString, "")
        
        
        // 2: Name is given, no content
        
        json = VJson.createObject(name: "MyName")
        
        expDesc = "\"MyName\":{}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertNotNil(json.nameValue)
        
        
        // 3: Name = nil, contains 1 BOOL
        
        var ch1 = VJson.createBool(value: true, name: "ch1")
        
        json = VJson.createObject(withChildren: [ch1], name: nil)!
        expDesc = "{\"ch1\":true}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertNil(json.nameValue)
        XCTAssertTrue(json["ch1"].boolValue!)
        
        
        // 3: Name = nil, contains 1 BOOL
        
        ch1 = VJson.createBool(value: true, name: "ch1")
        
        json = VJson.createObject(withChildren: [ch1], name: "obj")!
        expDesc = "\"obj\":{\"ch1\":true}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertNotNil(json.nameValue)
        XCTAssertTrue(json["ch1"].boolValue!)
    }
    
    func testHierarchy() {
        
        // 1: Empty hierarchy
        
        var json = VJson.createJsonHierarchy()
        
        var expDesc = "{}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertTrue(json.isObject)
        XCTAssertEqual(json.nofChildren, 0)
        XCTAssertNil(json.nameValue)
        
        XCTAssertNil(json.numberValue)
        XCTAssertNil(json.nullValue)
        XCTAssertNil(json.boolValue)
        XCTAssertNil(json.integerValue)
        XCTAssertNil(json.doubleValue)
        XCTAssertEqual(json.asString, "")
        
        
        // 2: Hierarchy with 1 bool
        
        json = VJson.createJsonHierarchy()
        
        json["ch1"].boolValue = true
        expDesc = "{\"ch1\":true}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        
        
        // 3: Hierarchy with 1 bool and 1 number
        
        json = VJson.createJsonHierarchy()
        
        json["ch1"].boolValue = true
        json["ch2"].integerValue = 3
        expDesc = "{\"ch1\":true,\"ch2\":3}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 2)
        
        
        // 4: Hierarchy with an empty array
        
        json = VJson.createJsonHierarchy()
        
        var arr = VJson.createArray(name: "arr")
        json.addChild(arr, forName: "arr")
        
        expDesc = "{\"arr\":[]}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        
        
        // 5: Hierarchy with an array with a bool
        // Note: This is not a valid JSON hierarchy construction, but the subscript accessor forces it to become valid by inserting "array" as the name for the array
        
        json = VJson.createJsonHierarchy()
        
        json[0].boolValue = true
        
        expDesc = "{\"array\":[true]}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["array"].nofChildren, 1)
        XCTAssertTrue(json["array"][0].boolValue!)
        XCTAssertTrue(json[0].boolValue!)
        
        
        // 6: Hierarchy with an array with a bool and a number
        // Note: This is not a valid JSON hierarchy construction, but the subscript accessor forces it to become valid by inserting "array" as the name for the array
        
        json = VJson.createJsonHierarchy()
        
        json[0].boolValue = true
        json[1].integerValue = 4
        
        expDesc = "{\"array\":[true,4]}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["array"].nofChildren, 2)
        XCTAssertTrue(json["array"][0].boolValue!)
        XCTAssertTrue(json[0].boolValue!)
        XCTAssertEqual(json["array"][1].integerValue!, 4)
        XCTAssertEqual(json[1].integerValue!, 4)
        
        
        // 7: Hierachy with an array containing an empty object without a name
        
        json = VJson.createJsonHierarchy()
        
        json[0] = VJson.createObject(name: nil)
        
        expDesc = "{\"array\":[{}]}"
        XCTAssertEqual(json.description, expDesc)
        
        
        // 8: Hierachy with an array containing an object with a bool
        
        json = VJson.createJsonHierarchy()
        
        json[0] = VJson.createObject(withChildren: [VJson.createBool(value: true, name: "ch1")], name: nil)!
        
        expDesc = "{\"array\":[{\"ch1\":true}]}"
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json[0].nofChildren, 1)
        XCTAssertTrue(json[0]["ch1"].boolValue!)
        
        
        // 9: Hierachy with an array containing an object with a bool, subscript creation
        
        json = VJson.createJsonHierarchy()
        
        json[0]["ch1"].boolValue = true
        
        expDesc = "{\"array\":[{\"ch1\":true}]}"
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json[0].nofChildren, 1)
        XCTAssertTrue(json[0]["ch1"].boolValue!)
        
        
        // 10: Hierachy with an array containing an object with a bool and a number, subscript creation
        
        json = VJson.createJsonHierarchy()
        
        json[0]["ch1"].boolValue = true
        json[0]["ch2"].integerValue = 4
        
        expDesc = "{\"array\":[{\"ch1\":true,\"ch2\":4}]}"
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json[0].nofChildren, 2)
        XCTAssertTrue(json[0]["ch1"].boolValue!)
        XCTAssertEqual(json[0]["ch2"].integerValue!, 4)
        
        
        // 11: Hierachy with an array containing an object with a bool and a number
        
        json = VJson.createJsonHierarchy()
        
        json[0] = VJson.createObject(withChildren: [VJson.createBool(value: true, name: "ch1"), VJson.createNumber(value: 4, name: "ch2")], name: nil)!
        
        expDesc = "{\"array\":[{\"ch1\":true,\"ch2\":4}]}"
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json[0].nofChildren, 2)
        XCTAssertTrue(json[0]["ch1"].boolValue!)
        XCTAssertEqual(json[0]["ch2"].integerValue!, 4)
        
        
        // 12: Hierarchy with an empty object
        
        json = VJson.createJsonHierarchy()
        
        json.addChild(VJson.createObject(name: "ch1"), forName: "ch1")
        
        expDesc = "{\"ch1\":{}}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["ch1"].nofChildren, 0)
        
        
        // 13: Hierarchy with an object with a bool in it
        
        json = VJson.createJsonHierarchy()
        
        json["ch1"]["b1"].boolValue = true
        
        expDesc = "{\"ch1\":{\"b1\":true}}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["ch1"].nofChildren, 1)
        XCTAssertTrue(json["ch1"]["b1"].boolValue!)
        
        
        // 14: Hierarchy with an object with a bool and a number in it
        
        json = VJson.createJsonHierarchy()
        
        json["ch1"]["b1"].boolValue = true
        json["ch1"]["i1"].integerValue = 5
        
        expDesc = "{\"ch1\":{\"b1\":true,\"i1\":5}}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["ch1"].nofChildren, 2)
        XCTAssertTrue(json["ch1"]["b1"].boolValue!)
        XCTAssertEqual(json["ch1"]["i1"].integerValue, 5)
        
        
        // 15: Hierarchy with an object with an array with an object with bool in it
        
        json = VJson.createJsonHierarchy()
        
        json["ch1"][0]["b1"].boolValue = true
        
        expDesc = "{\"ch1\":[{\"b1\":true}]}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["ch1"].nofChildren, 1)
        XCTAssertEqual(json["ch1"][0].nofChildren, 1)
        XCTAssertTrue(json["ch1"][0]["b1"].boolValue!)
        
        
        // 16: Hierarchy with an object with an array with an object with two bools in it
        
        json = VJson.createJsonHierarchy()
        
        json["ch1"][0]["b1"].boolValue = true
        json["ch1"][0]["b2"].boolValue = false
        
        expDesc = "{\"ch1\":[{\"b1\":true,\"b2\":false}]}"
        
        XCTAssertEqual(json.description, expDesc)
        XCTAssertEqual(json.nofChildren, 1)
        XCTAssertEqual(json["ch1"].nofChildren, 1)
        XCTAssertEqual(json["ch1"][0].nofChildren, 2)
        XCTAssertTrue(json["ch1"][0]["b1"].boolValue!)
        XCTAssertFalse(json["ch1"][0]["b2"].boolValue!)
        
        
        // 17: Hierarchy with an array with a created object with childeren in it
        
        json = VJson.createJsonHierarchy()
        
        arr = VJson.createArray(name: "arr")
        
        let obj = VJson.createObject(name: "obj")
        
        obj["b1"].boolValue = true
        obj["b2"].boolValue = false
        
        arr.appendChild(obj)
        
        json.addChild(arr, forName: "arr")
        
        expDesc = "{\"arr\":[{\"obj\":{\"b1\":true,\"b2\":false}}]}"
        
        XCTAssertEqual(json.description, expDesc)
    }
    
    func testExtraction() {
        
        let json = VJson.createJsonHierarchy()
        
        let arr = VJson.createArray(name: "arr")
        
        let obj = VJson.createObject(name: "obj")
        
        obj["b1"].boolValue = true
        obj["b2"].boolValue = false
        
        arr.appendChild(obj)
        
        json.addChild(arr, forName: "arr")
        
        let expDesc = "{\"arr\":[{\"obj\":{\"b1\":true,\"b2\":false}}]}"
        
        XCTAssertEqual(json.description, expDesc)
        
        var tst = json["arr"]
        
        XCTAssertTrue(tst.isArray)
        
        tst = json["arr"][0]
        
        XCTAssertTrue(tst.isObject)
        XCTAssertEqual(tst.nofChildren, 2)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}
