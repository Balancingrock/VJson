//
//  KeyValueCodingTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 03/10/17.
//
//

#if os(macOS)

import XCTest
import VJson

class KeyValueCodingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testValue() {
        
        let json = VJson()
        json["one"][2] &= 1
        json["one"][1] &= true
        json["w"] &= (nil as Int?)
        json["arr"][3]["\u{08}two"]["five"] &= "Test"
        
        var val = json.value(forKey: "one.2")
        
        if val is Int {
            XCTAssertEqual((val as! Int), 1)
        } else {
            XCTFail("Wrong type returned")
        }
        
        val = json.value(forKey: "one.1")
        
        if val is Bool {
            XCTAssertEqual((val as! Bool), true)
        } else {
            XCTFail("Wrong type returned")
        }

        val = json.value(forKey: "arr.3.\u{08}two.five")
        
        if val is String {
            XCTAssertEqual((val as! String), "Test")
        } else {
            XCTFail("Wrong type returned")
        }

        val = json.value(forKey: "w")
        
        XCTAssertNil(val)

        // Manual test: not existing key throws exception
        //
        // val = try json.value(forKey: "two.five")
    }
    
    func testSetValue() {
                
        let json = VJson()
        json.undoManager = UndoManager()
        json["one"][1]["a"] &= "test"
        json["one"][2]["b"] &= 1
        json["one"][3]["😀"] &= true
        
        json.undoManager?.removeAllActions()
        
        json.setValue("qwerty", forKey: "one.1.a")
        json.setValue("3", forKey: "one.2.b")
        json.setValue("false", forKey: "one.3.😀")
        
        XCTAssertEqual((json|"one"|1|"a")!.stringValue!, "qwerty")
        XCTAssertEqual((json|"one"|2|"b")!.intValue!, 3)
        XCTAssertEqual((json|"one"|3|"😀")!.boolValue!, false)
        
        json.undoManager?.undo()
        
        XCTAssertEqual((json|"one"|1|"a")!.stringValue!, "test")
        XCTAssertEqual((json|"one"|2|"b")!.intValue!, 1)
        XCTAssertEqual((json|"one"|3|"😀")!.boolValue!, true)
        
    }
}

#endif
