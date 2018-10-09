//
//  ParseTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 07/07/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

import XCTest
@testable import VJson


class ParseTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParsingDescription() {

        let testcases: Array<String> = [
            "{}",
            "{\"one\":null}",
            "{\"one\":true}",
            "{\"one\":false}",
            "{\"one\":1}",
            "{\"one\":1.2}",
            "{\"one\":\"string\"}",
            "{\"one\":[]}",
            "{\"one\":[1]}",
            "{\"one\":[1,2]}",
            "{\"one\":{\"two\":2}}",
            "{\"one\":[1,2,{\"name\":{}}]}"
        ]
        
        do {
            for tc in testcases {
                let json = try VJson.parse(string: tc)
                if let json = json {
                    XCTAssertEqual(tc, json.description)
                } else {
                    XCTFail("Unexcpeted nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }
    
    func testAppleParsingDescription() {
        
        let testcases: Array<String> = [
            "{}",
            "{\"one\":null}",
            "{\"one\":0}",
            "{\"one\":1}",
            "{\"one\":1.2}",
            "{\"one\":\"string\"}",
            "{\"one\":[]}",
            "{\"one\":[1]}",
            "{\"one\":[1,2]}",
            "{\"one\":{\"two\":2}}",
            "{\"one\":[1,2,{\"name\":{}}]}"
        ]

        do {
            for tc in testcases {
                let tcd = (tc as NSString).data(using: String.Encoding.utf8.rawValue)!
                let json = try VJson.parseUsingAppleParser(tcd)
                XCTAssertEqual(tc, json.description)
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testVJsonParsingPerformance() {

        let jcode = "{" +
            "\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"value\":false}}}}}}}}}}," +
            "\"arr\":[[[[[[[[[[[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9]]]]]]]]]]]," +
            "\"nulls\":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]," +
            "\"trues\":[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]," +
            "\"falses\":[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]," +
            "\"twelve\":[12,12,12,12,12,12,12,12,12,12,12,12,12,12]," +
            "\"onethree\":[1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3]," +
            "\"onethreeE4\":[1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4]," +
            "\"negative\":[-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10]," +
            "\"strings\":[\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\"]" +
        "}"
        
        self.measure {
            var json: VJson?
            do {
                for _ in 1 ... 100 {
                    json = try VJson.parse(string: jcode)
                }
            } catch let error as VJson.ParseError {
                XCTFail("Parser test failed: \(error)")
            } catch {
                XCTFail("Test fail: \(error)")
            }
            XCTAssertNotNil(json)
        }
    }
    
    func testAppleParsingPerformance() {
        
        let jcodeStr: String = "{" +
            "\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"obj\":{\"value\":false}}}}}}}}}}," +
            "\"arr\":[[[[[[[[[[[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9]]]]]]]]]]]," +
            "\"nulls\":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]," +
            "\"trues\":[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]," +
            "\"falses\":[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]," +
            "\"twelve\":[12,12,12,12,12,12,12,12,12,12,12,12,12,12]," +
            "\"onethree\":[1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3,1.3]," +
            "\"onethreeE4\":[1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4,1.3e4]," +
            "\"negative\":[-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10,-1.3e-10]," +
            "\"strings\":[\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\",\"one\"]" +
        "}"
        let jcode: Data = (jcodeStr as NSString).data(using: String.Encoding.utf8.rawValue)!
        
        self.measure {
            var json: VJson?
            do {
                for _ in 1 ... 100 {
                    json = try VJson.parseUsingAppleParser(jcode)
                }
            } catch let error as VJson.ParseError {
                XCTFail("Parser test failed: \(error)")
            } catch {
                XCTFail("Test fail: \(error)")
            }
            XCTAssertNotNil(json)
        }
    }

    func testCachingDisabledPerformance1() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"one\":1,\"two\":2,\"three\":3}", errorInfo: &error)
        json?.enableCacheForObjects = false
        
        self.measure {
            for _ in 1 ... 1000 {
                for _ in 1 ... 2 {
                    let _ = json|"three"
                }
            }
        }
    }
    
    func testCachingDisabledPerformance2() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"oneone\":1,\"twotwo\":2,\"three\":3}", errorInfo: &error)
        json?.enableCacheForObjects = false
        
        self.measure {
            for _ in 1 ... 10000 {
                let _ = json|"three"
            }
        }
    }
    
    func testCachingDisabledPerformance3() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"three\":3}", errorInfo: &error)
        json?.enableCacheForObjects = false
        
        self.measure {
            for _ in 1 ... 10000 {
                let _ = json|"three"
            }
        }
    }
    
    func testCachingDisabledPerformance4() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"one\":1,\"two\":2,\"three\":3,\"four\":1,\"five\":2,\"six\":3}", errorInfo: &error)
        json?.enableCacheForObjects = false
        
