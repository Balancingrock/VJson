//
//  UndoRedoTests.swift
//  VJsonTests
//
//  Created by Marinus van der Lugt on 27/02/2019.
//

#if !os(Linux)

import XCTest
import VJson

class UndoRedoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNullUndoRedo() {
        
        let json = VJson.null()
        json.undoManager = UndoManager()
        
        XCTAssert(json.isNull)
        XCTAssert(json.name == nil)
        json.type = .bool
        
        XCTAssert(json.isBool)
        json.undoManager?.undo()
        
        XCTAssert(json.isNull)
        json.undoManager?.redo()
        
        XCTAssert(json.isBool)
        
        json.nameValue = "One"
        XCTAssert(json.name == "One")

        json.undoManager?.undo()

        XCTAssert(json.name == nil)
        
        json.nameValue = "One"

        json.undoManager?.removeAllActions()
        
        json.nameValue = "Two"
        json.undoManager?.undo()
        
        XCTAssert(json.name == "One")

        json.undoManager?.redo()
        
        XCTAssert(json.name == "Two")
    }
    
    func testBoolUndoRedo() {
        
        let json = VJson(true)
        json.undoManager = UndoManager()
        
        XCTAssert(json.isBool)
        XCTAssert(json.boolValue == true)
        
        json.boolValue = false
        
        XCTAssert(json.isBool)
        XCTAssert(json.boolValue == false)
        
        json.undoManager?.undo()
        
        XCTAssert(json.isBool)
        XCTAssert(json.boolValue == true)

        json.undoManager?.redo()
        
        XCTAssert(json.isBool)
        XCTAssert(json.boolValue == false)

        json.boolValue = nil
        
        XCTAssert(json.isNull)
        
        json.undoManager?.undo()
        
        XCTAssert(json.isBool)
        XCTAssert(json.boolValue == false)

        json.undoManager?.redo()

        XCTAssert(json.isNull)
    }
    
    func testNumberUndoRedo() {
        
        let json = VJson(5)
        json.undoManager = UndoManager()
        
        XCTAssert(json.isNumber)
        XCTAssert(json.intValue == 5)
        
        json.intValue = 3
        
        XCTAssert(json.isNumber)
        XCTAssert(json.intValue == 3)
        
        json.undoManager?.undo()
        
        XCTAssert(json.isNumber)
        XCTAssert(json.intValue == 5)
        
        json.undoManager?.redo()
        
        XCTAssert(json.isNumber)
        XCTAssert(json.intValue == 3)
        
        json.intValue = nil
        
        XCTAssert(json.isNull)
        
        json.undoManager?.undo()
        
        XCTAssert(json.isNumber)
        XCTAssert(json.intValue == 3)
        
        json.undoManager?.redo()
        
        XCTAssert(json.isNull)
    }

    func testStringUndoRedo() {
        
        let json = VJson("five")
        json.undoManager = UndoManager()
        
        XCTAssert(json.isString)
        XCTAssert(json.stringValue == "five")
        
        json.stringValue = "three"
        
        XCTAssert(json.isString)
        XCTAssert(json.stringValue == "three")
        
        json.undoManager?.undo()
        
        XCTAssert(json.isString)
        XCTAssert(json.stringValue == "five")
        
        json.undoManager?.redo()
        
        XCTAssert(json.isString)
        XCTAssert(json.stringValue == "three")
        
        json.stringValue = nil
        
        XCTAssert(json.isNull)
        
        json.undoManager?.undo()
        
        XCTAssert(json.isString)
        XCTAssert(json.stringValue == "three")
        
        json.undoManager?.redo()
        
        XCTAssert(json.isNull)
    }

    func testObjectUndoRedo() {
        
        let json = VJson.object()
        json.undoManager = UndoManager()
        
        json["one"] &= 1
        json["two"] &= 2
        
        XCTAssertEqual(json.nofChildren, 2)

        json.undoManager?.undo()
        
        XCTAssertEqual(json.nofChildren, 0)
        
        json.undoManager?.redo()
        
        XCTAssertEqual(json.nofChildren, 2)
        XCTAssert(json|"one" != nil )
        XCTAssert(json|"two" != nil )

        json.type = .null
        
        XCTAssert(json.isNull)
        
        json.undoManager?.undo()

        XCTAssertEqual(json.nofChildren, 2)
        XCTAssert(json|"one" != nil )
        XCTAssert(json|"two" != nil )
    }

    func testArrayUndoRedo() {
        
        let json = VJson.array()
        json.undoManager = UndoManager()
        
        json[1] &= 1
        json[2] &= 2
        
        XCTAssertEqual(json.nofChildren, 3)
        
        json.undoManager?.undo()
        
        XCTAssertEqual(json.nofChildren, 0)
        
        json.undoManager?.redo()
        
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssert(json[1].intValue == 1)
        XCTAssert(json[2].intValue == 2)
        
        json.type = .null
        
        XCTAssert(json.isNull)
        
        json.undoManager?.undo()
        
        XCTAssertEqual(json.nofChildren, 3)
        XCTAssert(json[1].intValue == 1)
        XCTAssert(json[2].intValue == 2)
    }

}

#endif
