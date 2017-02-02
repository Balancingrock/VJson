//
//  ParseTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 07/07/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

import XCTest

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
                XCTAssertEqual(tc, json.description)
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
                for _ in 1 ... 1000 {
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
        
        let jcode = ("{" +
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
        "}" as NSString).data(using: String.Encoding.utf8.rawValue)!
        
        self.measure {
            var json: VJson?
            do {
                for _ in 1 ... 1000 {
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


}
