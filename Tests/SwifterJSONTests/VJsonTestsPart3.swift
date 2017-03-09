//
//  VJsonTestsPart3.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 05/03/17.
//
//

import XCTest
@testable import SwifterJSON

class VJsonTestsPart3: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMergeNullNull() {
        
        let n1 = VJson.null()
        let n2 = VJson.null()
        
        n1.merge(with: n2)
        
        XCTAssert(n1.isNull)
        XCTAssert(n2.isNull)
    }

    func testMergeNullBool() {
        
        let n = VJson.null()
        let b = VJson(true)
        
        n.merge(with: b)
        
        XCTAssert(n.isBool)
        XCTAssert(n.boolValue == true)
        XCTAssert(n == b)
    }

    func testMergeNullNumber() {
        
        let n = VJson.null()
        let b = VJson(12)
        
        n.merge(with: b)
        
        XCTAssert(n.isNumber)
        XCTAssert(n.intValue == 12)
        XCTAssert(n == b)
    }
    
    func testMergeNullString() {
        
        let n = VJson.null()
        let s = VJson("str")
        
        n.merge(with: s)
        
        XCTAssert(n.isString)
        XCTAssert(n.stringValue == "str")
        XCTAssert(n == s)
    }

    func testMergeNullArray() {
        
        var n = VJson.null()
        let a = VJson.array()
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
        
        n = VJson.null()
        a.append(VJson(1))
        a.append(VJson(2, name: "two"))
        n.merge(with: a)

        XCTAssert(n.isArray)
        XCTAssert(n == a)
    }
    
    func testMergeNullObject() {
        
        let n = VJson.null()
        let o = VJson.object()
        
        o["one"] &= 1
        o["two"] &= 2
        
        n.merge(with: o)
        XCTAssert(n == o)
    }

    func testMergeBoolNull() {
        
        let n1 = VJson(true)
        let n2 = VJson.null()
        
        n1.merge(with: n2)
        
        XCTAssert(n1.isNull)
        XCTAssert(n2.isNull)
    }
    
    func testMergeBoolBool() {
        
        let n = VJson(false)
        let b = VJson(true)
        
        n.merge(with: b)
        
        XCTAssert(n == b)
    }
    
/*
     These test are only possible when type conversions are allowed
     
    func testMergeBoolNumber() {
        
        let n = VJson(true)
        let b = VJson(12)
        
        n.merge(with: b)
        
        XCTAssert(n == b)
    }
    
    func testMergeBoolString() {
        
        let n = VJson(false)
        let s = VJson("str")
        
        n.merge(with: s)
        
        XCTAssert(n == s)
    }
    
    func testMergeBoolArray() {
        
        var n = VJson(true)
        let a = VJson.array()
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
        
        n = VJson(false)
        a.append(VJson(1))
        a.append(VJson(2, name: "two"))
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
    }
    
    func testMergeBoolObject() {
        
        let n = VJson(true)
        let o = VJson.object()
        
        o["one"] &= 1
        o["two"] &= 2
        
        n.merge(with: o)
        XCTAssert(n == o)
    }*/

    func testMergeNumberNull() {
        
        let n1 = VJson(13)
        let n2 = VJson.null()
        
        n1.merge(with: n2)
        
        XCTAssert(n1.isNull)
        XCTAssert(n2.isNull)
    }
    
/*
    func testMergeNumberBool() {
        
        let n = VJson(13)
        let b = VJson(true)
        
        n.merge(with: b)
        
        XCTAssert(n.isBool)
        XCTAssert(n.boolValue == true)
        XCTAssert(n == b)
    }*/
    
    func testMergeNumberNumber() {
        
        let n = VJson(13)
        let b = VJson(12)
        
        n.merge(with: b)
        
        XCTAssert(n.isNumber)
        XCTAssert(n.intValue == 12)
        XCTAssert(n == b)
    }
    
/*
    func testMergeNumberString() {
        
        let n = VJson(14)
        let s = VJson("str")
        
        n.merge(with: s)
        
        XCTAssert(n.isString)
        XCTAssert(n.stringValue == "str")
        XCTAssert(n == s)
    }
    
    func testMergeNumberArray() {
        
        var n = VJson(4)
        let a = VJson.array()
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
        
        n = VJson.null()
        a.append(VJson(1))
        a.append(VJson(2, name: "two"))
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
    }
    
    func testMergeNumberObject() {
        
        let n = VJson(56, name: "list")
        let o = VJson.object("obj")
        
        o["one"] &= 1
        o["two"] &= 2
        
        n.merge(with: o)
        XCTAssert(n == o)
    }*/

    func testMergeStringNull() {
        
        let n1 = VJson("str")
        let n2 = VJson.null()
        
        n1.merge(with: n2)
        
        XCTAssert(n1.isNull)
        XCTAssert(n2.isNull)
    }
    
/*
    func testMergeStringBool() {
        
        let n = VJson("str", name: "yes")
        let b = VJson(true)
        
        n.merge(with: b)
        
        XCTAssert(n.isBool)
        XCTAssert(n.boolValue == true)
        XCTAssert(n == b)
    }
    
    func testMergeStringNumber() {
        
        let n = VJson("str")
        let b = VJson(12, name: "num")
        
        n.merge(with: b)
        
        XCTAssert(n.isNumber)
        XCTAssert(n.intValue == 12)
        XCTAssert(n == b)
    }*/
    
    func testMergeStringString() {
        
        let n = VJson("qqq", name: "11")
        let s = VJson("str")
        
        n.merge(with: s)
        
        XCTAssert(n.isString)
        XCTAssert(n.stringValue == "str")
        XCTAssert(n == s)
    }
    