        self.measure {
            for _ in 1 ... 10000 {
                let _ = json|"six"
            }
        }
    }


    func testCachingEnabledPerformance1() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"one\":1,\"two\":2,\"three\":3}", errorInfo: &error)
        
        self.measure {
            for _ in 1 ... 1000 {
                for _ in 1 ... 2 {
                    let _ = json|"three"
                }
                json?.enableCacheForObjects = true
            }
        }
    }
    
    func testCachingEnabledPerformance2() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"oneone\":1,\"twotwo\":2,\"three\":3}", errorInfo: &error)
        
        self.measure {
            for _ in 1 ... 10000 {
                let _ = json|"three"
            }
        }
    }
    
    func testCachingEnabledPerformance3() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"three\":3}", errorInfo: &error)
        
        self.measure {
            for _ in 1 ... 10000 {
                let _ = json|"three"
            }
        }
    }

    func testCachingEnabledPerformance4() {
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"one\":1,\"two\":2,\"three\":3,\"four\":1,\"five\":2,\"six\":3}", errorInfo: &error)
        
        self.measure {
            for _ in 1 ... 10000 {
                let _ = json|"six"
            }
        }
    }

    func testArrayTopLevel() {
        
        let testcases: Array<String> = [
            "[]",
            "[null]",
            "[true]",
            "[false]",
            "[1]",
            "[1.2]",
            "[\"string\"]",
            "[[]]",
            "[1,2]",
            "[{\"two\":2}]",
            "[1,2,{\"name\":{}}]"
        ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isArray)
                    XCTAssertEqual(tc, json.description)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }
    
    func testNullTopLevel() {
        
        let str = "null"
        
        do {
            if let json = try VJson.parse(string: str) {
                XCTAssertTrue(json.isNull)
                XCTAssertEqual(str, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }
    
    func testBoolTopLevel() {
        
        let testcases: Array<String> = [
            "true",
            "false",
        ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isBool)
                    XCTAssertEqual(tc, json.description)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testNumberTopLevel() {
        
        let testcases: Array<String> = [
            "1",
            "2.3",
            "-2.3",
            "2.3e-06",
            ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isNumber)
                    XCTAssertEqual(tc, json.code)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testStringTopLevel() {
        
        let str = "\"Some\""
        
        do {
            if let json = try VJson.parse(string: str) {
                XCTAssertTrue(json.isString)
                XCTAssertEqual(str, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testNamedNullTopLevelItem() {
        
        let str = "\"name\":null"
        
        do {
            if let json = try VJson.parse(string: str) {
                XCTAssertTrue(json.isNull)
                XCTAssertTrue(json.hasName)
                XCTAssertEqual(str, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }
    
    func testNamedBoolTopLevel() {
        
        let testcases: Array<String> = [
            "\"name\":true",
            "\"name\":false",
            ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isBool)
                    XCTAssertTrue(json.hasName)
                    XCTAssertEqual(tc, json.description)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testNamedNumberTopLevel() {
        
        let testcases: Array<String> = [
            "\"name\":1",
            "\"name\":2.3",
            "\"name\":-2.3",
            "\"name\":2.3e-06",
            ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isNumber)
                    XCTAssertTrue(json.hasName)
                    XCTAssertEqual(tc, json.code)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    
    func testNamedStringTopLevel() {
        
        let str1 = "\"name\":\"Some\""
        let str2 = "\"name\": \"Some\""
        let str3 = "\"name\" : \"Some\""
        let str4 = "\"name\" : \"Some\" "
        let str5 = " \"name\" : \"Some\" "

        
        do {
            if let json = try VJson.parse(string: str1) {
                XCTAssertTrue(json.isString)
                XCTAssertTrue(json.hasName)
                XCTAssertEqual(str1, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }

            if let json = try VJson.parse(string: str2) {
                XCTAssertTrue(json.isString)
                XCTAssertTrue(json.hasName)
                XCTAssertEqual(str1, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }

            if let json = try VJson.parse(string: str3) {
                XCTAssertTrue(json.isString)
                XCTAssertTrue(json.hasName)
                XCTAssertEqual(str1, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }

            if let json = try VJson.parse(string: str4) {
                XCTAssertTrue(json.isString)
                XCTAssertTrue(json.hasName)
                XCTAssertEqual(str1, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }
            
            if let json = try VJson.parse(string: str5) {
                XCTAssertTrue(json.isString)
                XCTAssertTrue(json.hasName)
                XCTAssertEqual(str1, json.code)
            } else {
                XCTFail("Unexpected nil returned")
            }

        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testNamedObjectTopLevel() {
        
        let testcases: Array<String> = [
            "\"name\":{}",
            "\"name\":{\"next\":false}",
            ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isObject)
                    XCTAssertTrue(json.hasName)
                    XCTAssertEqual(tc, json.description)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    
    func testNamedArrayTopLevel() {
        
        let testcases: Array<String> = [
            "\"\":[]",
            "\"name\":[]",
            "\"name\":[1,2,3]",
            ]
        
        do {
            for tc in testcases {
                if let json = try VJson.parse(string: tc) {
                    XCTAssertTrue(json.isArray)
                    XCTAssertTrue(json.hasName)
                    XCTAssertEqual(tc, json.description)
                } else {
                    XCTFail("Unexpected nil returned")
                }
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testEmptyTopLevel() {
        
        let str1 = ""
        let str2 = "    "
        
        
        do {
            var json = try VJson.parse(string: str1)
            XCTAssertNil(json)
            
            json = try VJson.parse(string: str2)
            XCTAssertNil(json)

        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }

    }
}
