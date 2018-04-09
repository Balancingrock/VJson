//
//  AuxillaryFunctionsTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 27/09/17.
//
//

import XCTest
import VJson
import Ascii

class AuxillaryFunctionsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFindPossibleJsonCode() {
        
        let test1 = "xxxxxxxx" // None
        let test2 = "xx{xx}xx" // 2..5 (2,3)
        let test3 = "xxxx}xxx" // None
        let test4 = "xx{xxxxx" // None
        let test5 = "xx{x{}xx" // None
        let test6 = "{xxxxxx}" // 0..7 (0,7)
        let test7 = "\"{xx}\"xx" // None
        let test8 = "\"\\u{x}xxx" // None
        
        test1.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count)
            XCTAssertNil(res)
        }
        
        test2.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            if let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count) {
                XCTAssertEqual(res.first!, Ascii._BRACE_OPEN)
                XCTAssertEqual(res.count, 4)
            } else {
                XCTFail("Expected a valid range")
            }
        }
        
        test3.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count)
            XCTAssertNil(res)
        }

        test4.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count)
            XCTAssertNil(res)
        }

        test5.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count)
            XCTAssertNil(res)
        }

        test6.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            if let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count) {
                XCTAssertEqual(res.first!, Ascii._BRACE_OPEN)
                XCTAssertEqual(res.count, 8)
            } else {
                XCTFail("Expected a valid range")
            }
        }

        test7.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count)
            XCTAssertNil(res)
        }

        test8.withCString() {
            let ptr = UnsafeMutableRawPointer(mutating: $0)
            let res = VJson.findPossibleJsonCode(start: ptr, count: test1.utf8.count)
            XCTAssertNil(res)
        }
    }
}
