//
//  Bugfixes.swift
//  VJsonTests
//
//  Created by Rien van der lugt on 04/07/2018.
//

import XCTest
@testable import VJson


class Bugfixes: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testBugfix_0_13_1() {
        
        // This test will fail with 0.13.0
        
        var error: VJson.ParseError?
        let json = VJson.parse(string: "{\"th\\free\":3}", errorInfo: &error)
        
        XCTAssertEqual(json?.children?.items[0].nameValueRaw, "th\\free")
    }

}
