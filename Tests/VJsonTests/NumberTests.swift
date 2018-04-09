//
//  NumberTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 03/10/17.
//
//

import XCTest
import VJson

class NumberTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    // Testing: public var isNumber: Bool {...}
    
    func testIsNumber() {
        
        let n = VJson.null()
        XCTAssertFalse(n.isNumber)
        
        let b = VJson(true)
        XCTAssertFalse(b.isNumber)
        
        let i = VJson(0)
        XCTAssertTrue(i.isNumber)
        
        let s = VJson("think")
        XCTAssertFalse(s.isNumber)
        
        let o = VJson.object()
        XCTAssertFalse(o.isNumber)
        
        let a = VJson.array()
        XCTAssertFalse(a.isNumber)
    }

    
    // Testing: numberValue, integerValue, doubleValue
    
    func testNumber() {
        
        // Create with no value and no name
        var num: NSNumber?
        var json = VJson(number: num)
        var exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        
        // Create with no value and with name
        json = VJson(number: num, name: "qwerty")
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Create with value and no name
        num = NSNumber(value: 32)
        json = VJson(number: num)
        exp = NSNumber(value: 32)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.numberValue!, exp)
        XCTAssertFalse(json.hasName)
        
        // Create with value and with name
        num = NSNumber(value: 32)
        json = VJson(number: num, name: "qwerty")
        exp = NSNumber(value: 32)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.numberValue!, exp)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Test NULL value as NUMBER
        json = VJson.null("qwerty")
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertTrue(json.hasName)
        XCTAssertEqual(json.nameValue, "qwerty")
        
        // Test BOOL(true) value as NUMBER
        json = VJson(true)
        exp = NSNumber(value: 1)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)
        
        // Test BOOL(false) value as NUMBER
        json = VJson(false)
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isBool)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)
        
        // Test STRING("12") value as NUMBER
        json = VJson("12")
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)
        
        // Test STRING("qwerty") value as NUMBER
        json = VJson("qwerty")
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isString)
        XCTAssertFalse(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        XCTAssertFalse(json.hasName)
        XCTAssertNil(json.nameValue)
        
        // Assign a NUMBER? = nil
        json = VJson(number: NSNumber(value: 45))
        num = nil
        json.numberValue = num
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertNil(json.numberValue)
        
        // Assign a NUMBER = 12
        json = VJson(number: NSNumber(value: 45))
        num = NSNumber(value: 12)
        json.numberValue = num
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.numberValue!, exp)
        
        // Assign a NUMBER with Int? = nil
        json = VJson(number: NSNumber(value: 45))
        var inum: Int?
        json.intValue = inum
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asInt, 0)
        XCTAssertNil(json.intValue)
        
        // Assign a NUMBER with Int? = 12
        json = VJson(number: NSNumber(value: 45))
        inum = 12
        json.intValue = inum
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asInt, 12)
        XCTAssertEqual(json.intValue!, 12)
        
        // Assign a NUMBER with Double? = nil
        json = VJson(number: NSNumber(value: 45))
        var dnum: Double?
        json.doubleValue = dnum
        exp = NSNumber(value: 0)
        XCTAssertTrue(json.isNull)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asDouble, 0.0)
        XCTAssertNil(json.doubleValue)
        
        // Assign a NUMBER with Double = 1.2
        json = VJson(number: NSNumber(value: 45))
        dnum = 12.0
        json.intValue = inum
        exp = NSNumber(value: 12)
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.asNumber, exp)
        XCTAssertEqual(json.asDouble, 12)
        XCTAssertEqual(json.doubleValue!, 12.0)
        
        // Test constructor Int
        json = VJson(Int(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt
        json = VJson(UInt(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int8
        json = VJson(Int8(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt8
        json = VJson(UInt8(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int16
        json = VJson(Int16(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt16
        json = VJson(UInt16(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int32
        json = VJson(Int32(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt32
        json = VJson(UInt32(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Int64
        json = VJson(Int64(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor UInt64
        json = VJson(UInt64(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Test constructor Float
        json = VJson(Float(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.doubleValue!, 12)
        
        // Test constructor Double
        json = VJson(Double(12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.doubleValue!, 12)
        
        // Test constructor NSNumber
        json = VJson(number: NSNumber(value: 12))
        XCTAssertTrue(json.isNumber)
        XCTAssertEqual(json.intValue!, 12)
        
        // Convert from NULL
        json = VJson.null()
        json &= 1
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isNull)
        XCTAssertEqual(json.asInt, 1)
        XCTAssertEqual(json.intValue!, 1)
        
        // Do no longer raise fatal errors
        VJson.fatalErrorOnTypeConversion = false // Change manually to check if this works as expected
        
        // Convert from BOOL
        json = VJson(true)
        json &= 12
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isBool)
        XCTAssertEqual(json.asInt, 12)
        XCTAssertEqual(json.intValue!, 12)
        
        // Convert from STRING
        json = VJson("true")
        json &= 23
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isString)
        XCTAssertEqual(json.asInt, 23)
        XCTAssertEqual(json.intValue!, 23)
        
        // Convert from OBJECT
        json = VJson.object()
        json &= 34
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isObject)
        XCTAssertEqual(json.asInt, 34)
        XCTAssertEqual(json.intValue!, 34)
        
        // Convert from ARRAY
        json = VJson.array()
        json &= 45
        XCTAssertTrue(json.isNumber)
        XCTAssertFalse(json.isArray)
        XCTAssertEqual(json.asInt, 45)
        XCTAssertEqual(json.intValue!, 45)
    }

}
