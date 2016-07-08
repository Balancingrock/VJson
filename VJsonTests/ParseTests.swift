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
                let json = try VJson.parse(tc)
                XCTAssertEqual(tc, json.description)
            }
        } catch let error as VJson.ParseError {
            XCTFail("Parser test failed: \(error)")
        } catch {
            XCTFail("Test fail: \(error)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
