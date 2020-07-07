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
        
        var error = VJson.ParseError()
        let json = VJson.parse(string: "{\"th\\free\":3}", errorInfo: &error)
        
        XCTAssertEqual(json?.children?.items[0].name, "th\\free")
    }

    func testBugfix_0_13_2() {
        
        // This test will fail with 0.13.0 and 0.13.1
        
        var error = VJson.ParseError()
        let json = VJson.parse(string: "{\"th\\uD83D\\uDE00ree\":3}", errorInfo: &error)
        
        XCTAssertEqual(json?.children?.items[0].name, "th\\uD83D\\uDE00ree")
    }
    
    func testBugfix_0_13_3() {
        
        // This test will fail (crash on assert) with < 0.13.3
        
        let json = VJson()
        json["name"] &= "content"
        let child = json["name"]
        XCTAssertEqual(child.nameValue, "name")
        
        json.undoManager = UndoManager()
        
        child.nameValue = "new"
        XCTAssertEqual(child.nameValue, "new")
        
        #if os(macOS)

        json.undoManager?.undo()
        
        XCTAssertEqual(child.nameValue, "name")
        
        #endif
        
        
        // Extra test on removing a name from root object
        
        let root = VJson("content", name: "name")
        
        root.undoManager = UndoManager()
        
        XCTAssertEqual(root.nameValue, "name")
        root.nameValue = nil
        XCTAssertNil(root.nameValue)
        
        #if os(macOS)

        root.undoManager?.undo()
        
        XCTAssertEqual(root.nameValue, "name")

        #endif
        
        
        // Extra test on removing a name from a child object
        
        let array = VJson.array()
        let element = VJson("content", name: "name")
        array.append(element)
        XCTAssertEqual(array[0].nameValue, "name")
        array.undoManager = UndoManager()

        array[0].nameValue = nil
        XCTAssertNil(array[0].nameValue)
        
        #if os(macOS)

        array.undoManager?.undo()
        XCTAssertEqual(array[0].nameValue, "name")
        
        #endif
    }
}
