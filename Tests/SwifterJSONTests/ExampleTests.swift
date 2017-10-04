//
//  ExampleTests.swift
//  VJsonTests
//
//  Created by Marinus van der Lugt on 06/05/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

// Note: These test have been developped while inspecting the source code. I.e. white box testing. Goal has been to test all possible conditions such that a high percentage of code coverage is achieved. However some explicit tests have been omitted if the part to test is already tested excessively in other test cases.

import XCTest
@testable import VJson


class VJsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
    
        let top = VJson() // Create JSON hierarchy
        top["books"][0]["title"] &= "THHGTTG"
        let jsonCode = top.description
        
        do {
            let json = try VJson.parse(string: jsonCode)
            if let title = (json|"books"|0|"title")?.stringValue {
                XCTAssertEqual(title, "THHGTTG")
            } else {
                XCTFail("The title of the first book in the JSON code was not found")
            }
        } catch {
            XCTFail("Parser failed: \(error)")
        }
    }
    
}
