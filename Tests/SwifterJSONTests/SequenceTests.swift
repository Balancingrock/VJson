//
//  SequenceTests.swift
//  VJson
//
//  Created by Marinus van der Lugt on 04/10/17.
//
//

import XCTest
import VJson

class SequenceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Testing: Generator & Sequence
    
    func testGenerator() {
        
        // Itterate over NULL
        // Expected: Zero passes
        var json = VJson.null()
        for _ in json {
            XCTFail("NULL should not itterate")
        }
        
        // Itterate over BOOL
        // Expected: Zero passes
        json = VJson(true)
        for _ in json {
            XCTFail("BOOL should not itterate")
        }
        
        // Itterate over STRING
        // Expected: Zero passes
        json = VJson("qwerty")
        for _ in json {
            XCTFail("STRING should not itterate")
        }
        
        // Itterate over NUMBER
        // Expected: Zero passes
        json = VJson(1)
        for _ in json {
            XCTFail("NUMBER should not itterate")
        }
        
        // Itterate over empty ARRAY
        // Expected: Zero passes
        json = VJson.array()
        for _ in json {
            XCTFail("Empty ARRAY should not itterate")
        }
        
        // Itterate over empty OBJECT
        // Expected: Zero passes
        json = VJson.object()
        for _ in json {
            XCTFail("Empty OBJECT should not itterate")
        }
        
        // Itterate over ARRAY with two item
        json = VJson([VJson(1), VJson(2)])
        var found1 = false
        var found2 = false
        var loopCount = 0
        for j in json {
            if j.intValue! == 1 { found1 = true }
            if j.intValue! == 2 { found2 = true }
            loopCount += 1
        }
        if !(found1 && found2) {
            XCTFail("Missed at least one item")
        }
        if loopCount > 2 {
            XCTFail("Too many itterations")
        }
        
        // Itterate over OBJECT with two item
        json = VJson(items: ["one":VJson(1), "two":VJson(2)])
        found1 = false
        found2 = false
        loopCount = 0
        for j in json {
            if j.intValue! == 1 { found1 = true }
            if j.intValue! == 2 { found2 = true }
            loopCount += 1
        }
        if !(found1 && found2) {
            XCTFail("Missed at least one item")
        }
        if loopCount > 2 {
            XCTFail("Too many itterations")
        }
        
        // Itterate over an array but remove an item before the item is reached
        // Expected: The removed item should not be included in the loop
        let three = VJson(3)
        json = VJson([VJson(1), VJson(2), three])
        found1 = false
        found2 = false
        loopCount = 0
        for j in json {
            if j.intValue! == 1 { found1 = true; _ = json.remove(three) }
            if j.intValue! == 2 { found2 = true }
            loopCount += 1
        }
        if !(found1 && found2) {
            XCTFail("Missed at least one item")
        }
        if loopCount > 2 {
            XCTFail("Too many itterations")
        }
    }
}
