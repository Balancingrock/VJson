//
//  CodeTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 03/10/17.
//
//

import XCTest
import VJson

class CodeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCode() {
        
        // NULL
        XCTAssertEqual(VJson.null().code, "null")
        XCTAssertEqual(VJson.null("name").code, "\"name\":null")
        
        // BOOL
        XCTAssertEqual(VJson(true).code, "true")
        XCTAssertEqual(VJson(false).code, "false")
        XCTAssertEqual(VJson(false, name: "name").code, "\"name\":false")
        
        // NUMBER
        XCTAssertEqual(VJson(23).code, "23")
        XCTAssertEqual(VJson(23.45).code, "23.45")
        XCTAssertEqual(VJson(23.45, name: "name").code, "\"name\":23.45")
        
        // STRING
        XCTAssertEqual(VJson("qwerty").code, "\"qwerty\"")
        XCTAssertEqual(VJson("qwerty", name: "name").code, "\"name\":\"qwerty\"")
        
        // ARRAY
        var json = VJson.array()
        XCTAssertEqual(json.code, "[]")
        json.append(VJson(1))
        XCTAssertEqual(json.code, "[1]")
        json.append(VJson("qwerty"))
        XCTAssertEqual(json.code, "[1,\"qwerty\"]")
        
        // OBJECT
        json = VJson.object()
        XCTAssertEqual(json.code, "{}")
        json.add(VJson(true), for: "name")
        XCTAssertEqual(json.code, "{\"name\":true}")
        json.add(VJson(45), for: "num")
        XCTAssertEqual(json.code, "{\"name\":true,\"num\":45}")
        
        // ARRAY in OBJECT
        json = VJson()
        json["arr"][0] &= 1
        json["arr"][1] &= 2
        json["arr"][2] &= 3
        XCTAssertEqual(json.code, "{\"arr\":[1,2,3]}")
        
        // OBJECT in ARRAY
        json = VJson.array()
        json[0]["one"] &= 1
        json[0]["two"] &= 2
        json[2] &= false
        XCTAssertEqual(json.code, "[{\"one\":1,\"two\":2},null,false]")
    }
}
