//
//  PipeOperatorTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 04/10/17.
//
//

import XCTest
import VJson

class PipeOperatorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    // Testing: public func | (lhs: VJson?, rhs: String?) -> VJson? {...}
    
    func testPipeVJsonString() {
        
        // Execute the string pipe operator on a VJson optional that is nil
        var json: VJson?
        XCTAssertNil(json|"top")
        
        // Execute the string pipe operator with a String optional that is nil
        json = VJson()
        json!["top"] &= 13
        var path: String?
        XCTAssertNil(json|path)
        
        // Execute the string pipe operator with a no-match path
        path = "bottom"
        XCTAssertNil(json|path)
        
        // Execute the string pipe operator with a single matched path
        json!["bottom"] &= 26
        XCTAssertEqual((json|"top")!.intValue!, 13)
        
        // Execute the string pipe operator with a multiple matched path
        json!.add(VJson(17), for: "top", replace: false)
        XCTAssertEqual(json!.nofChildren, 3)
    }
    
    
    // Testing: public func | (lhs: VJson?, rhs: Int?) -> VJson? {...}
    
    func testPipeVJsonInt() {
        
        // Execute the string pipe operator on a VJson optional that is nil
        var json: VJson?
        XCTAssertNil(json|"top")
        
        // Execute the string pipe operator with an Int optional that is nil
        json = VJson.array()
        json![1] &= 13
        var index: Int?
        XCTAssertNil(json|index)
        
        // Execute the string pipe operator with a no-match path
        index = 2
        XCTAssertNil(json|index)
        
        // Execute the string pipe operator with a matched path
        json![2] &= 26
        XCTAssertEqual((json|1)!.intValue!, 13)
    }
}
