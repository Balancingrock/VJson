//
//  StringTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 04/10/17.
//
//

import XCTest
import VJson

class StringTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Testing: public var isString: Bool {...}
    
    func testIsString() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isString)
        
        let b = VJson(true)
        XCTAssertFalse(b.isString)
        
        let i = VJson(0)
        XCTAssertFalse(i.isString)
        
        let s = VJson("think")
        XCTAssertTrue(s.isString)
        
        let o = VJson.object()
        XCTAssertFalse(o.isString)
        
        let a = VJson.array()
        XCTAssertFalse(a.isString)
    }
    
    
    // Testing: stringValue
    
    func testStringValue() {
        
        // Create with no value and no name
        var str: String?
        var json = VJson(str)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asString, "null")
        XCTAssertNil(json.stringValue)
        XCTAssertFalse(json.hasName)
        
        // Create with no value and with name
        json = VJson(str, name: "qwerty")
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asString, "null")
        XCTAssertNil(json.stringValue)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Create with value and no name
        str = "qazwsx"
        json = VJson(str)
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qazwsx")
        XCTAssertEqual(json.stringValue!, "qazwsx")
        XCTAssertFalse(json.hasName)
        
        // Create with value and with name
        json = VJson(str, name: "qwerty")
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qazwsx")
        XCTAssertEqual(json.stringValue!, "qazwsx")
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Assign nil
        json = VJson("qwerty")
        json.stringValue = nil
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asString, "null")
        XCTAssertNil(json.stringValue)
        XCTAssertFalse(json.hasName)
        
        // Assign a string
        json = VJson("qwerty")
        json.stringValue = "qazwsx"
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qazwsx")
        XCTAssertEqual(json.stringValue!, "qazwsx")
        XCTAssertFalse(json.hasName)
        
        // Assign a string with a double-quote character in it
        str = "qa\"zwsx"
        json = VJson("qwerty")
        json.stringValue = str
        XCTAssertTrue(json.isString)
        XCTAssertEqual(json.asString, "qa\"zwsx")
        XCTAssertEqual(json.stringValue!, "qa\"zwsx")
        XCTAssertFalse(json.hasName)
        
        // Convert from NULL
        json = VJson.null()
        json.stringValue = "qwerty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNull)
        XCTAssertEqual(json.asString, "qwerty")
        XCTAssertEqual(json.stringValue!, "qwerty")
        
        // Do no longer raise fatal errors
        VJson.fatalErrorOnTypeConversion = false // Change manually to check if this works as expected
        
        // Convert from BOOL
        json = VJson(true)
        json.stringValue = "werty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isBool)
        XCTAssertEqual(json.asString, "werty")
        XCTAssertEqual(json.stringValue!, "werty")
        
        // Convert from NUMBER
        json = VJson(12)
        json.stringValue = "qerty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asString, "qerty")
        XCTAssertEqual(json.stringValue!, "qerty")
        
        // Convert from OBJECT
        json = VJson.object()
        json.stringValue = "qwrty"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isObject)
        XCTAssertEqual(json.asString, "qwrty")
        XCTAssertEqual(json.stringValue!, "qwrty")
        
        // Convert from ARRAY
        json = VJson.array()
        json.stringValue = "qwety"
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isArray)
        XCTAssertEqual(json.asString, "qwety")
        XCTAssertEqual(json.stringValue!, "qwety")
    }
    
    func testEscapeSequences() {
        
        let json = VJson("01234😀56789")
        XCTAssertEqual(json.stringValue, "01234😀56789")
        XCTAssertEqual(json.string, "01234\\uD83D\\uDE0056789")
        XCTAssertEqual(json.stringValuePrintable, "01234😀56789")
        
        json.stringValuePrintable = "0␈1␉2␊3␌4␍5"
        XCTAssertEqual(json.stringValuePrintable, "0␈1␉2␊3␌4␍5")
        XCTAssertEqual(json.string, "0\\b1\\t2\\n3\\f4\\r5")
        XCTAssertEqual(json.stringValue, "0\u{08}1\u{09}2\u{0A}3\u{0c}4\u{0d}5")
    }
}
