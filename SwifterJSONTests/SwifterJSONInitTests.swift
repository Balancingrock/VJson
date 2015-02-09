//
//  SwifterJSONTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 26/01/15.
//  Copyright (c) 2015 Marinus van der Lugt. All rights reserved.
//

import Cocoa
import XCTest

class SwifterJSONInitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testInitNull() {
        
        /*
        
        Create a null object and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON NULL
        
        var json = JSON()
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "null"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertTrue(json.isNull(), "Expected true on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNotNil(json.nullValue, "Expected non-nil for nullValue")
        XCTAssertNotNil(json.rawValue, "Expected non-nil for rawValue")

        
        // Test content properties
        
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.nullValue!, true, "Expected true for nullValue!")
        XCTAssertEqual(json.rawValue!, "null", "Expected 'null' for rawValue")
        XCTAssertEqual(json.values()!.count, 1, "Expected 1 element in values")
        XCTAssert(json.values()![0] === json, "Expected values to contain 'json'")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }
    
    
    func testInitString() {
        
        /*
        
        Create a string object and check if the properties deliver the expected results
        
        */

        
        // Create the JSON STRING
        
        var json = JSON("string")
        
        
        // Test the description

        var result = json.description
        var expectedResult = "\"string\""
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties

        XCTAssertTrue(json.isString(), "Expected true on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity

        XCTAssertNotNil(json.stringValue, "Expected non-nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNotNil(json.rawValue, "Expected non-nil for rawValue")
        
        
        // Test content properties

        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.stringValue!, "string", "Expected 'string' for stringValue!")
        XCTAssertEqual(json.rawValue!, "string", "Expected 'string' for rawValue")
        XCTAssertEqual(json.values()!.count, 1, "Expected 1 element in values")
        XCTAssert(json.values()![0] === json, "Expected values to contain 'json'")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }

    
    func testInitInt() {
        
        /*
        
        Create a number object from integer and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON NUMBER (from int)

        var json = JSON(12)
        
        
        // Test the description

        var result = json.description
        var expectedResult = "12"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties

        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertTrue(json.isNumber(), "Expected true on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")

        
        // Test accessors validity

        XCTAssert(json.stringValue == nil, "Expected nil for stringValue")
        XCTAssert(json.intValue != nil, "Expected non-nil for intValue")
        XCTAssert(json.doubleValue != nil, "Expected non-nil for doubleValue")
        XCTAssert(json.boolValue == nil, "Expected nil for boolValue")
        XCTAssert(json.nullValue == nil, "Expected nil for nullValue")
        XCTAssert(json.rawValue != nil, "Expected non-nil for rawValue")
        
        
        // Test content properties

        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.intValue!, 12, "Expected '12' for intValue!")
        XCTAssertEqual(json.doubleValue!, 12.0, "Expected '12.0' for intValue!")
        XCTAssertEqual(json.rawValue!, "12", "Expected '12' for rawValue")
        XCTAssertEqual(json.values()!.count, 1, "Expected 1 element in values")
        XCTAssert(json.values()![0] === json, "Expected values to contain 'json'")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }

    
    func testInitDouble() {
        
        /*
        
        Create a number object from double and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON NUMBER (from double)
        
        var json = JSON(12.0)
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "12.0"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertTrue(json.isNumber(), "Expected true on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNotNil(json.doubleValue, "Expected non-nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNotNil(json.rawValue, "Expected non-nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.doubleValue!, 12.0, "Expected '12.0' for intValue!")
        XCTAssertEqual(json.rawValue!, "12.0", "Expected '12.0' for rawValue")
        XCTAssertEqual(json.values()!.count, 1, "Expected 1 element in values")
        XCTAssert(json.values()![0] === json, "Expected values to contain 'json'")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }
    
    
    func testInitNSNumber() {
        
        /*
        
        Create a number object from NSNumber and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON NUMBER (from NSNumber)
        
        var json = JSON(NSNumber(double: 12.0))
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "12"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertTrue(json.isNumber(), "Expected true on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNotNil(json.doubleValue, "Expected non-nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNotNil(json.rawValue, "Expected non-nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.doubleValue!, 12.0, "Expected '12.0' for intValue!")
        XCTAssertEqual(json.rawValue!, "12", "Expected '12.0' for rawValue")
        XCTAssertEqual(json.values()!.count, 1, "Expected 1 element in values")
        XCTAssert(json.values()![0] === json, "Expected values to contain 'json'")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }
    
    
    func testInitBool() {
        
        /*
        
        Create a bool object and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON BOOL
        
        var json = JSON(false)
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "false"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertTrue(json.isBool(), "Expected true on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNotNil(json.boolValue, "Expected non-nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNotNil(json.rawValue, "Expected non-nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.boolValue!, false, "Expected 'false' for intValue!")
        XCTAssertEqual(json.rawValue!, "false", "Expected 'false', for rawValue")
        XCTAssertEqual(json.values()!.count, 1, "Expected 1 element in values")
        XCTAssert(json.values()![0] === json, "Expected values to contain 'json'")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }
    
    func testCreateObject() {
        
        /*
        
        Create a JSON Hierarchy object (a JSON OBJECT) and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON hierarchy
        
        var json = JSON.createJSONHierarchy()
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "{}"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertTrue(json.isObject(), "Expected true on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssert(json.names() != nil, "Expected non-nil for names")  // XCTAssertNotNil does not work here
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 0, "Expected 0 element in values")
        XCTAssertEqual(json.names()!.count, 0, "Expected 0 element in values")
        XCTAssertEqual(json.count, 0, "Expected 0 elements")
    }
    
    func testCreateArray() {
        
        /*
        
        Create a JSON ARRAY object and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON ARRAY
        
        var json = JSON.createArray()
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "[]"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertTrue(json.isArray(), "Expected true on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")   // XCTAssertNotNil does not work here
        XCTAssert(json.values()!.count == 0, "Expected 0 element in values")
        XCTAssert(json.count == 0, "Expected 0 elements")
    }
    
    func testInitArrayString() {
        
        /*
        
        Create a JSON ARRAY object from an array of strings and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON ARRAY
        
        var json = JSON(["one","two"])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "[\"one\",\"two\"]"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertTrue(json.isArray(), "Expected true on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json[0].stringValue!, "one", "Expected 'one' for the first string")
        XCTAssertEqual(json[1].stringValue!, "two", "Expected 'two' for the second string")
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values")  // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].stringValue!, "one", "Expected values to contain 'one'")
        XCTAssertEqual(json.values()![1].stringValue!, "two", "Expected values to contain 'two'")
    }
    
    
    func testInitArrayInt() {
        
        /*
        
        Create a JSON ARRAY object from an array of integers and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON ARRAY
        
        var json = JSON([1, 2])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "[1,2]"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertTrue(json.isArray(), "Expected true on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json[0].intValue!, 1, "Expected '1' for the first number")
        XCTAssertEqual(json[1].intValue!, 2, "Expected '2' for the second number")
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].intValue!, 1, "Expected values to contain '1'")
        XCTAssertEqual(json.values()![1].intValue!, 2, "Expected values to contain '2'")
    }
    
    
    func testInitArrayDouble() {
        
        /*
        
        Create a JSON ARRAY object from an array of integers and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON ARRAY
        
        var json = JSON([1.1, 2.2])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "[1.1,2.2]"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertTrue(json.isArray(), "Expected true on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json[0].doubleValue!, 1.1, "Expected '1.1' for the first number")
        XCTAssertEqual(json[1].doubleValue!, 2.2, "Expected '2.2' for the second number")
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].doubleValue!, 1.1, "Expected values to contain '1.1'")
        XCTAssertEqual(json.values()![1].doubleValue!, 2.2, "Expected values to contain '2.2'")
    }
    
    
    func testInitArrayNSNumber() {
        
        /*
        
        Create a JSON ARRAY object from an array of NSNumbers and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON ARRAY
        
        var json = JSON([NSNumber(double: 1.1), NSNumber(double: 2.2)])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "[1.1,2.2]"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertTrue(json.isArray(), "Expected true on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json[0].doubleValue!, 1.1, "Expected '1.1' for the first number")
        XCTAssertEqual(json[1].doubleValue!, 2.2, "Expected '2.2' for the second number")
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].doubleValue!, 1.1, "Expected values to contain '1.1'")
        XCTAssertEqual(json.values()![1].doubleValue!, 2.2, "Expected values to contain '2.2'")
    }
    
    
    func testInitArrayBool() {
        
        /*
        
        Create a JSON ARRAY object from an array of booleans and check if the properties deliver the expected results
        
        */
        
        
        // Create the JSON ARRAY
        
        var json = JSON([true, false])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "[true,false]"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertFalse(json.isObject(), "Expected false on isObject")
        XCTAssertTrue(json.isArray(), "Expected true on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json[0].boolValue!, true, "Expected 'true' for the first bool")
        XCTAssertEqual(json[1].boolValue!, false, "Expected 'false' for the second bool")
        XCTAssertNil(json.names(), "Expected nil for names")
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].boolValue!, true, "Expected values to contain 'true'")
        XCTAssertEqual(json.values()![1].boolValue!, false, "Expected values to contain 'false'")
    }
    
    
    func testInitDictString() {
        
        /*
        
        Create a JSON OBJECT object from a dictionary of strings and check if the properties deliver the expected results
        
        Note: It is possible that these tests suddenly stop succeeding because the sequence of key/value pairs in a dictionary can change without notice.
        
        */
        
        
        // Create the JSON OBJECT
        
        var json = JSON(["n1":"val1", "n2":"val2"])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "{\"n1\":\"val1\",\"n2\":\"val2\"}"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertTrue(json.isObject(), "Expected true on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json["n1"].stringValue!, "val1", "Expected 'val1' for 'n1'")
        XCTAssertEqual(json["n2"].stringValue!, "val2", "Expected 'val2' for 'n2'")
        XCTAssert(json.names() != nil, "Expected nil for names") // XCTAssertNotNil does not work here
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssert(json.values()!.count == 2, "Expected 2 element in values")
        XCTAssert(json.values()![0].stringValue! == "val1", "Expected values to contain 'val1'")
        XCTAssert(json.values()![1].stringValue! == "val2", "Expected values to contain 'val2'")
        XCTAssert(json.names()!.count == 2, "Expected 2 element in values")
        XCTAssert(json.names()![0] == "n1", "Expected values to contain 'n1'")
        XCTAssert(json.names()![1] == "n2", "Expected values to contain 'n2'")
    }
    
    
    func testInitDictInt() {
        
        /*
        
        Create a JSON OBJECT object from a dictionary of integers and check if the properties deliver the expected results
        
        Note: It is possible that these tests suddenly stop succeeding because the sequence of key/value pairs in a dictionary can change without notice.
        
        */
        
        
        // Create the JSON OBJECT
        
        var json = JSON(["n1":1, "n2":2])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "{\"n1\":1,\"n2\":2}"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertTrue(json.isObject(), "Expected true on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json["n1"].intValue!, 1, "Expected '1' for 'n1'")
        XCTAssertEqual(json["n2"].intValue!, 2, "Expected '2' for 'n2'")
        XCTAssert(json.names() != nil, "Expected nil for names") // XCTAssertNotNil does not work here
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].intValue!, 1, "Expected values to contain '1'")
        XCTAssertEqual(json.values()![1].intValue!, 2, "Expected values to contain '2'")
        XCTAssertEqual(json.names()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.names()![0], "n1", "Expected values to contain 'n1'")
        XCTAssertEqual(json.names()![1], "n2", "Expected values to contain 'n2'")
    }
    
    
    func testInitDictDouble() {
        
        /*
        
        Create a JSON OBJECT object from a dictionary of doubles and check if the properties deliver the expected results
        
        Note: It is possible that these tests suddenly stop succeeding because the sequence of key/value pairs in a dictionary can change without notice.
        
        */
        
        
        // Create the JSON OBJECT
        
        var json = JSON(["n1":1.1, "n2":2.2])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "{\"n1\":1.1,\"n2\":2.2}"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertTrue(json.isObject(), "Expected true on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json["n1"].doubleValue!, 1.1, "Expected '1.1' for 'n1'")
        XCTAssertEqual(json["n2"].doubleValue!, 2.2, "Expected '2.2' for 'n2'")
        XCTAssert(json.names() != nil, "Expected nil for names") // XCTAssertNotNil does not work here
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].doubleValue!, 1.1, "Expected values to contain '1.1'")
        XCTAssertEqual(json.values()![1].doubleValue!, 2.2, "Expected values to contain '2.2'")
        XCTAssertEqual(json.names()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.names()![0], "n1", "Expected values to contain 'n1'")
        XCTAssertEqual(json.names()![1], "n2", "Expected values to contain 'n2'")
    }
    
    
    func testInitDictNSNumber() {
        
        /*
        
        Create a JSON OBJECT object from a dictionary of doubles and check if the properties deliver the expected results
        
        Note: It is possible that these tests suddenly stop succeeding because the sequence of key/value pairs in a dictionary can change without notice.
        
       */
        
        
        // Create the JSON OBJECT
        
        var json = JSON(["n1": NSNumber(double: 1.1), "n2": NSNumber(double: 2.2)])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "{\"n1\":1.1,\"n2\":2.2}"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertTrue(json.isObject(), "Expected true on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json["n1"].doubleValue!, 1.1, "Expected '1.1' for 'n1'")
        XCTAssertEqual(json["n2"].doubleValue!, 2.2, "Expected '2.2' for 'n2'")
        XCTAssert(json.names() != nil, "Expected nil for names") // XCTAssertNotNil does not work here
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].doubleValue!, 1.1, "Expected values to contain '1.1'")
        XCTAssertEqual(json.values()![1].doubleValue!, 2.2, "Expected values to contain '2.2'")
        XCTAssertEqual(json.names()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.names()![0], "n1", "Expected values to contain 'n1'")
        XCTAssertEqual(json.names()![1], "n2", "Expected values to contain 'n2'")
    }
    
    
    func testInitDictBool() {
        
        /*
        
        Create a JSON OBJECT object from a dictionary of booleans and check if the properties deliver the expected results
        
        Note: It is possible that these tests suddenly stop succeeding because the sequence of key/value pairs in a dictionary can change without notice.
        
        */
        
        
        // Create the JSON OBJECT
        
        var json = JSON(["n1": true, "n2": false])
        
        
        // Test the description
        
        var result = json.description
        var expectedResult = "{\"n1\":true,\"n2\":false}"
        XCTAssertEqual(result, expectedResult, "Description error")
        
        
        // Test type properties
        
        XCTAssertFalse(json.isString(), "Expected false on isString")
        XCTAssertFalse(json.isNumber(), "Expected false on isNumber")
        XCTAssertFalse(json.isBool(), "Expected false on isBool")
        XCTAssertFalse(json.isNull(), "Expected false on isNull")
        XCTAssertTrue(json.isObject(), "Expected true on isObject")
        XCTAssertFalse(json.isArray(), "Expected false on isArray")
        
        
        // Test accessors validity
        
        XCTAssertNil(json.stringValue, "Expected nil for stringValue")
        XCTAssertNil(json.intValue, "Expected nil for intValue")
        XCTAssertNil(json.doubleValue, "Expected nil for doubleValue")
        XCTAssertNil(json.boolValue, "Expected nil for boolValue")
        XCTAssertNil(json.nullValue, "Expected nil for nullValue")
        XCTAssertNil(json.rawValue, "Expected nil for rawValue")
        
        
        // Test content properties
        
        XCTAssertEqual(json.count, 2, "Expected 2 elements")
        XCTAssertEqual(json["n1"].boolValue!, true, "Expected 'true' for 'n1'")
        XCTAssertEqual(json["n2"].boolValue!, false, "Expected 'false' for 'n2'")
        XCTAssert(json.names() != nil, "Expected nil for names") // XCTAssertNotNil does not work here
        XCTAssert(json.values() != nil, "Expected non-nil for values") // XCTAssertNotNil does not work here
        XCTAssertEqual(json.values()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.values()![0].boolValue!, true, "Expected values to contain 'true'")
        XCTAssertEqual(json.values()![1].boolValue!, false, "Expected values to contain 'false'")
        XCTAssertEqual(json.names()!.count, 2, "Expected 2 element in values")
        XCTAssertEqual(json.names()![0], "n1", "Expected values to contain 'n1'")
        XCTAssertEqual(json.names()![1], "n2", "Expected values to contain 'n2'")
    }
}