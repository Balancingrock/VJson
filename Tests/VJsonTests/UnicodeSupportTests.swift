//
//  UnicodeSupportTests.swift
//  VJsonTests
//
//  Created by Rien van der lugt on 01/07/2018.
//

import XCTest
import VJson

class UnicodeSupportTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJsonStringToString() {

        var jstr = "abcdef"
        var str = jstr.jsonStringToString()
        XCTAssertEqual(jstr, str)
        
        jstr = "ab\\\\cd"
        str = jstr.jsonStringToString()
        var exp = "ab\\cd"
        XCTAssertEqual(str, exp)
        
        jstr = "ab\\\"cd"
        str = jstr.jsonStringToString()
        exp = "ab\"cd"
        XCTAssertEqual(str, exp)
        
        jstr = "ab\\/cd"
        str = jstr.jsonStringToString()
        exp = "ab/cd"
        XCTAssertEqual(str, exp)

        jstr = "ab\\bcd"
        str = jstr.jsonStringToString()
        exp = "ab\u{08}cd"
        XCTAssertEqual(str, exp)

        jstr = "ab\\fcd"
        str = jstr.jsonStringToString()
        exp = "ab\u{0c}cd"
        XCTAssertEqual(str, exp)

        jstr = "ab\\ncd"
        str = jstr.jsonStringToString()
        exp = "ab\u{0a}cd"
        XCTAssertEqual(str, exp)

        jstr = "ab\\rcd"
        str = jstr.jsonStringToString()
        exp = "ab\u{0d}cd"
        XCTAssertEqual(str, exp)

        jstr = "ab\\tcd"
        str = jstr.jsonStringToString()
        exp = "ab\u{09}cd"
        XCTAssertEqual(str, exp)
        
        jstr = "ab\\uD83D\\uDE00cd"
        str = jstr.jsonStringToString()
        exp = "ab😀cd"
        XCTAssertEqual(str, exp)
    }
    
    func testStringToJsonString() {
        
        var str = "ab😀cd"
        var jstr = str.stringToJsonString()
        var exp = "ab\\uD83D\\uDE00cd"
        XCTAssertEqual(jstr, exp)
        
        str = "ab\"cd"
        jstr = str.stringToJsonString()
        exp = "ab\\\"cd"
        XCTAssertEqual(jstr, exp)
        
        str = "ab\\cd"
        jstr = str.stringToJsonString()
        exp = "ab\\\\cd"
        XCTAssertEqual(jstr, exp)

        str = "ab/cd"
        jstr = str.stringToJsonString()
        exp = "ab\\/cd"
        XCTAssertEqual(jstr, exp)

        str = "ab\u{08}cd"
        jstr = str.stringToJsonString()
        exp = "ab\\bcd"
        XCTAssertEqual(jstr, exp)

        str = "ab\u{0c}cd"
        jstr = str.stringToJsonString()
        exp = "ab\\fcd"
        XCTAssertEqual(jstr, exp)

        str = "ab\u{0a}cd"
        jstr = str.stringToJsonString()
        exp = "ab\\ncd"
        XCTAssertEqual(jstr, exp)

        str = "ab\u{0d}cd"
        jstr = str.stringToJsonString()
        exp = "ab\\rcd"
        XCTAssertEqual(jstr, exp)

        str = "ab\u{09}cd"
        jstr = str.stringToJsonString()
        exp = "ab\\tcd"
        XCTAssertEqual(jstr, exp)
    }
    
    func testUtf8Bug() {
        let str = "abécd"
        let jstr = str.stringToJsonString()
        let exp = "ab\\u00E9cd"
        XCTAssertEqual(jstr, exp)
    }
}
