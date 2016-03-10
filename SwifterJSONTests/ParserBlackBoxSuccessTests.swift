//
//  ParserBlackBoxSuccessTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 09/01/15.
//  Copyright (c) 2015 Marinus van der Lugt. All rights reserved.
//

import Cocoa
import XCTest


private var formatter: NSNumberFormatter?

private extension String {
    func toDouble() -> Double? {
        if formatter == nil {
            formatter = NSNumberFormatter()
            formatter!.decimalSeparator = "."
        }
        return formatter!.numberFromString(self)!.doubleValue
    }
}


class ParserBlackBoxSuccessTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testEmptyObject() {
        
        
        // Create source
        
        let source = "{}"
        
        
        // Parse the source
        
        let (top, error) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(top, "Expected non-nil top")
        XCTAssertNil(error, "Unexpected error message found")

        
        // Examine the content
        
        XCTAssertEqual(top!.count, 0, "Expected 0 pairs, found \(top!.count)")
    }
    
    func testString() {
        
        
        // Create source
        
        let sourceDict: Dictionary<String, String> = [
            "k01" : "string",          // "string"
            "k02" : "",                // ""
            "k03" : "\\nstring",       // "\nstring"
            "k04" : "string\\n",       // "string\n"
            "k05" : "\\\"",            // "\""
            "k06" : "\\\\",            // "\\"
            "k07" : "\\/",             // "\/"
            "k08" : "\\b",             // "\b"
            "k09" : "\\f",             // "\f"
            "k10" : "\\n",             // "\n"
            "k11" : "\\r",             // "\r"
            "k12" : "\\t",             // "\t"
            "k13" : "\\u1234",         // "\u1234"
            "k14" : "\\u5678",         // "\u5678"
            "k15" : "\\u90AB",         // "\u90AB"
            "k16" : "\\uCDEF",         // "\uCDEF"
            "k17" : "\\uabcd",         // "\uabcd"
            "k18" : "\\uef00"          // "\uef00"
        ]
        
        var source = "{"
        var count = 1
        for (key, value) in sourceDict {
            source += "\"\(key)\":\"\(value)\""
            if count < sourceDict.count { source += "," }
            count++
        }
        source += "}"
        
        // Parse the source
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content
        
        if let top = topOrNil {
        
            XCTAssertEqual(top.count, 18, "Expected 18 pairs, found \(top.count)")
            for (key, expectedValue) in sourceDict {
                if let value = top[key].stringValue {
                    XCTAssertEqual(value, expectedValue, "Expected '\(value)', found '\(expectedValue)'")
                } else {
                    XCTFail("Key/Value pair not found for key \(key)")
                }
            }
        }
    }
    
    func testInt() {
        
        
        // Create source
        
        let sourceDict = [
            "k01" : "0",
            "k02" : "1",
            "k03" : "2",
            "k04" : "3",
            "k05" : "4",
            "k06" : "5",
            "k07" : "6",
            "k08" : "7",
            "k09" : "8",
            "k10" : "9",
            "k11" : "100",
            "k12" : "-100"
        ]
        
        var source = "{"
        var count = 1
        for (key, value) in sourceDict {
            source += "\"\(key)\":\(value)"
            if count < sourceDict.count { source += "," }
            count++
        }
        source += "}"
        
        // Parse the source
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content
        
        if let top = topOrNil {
            
            XCTAssertEqual(top.count, 12, "Expected 12 pairs, found \(top.count)")
            for (key, expectedValue) in sourceDict {
                if let value = top[key].intValue {
                    XCTAssertEqual(value, Int(expectedValue), "Expected '\(value)', found '\(expectedValue)'")
                } else {
                    XCTFail("Key/Value pair not found for key \(key)")
                }
            }
        }
    }

    func testDouble() {
        
        
        // Create source
        
        let sourceDict = [
            "k01" : "1.0",
            "k02" : "-1.0",
            "k03" : "0.5",
            "k04" : "-0.5",
            "k05" : "1.0e-1",
            "k06" : "1.0E1",
            "k07" : "1.0e+1"
        ]
        
        var source = "{"
        var count = 1
        for (key, value) in sourceDict {
            source += "\"\(key)\":\(value)"
            if count < sourceDict.count { source += "," }
            count++
        }
        source += "}"
        
        // Parse the source
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content
        
        if let top = topOrNil {
            
            XCTAssertEqual(top.count, 7, "Expected 7 pairs, found \(top.count)")
            for (key, expectedValue) in sourceDict {
                if let value = top[key].doubleValue {
                    XCTAssertEqual(value, expectedValue.toDouble()!, "Expected '\(value)', found '\(expectedValue)'")
                } else {
                    XCTFail("Key/Value pair not found for key \(key)")
                }
            }
        }
    }
    
    func testBool() {
        
        
        // Create source
        
        let sourceDict = [
            "k01" : "true",
            "k02" : "false"
        ]
        
        var source = "{"
        var count = 1
        for (key, value) in sourceDict {
            source += "\"\(key)\":\(value)"
            if count < sourceDict.count { source += "," }
            count++
        }
        source += "}"
        
        // Parse the source
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content
        
        if let top = topOrNil {
            
            XCTAssertEqual(top.count, 2, "Expected 2 pairs, found \(top.count)")
            for (key, expectedValue) in sourceDict {
                if let value = top[key].boolValue {
                    XCTAssertEqual(value, expectedValue == "true", "Expected '\(value)', found '\(expectedValue)'")
                } else {
                    XCTFail("Key/Value pair not found for key \(key)")
                }
            }
        }
    }

    func testNull() {
        
        // Create source
        
        let sourceDict = [
            "k01" : "null"
        ]
        
        var source = "{"
        var count = 1
        for (key, value) in sourceDict {
            source += "\"\(key)\":\(value)"
            if count < sourceDict.count { source += "," }
            count++
        }
        source += "}"
        
        // Parse the source
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content
        
        if let top = topOrNil {
            
            XCTAssertEqual(top.count, 1, "Expected 1 pair, found \(top.count)")
            if let _ = top["k01"].nullValue {
                XCTAssertTrue(top["k01"].isNull, "Expected null value")
            } else {
                XCTFail("Key/Value pair not found for key 'k01'")
            }
        }
    }
    
    func testArray() {
        
        let source = "{\"key\":[1,2,3]}"
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)

        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content

        if let top = topOrNil {
            
            if let v = top["key"][0].intValue {
                XCTAssertEqual(v, 1, "Expected '1', found '\(v)'")
            } else {
                XCTFail("Could not read element 0")
            }

            if let v = top["key"][1].intValue {
                XCTAssertEqual(v, 2, "Expected '2', found '\(v)'")
            } else {
                XCTFail("Could not read element 1")
            }

            if let v = top["key"][2].intValue {
                XCTAssertEqual(v, 3, "Expected '3', found '\(v)'")
            } else {
                XCTFail("Could not read element 2")
            }

        } else {
            XCTFail("Top level object is nil")
        }
    }
    
    func testEmptyArrayInObjectInArray() {
        
        let source = "{\"key\":[1,{\"key\":[]},3]}"
        
        let (topOrNil, errorOrNil) = JSON._createJSONHierarchyFromString(source)
        
        
        // Standard nil/non-nil tests
        
        XCTAssertNotNil(topOrNil, "Expected non-nil top")
        if let error = errorOrNil { XCTFail("Unexpected error message found: \(error)") }
        
        
        // Examine the content
        
        if let top = topOrNil {
            
            if let v = top["key"][0].intValue {
                XCTAssertEqual(v, 1, "Expected '1', found '\(v)'")
            } else {
                XCTFail("Could not read element 0")
            }
            
            XCTAssertTrue(top["key"][1]["key"].isArray, "Expected an array")
            XCTAssertEqual(top["key"][1]["key"].count, 0, "Expected empty array")
            
            if let v = top["key"][2].intValue {
                XCTAssertEqual(v, 3, "Expected '3', found '\(v)'")
            } else {
                XCTFail("Could not read element 2")
            }
            
        } else {
            XCTFail("Top level object is nil")
        }

    }
}