//
//  VJsonTestPart4.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 10/03/17.
//
//

import XCTest
@testable import SwifterJSON

class VJsonTestPart4: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testKeyValueCodingNumber() {

        let json = VJson.parse(string: "{\"one\":12}") { _,_,_ in XCTFail() }
        
        let a = (json?.value(forKey: "one") as? NSNumber)?.intValue ?? -1
        
        XCTAssertEqual(a, 12)
        
        json?.setValue(NSNumber(value: 78), forKey: "one")
        
        XCTAssertEqual(json?.code, "{\"one\":78}")
    }
}
