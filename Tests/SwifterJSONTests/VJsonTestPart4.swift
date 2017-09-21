//
//  VJsonTestPart4.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 10/03/17.
//
//

import XCTest
@testable import VJson

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
        
        let num = NSNumber(value: 78)
        
        XCTAssert(num.intValue == 78)
        
        json?.setValue(num, forKey: "one")
        
        XCTAssertEqual(json?.code, "{\"one\":78}")
    }
    
    func testKeyValueCodingDeeper() {
        
        let json = VJson.parse(string: "{\"one\":{\"two\":\"three\"}}") { _,_,_ in XCTFail() }
        
        let a = json?.value(forKey: "one.two") as? String
        
        XCTAssertNotNil(a)
        XCTAssertEqual(a!, "three")
    }

}