/*
    func testMergeStringArray() {
        
        var n = VJson("str")
        let a = VJson.array()
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
        
        n = VJson.null()
        a.append(VJson(1))
        a.append(VJson(2, name: "two"))
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
    }
    
    func testMergeStringObject() {
        
        let n = VJson("str")
        let o = VJson.object()
        
        o["one"] &= 1
        o["two"] &= 2
        
        n.merge(with: o)
        XCTAssert(n == o)
    }*/

    func testMergeArrayNull() {
        
        let n1 = VJson.array()
        n1.append(VJson(1))
        let n2 = VJson.null()
        
        n1.merge(with: n2)
        
        XCTAssert(n1.isNull)
        XCTAssert(n2.isNull)
    }
    
/*
    func testMergeArrayBool() {
        
        let n = VJson.array()
        n.append(VJson(1))
        let b = VJson(true)
        
        n.merge(with: b)
        
        XCTAssert(n.isBool)
        XCTAssert(n.boolValue == true)
        XCTAssert(n == b)
    }
    
    func testMergeArrayNumber() {
        
        let n = VJson.array()
        n.append(VJson(1))
        let b = VJson(12)
        
        n.merge(with: b)
        
        XCTAssert(n.isNumber)
        XCTAssert(n.intValue == 12)
        XCTAssert(n == b)
    }
    
    func testMergeArrayString() {
        
        let n = VJson.array()
        n.append(VJson(1))
        let s = VJson("str")
        
        n.merge(with: s)
        
        XCTAssert(n.isString)
        XCTAssert(n.stringValue == "str")
        XCTAssert(n == s)
    }*/
    
    func testMergeArrayArray() {
        
        let n = VJson.null()
        n.append(VJson(1))
        n.append(VJson(2))
        n.append(VJson(3))
        let a = VJson.array()
        a.append(VJson(8))

        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n.nofChildren == 3)
        XCTAssert(n[0].intValue! == 8)
        XCTAssert(n[1].intValue! == 2)
        XCTAssert(n[2].intValue! == 3)
        
        a.append(VJson(9))
        a.append(VJson(10))
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n.nofChildren == 3)
        XCTAssert(n[0].intValue! == 8)
        XCTAssert(n[1].intValue! == 9)
        XCTAssert(n[2].intValue! == 10)

        a.append(VJson(11))
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n.nofChildren == 4)
        XCTAssert(n[0].intValue! == 8)
        XCTAssert(n[1].intValue! == 9)
        XCTAssert(n[2].intValue! == 10)
        XCTAssert(n[3].intValue! == 11)
    }

/*
    func testMergeArrayObject() {
        
        let n = VJson.null()
        n.append(VJson(1))
        let o = VJson.object()
        
        o["one"] &= 1
        o["two"] &= 2
        
        n.merge(with: o)
        XCTAssert(n == o)
    }*/

    
    func testMergeObjectNull() {
        
        let n1 = VJson.object()
        let n2 = VJson.null()
        
        n1.merge(with: n2)
        
        XCTAssert(n1.isNull)
        XCTAssert(n2.isNull)
    }
    
/*
    func testMergeObjectBool() {
        
        let n = VJson.object()
        let b = VJson(true)
        
        n.merge(with: b)
        
        XCTAssert(n.isBool)
        XCTAssert(n.boolValue == true)
        XCTAssert(n == b)
    }
    
    func testMergeObjectNumber() {
        
        let n = VJson.object()
        let b = VJson(12)
        
        n.merge(with: b)
        
        XCTAssert(n.isNumber)
        XCTAssert(n.intValue == 12)
        XCTAssert(n == b)
    }
    
    func testMergeObjectString() {
        
        let n = VJson.object()
        let s = VJson("str")
        
        n.merge(with: s)
        
        XCTAssert(n.isString)
        XCTAssert(n.stringValue == "str")
        XCTAssert(n == s)
    }
    
    func testMergeObjectArray() {
        
        var n = VJson.object()
        let a = VJson.array()
        
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
        
        n = VJson.null()
        a.append(VJson(1))
        a.append(VJson(2, name: "two"))
        n.merge(with: a)
        
        XCTAssert(n.isArray)
        XCTAssert(n == a)
    }*/
    
    func testMergeObjectObject() {
        
        var error: VJson.ParseError?
        var n = VJson.parse(string: "{\"1\":1}", errorInfo: &error)
        var o = VJson.parse(string: "{\"1\":2}", errorInfo: &error)
        
        n?.merge(with: o!)
        XCTAssert(n == o)
        
        n = VJson.parse(string: "{\"1\":1}", errorInfo: &error)
        o = VJson.parse(string: "{\"2\":2}", errorInfo: &error)
        var t = VJson.parse(string: "{\"1\":1,\"2\":2}", errorInfo: &error)

        n?.merge(with: o!)
        XCTAssert(n == t)
        
        n = VJson.parse(string: "{\"1\":1}", errorInfo: &error)
        o = VJson.parse(string: "{\"1\":3,\"2\":2}", errorInfo: &error)
        t = VJson.parse(string: "{\"1\":3,\"2\":2}", errorInfo: &error)
        
        n?.merge(with: o!)
        XCTAssert(n == t)

        n = VJson.parse(string: "{\"1\":\"1\",\"1\":\"2\",\"2\":\"2\"}", errorInfo: &error)
        o = VJson.parse(string: "{\"1\":\"3\",\"2\":\"2\"}", errorInfo: &error)
        t = VJson.parse(string: "{\"1\":\"3\",\"1\":\"2\",\"2\":\"2\"}", errorInfo: &error)
        
        n?.merge(with: o!)
        XCTAssert(n == t)
    }
}
