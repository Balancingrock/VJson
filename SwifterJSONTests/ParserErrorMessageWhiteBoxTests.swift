//
//  ParserErrorMessageWhiteBoxTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 16/01/15.
//  Copyright (c) 2015 Marinus van der Lugt. All rights reserved.
//

import Cocoa
import XCTest

class ParserErrorMessageWhiteBoxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllPossibleErrorMessagesSource() {
        
        let TEST_STRING = 0
        let EXPECTED_ERROR = 1
        
        let testCases: [[String]] = [
            ["",                            "Empty JSON source."],
            [" ",                           "No JSON code found, missing opening brace."],
            ["{ ",                          "Incomplete JSON code, missing ending brace."],
            [" q{}",                        "Expected '{', parsing aborted at line = 1, character = 2"],
            ["{q}",                         "Expected '}' or '\"', parsing aborted at line = 1, character = 2"],
            ["{\"k\":1,q",                  "Expected a name string to start '\"', parsing aborted at line = 1, character = 8"],
            ["{\"ke\\e\":12}",              "Expecting an escaped character, parsing aborted at line = 1, character = 6"],
            ["{\"ke\\uw\":12}",             "Expected a hexadecimal digit, parsing aborted at line = 1, character = 7"],
            ["{\"key\":12t}",               "Expected a comma ',' or object end '}', parsing aborted at line = 1, character = 10"],
            ["{\"key\":[12t}",              "Expected a comma ',' or object end ']', parsing aborted at line = 1, character = 11"],
            ["{\"key\"12}",                 "Expected a colon ':', parsing stopped at line = 1, character = 7"],
            ["{\"key\":12}q",               "Character occured after top level object end, parsing aborted at line = 1, character = 11"],
            ["{\"key\":[q",                 "Expected the start of a value or the closing brace of an empty array, parsing aborted at line = 1, character = 9"],
            ["{\"key\":q",                  "Expected the start of a value, parsing aborted at line = 1, character = 8"],
            ["{\"key\":[1,q",               "Expected the start of a value, parsing aborted at line = 1, character = 11"],
            ["{\"key\":\"val\\w\"",         "Expected an escaped character, parsing aborted at line = 1, character = 13"],
            ["{\"key\":\"val\\uw\"",        "Expected a hexadecimal digit, parsing aborted at line = 1, character = 14"],
            ["{\"key\":-t",                 "Expected a number, parsing aborted at line = 1, character = 9"],
            ["{\"key\":-0.t",               "Expected a number, parsing aborted at line = 1, character = 11"],
            ["{\"key\":-0et",               "Expected start of exponent, parsing aborted at line = 1, character = 11"],
            ["{\"key\":-0e+t",              "Expected a number, parsing aborted at line = 1, character = 12"],
            ["{\"key\":tkue",               "Expected 'r' of boolean true, parsing aborted at line = 1, character = 9"],
            ["{\"key\":trke",               "Expected 'u' of boolean true, parsing aborted at line = 1, character = 10"],
            ["{\"key\":truk",               "Expected 'e' of boolean true, parsing aborted at line = 1, character = 11"],
            ["{\"key\":fklse",              "Expected 'a' of boolean false, parsing aborted at line = 1, character = 9"],
            ["{\"key\":fakse",              "Expected 'l' of boolean false, parsing aborted at line = 1, character = 10"],
            ["{\"key\":falke",              "Expected 's' of boolean false, parsing aborted at line = 1, character = 11"],
            ["{\"key\":falsk",              "Expected 'e' of boolean false, parsing aborted at line = 1, character = 12"],
            ["{\"key\":nkl",                "Expected 'u' of null value, parsing aborted at line = 1, character = 9"],
            ["{\"key\":nukl",               "Expected 'l' of null value, parsing aborted at line = 1, character = 10"],
            ["{\"key\":nulk",               "Expected 'l' of null value, parsing aborted at line = 1, character = 11"]
        ]
        
        for testCase in testCases {
            let (top, error) = JSON.createJsonHierarchyFromString(testCase[TEST_STRING])
            XCTAssertNil(top, "Expected nil")
            XCTAssertNotNil(error, "Expected an error message, found nil")
            XCTAssertEqual(error!, testCase[EXPECTED_ERROR], "Expected '\(testCase[EXPECTED_ERROR])', found '\(error!)'")
        }
    }
}