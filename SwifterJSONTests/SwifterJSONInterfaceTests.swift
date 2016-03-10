//
//  SwifterJSONInterfaceTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 27/01/15.
//  Copyright (c) 2015 Marinus van der Lugt. All rights reserved.
//

import Cocoa
import XCTest

class SwifterJSONInterfaceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUpdateValue() {
        
        /*
        
        Test if updating a value produces the expected result. Only the function that takes a SwifterJSON value is tested as the others simply create a SwifterJSON object and call that operation to do the actual work. Creation of SwifterJSON objects is tested in "SwifterJSONInitTests.swift".
        
        */
        
        let json = JSON() // Start of wih a JSON NULL content
        
        
        // Show that there is nothing yet
        
        XCTAssert(json.count == 0, "Object should be empty")
        XCTAssertFalse(json.isObject, "Object should not yet be a JSON OBJECT")
        XCTAssertTrue(json.isNull, "Object should be a JSON NULL object")
        
        
        // Add 2 name/value pairs
        
        json.updateValue(SwifterJSON(true), forName: "name-true")
        json.updateValue(SwifterJSON(false), forName: "name-false")
        
        
        // Show that the object has changed into a JSON OBJECT and that the added pairs are present
        
        XCTAssertTrue(json.isObject, "Object should be a JSON OBJECT")
        XCTAssertFalse(json.isNull, "Object should no longer be a JSON NULL object")
        XCTAssert(json.count == 2, "Expected two objects in top")
        XCTAssertEqual(json["name-true"].boolValue!, true, "Expected value 'true' for 'name-true'")
        XCTAssertEqual(json["name-false"].boolValue!, false, "Expected value 'true' for 'name-false'")
        
        
        // Update one of the parameters to a string value
        
        json.updateValue(SwifterJSON("true"), forName: "name-true")
        
        
        // Show that the boolean has changed to a string
        
        XCTAssert(json.count == 2, "Expected two objects in top")
        XCTAssertEqual(json["name-true"].stringValue!, "true", "Expected value 'true' for 'name-true'")
        XCTAssertEqual(json["name-false"].boolValue!, false, "Expected value 'true' for 'name-false'")
        
        
        // Update one value and add one value using a dictionary with integers
        
        json.updateValues(["name-new":12,"name-false":13])


        // Show that the bool was changed into an integer and one integer was added
        
        XCTAssert(json.count == 3, "Expected two objects in top")
        XCTAssertEqual(json["name-true"].stringValue!, "true", "Expected value 'true' for 'name-true'")
        XCTAssertEqual(json["name-false"].intValue!, 13, "Expected value '13' for 'name-false'")
        XCTAssertEqual(json["name-new"].intValue!, 12, "Expected value '12' for 'name-new'")
    }
    
    func testRemoveItemWithName() {
        
        /*
        
        Test if a name/value pair is removed from a JSON OBJECT.
        Test that it produces nil on a non- JSON OBJECT.
        Test that it does not remove anything with the wrong name.
        
        */
        
        var json = JSON.createJSONHierarchy()
        
        
        // Show that there is nothing yet
        
        XCTAssert(json.count == 0, "Top level object should be empty")
        
        
        // Add 2 name/value pairs
        
        json.updateValue(true, forName: "name-true")
        json.updateValue(false, forName: "name-false")
        
        
        // Show that this is correct
        
        XCTAssert(json.count == 2, "Expected two objects in top")
        XCTAssertEqual(json["name-true"].boolValue!, true, "Expected value 'true' for 'name-true'")
        XCTAssertEqual(json["name-false"].boolValue!, false, "Expected value 'true' for 'name-false'")

        
        // Remove the first
        
        let deleted = json.removeItemWithName("name-true")
        if let delval = deleted?.boolValue {
            XCTAssertTrue(delval, "Expected true for the deleted value")
        } else {
            XCTFail("Deleted vale is not a JSON BOOL")
        }

        
        // Show that this is correct
        
        XCTAssert(json.count == 1, "Expected one objects in top")
        XCTAssertEqual(json["name-false"].boolValue!, false, "Expected value 'true' for 'name-false'")

        
        // Attempt to remove a non existing item
        
        XCTAssertNil(json.removeItemWithName("does-not-exist"), "Removing a non-existing name should be impossible")

        
        // Show that obj is unchanged
        
        XCTAssert(json.count == 1, "Expected one objects in top")
        XCTAssertEqual(json["name-false"].boolValue!, false, "Expected value 'true' for 'name-false'")

        
        // Show that removing from non-object is not possible (one example)
        
        json = JSON("test")
        
        
        // Attempt to remove a non existing item
        
        XCTAssertNil(json.removeItemWithName("does-not-exist"), "Removing from a non-OBJECT should be impossible")

        
        // Show that obj is unchanged

        XCTAssertEqual(json.stringValue!, "test", "Expected value 'test' for stringValue")

    }
    
    func testAppend() {
        
        /*
        
        Test if appending a value produces the expected result. Only the function that takes a SwifterJSON value is tested as the others simply create a SwifterJSON object and call that operation to do the actual work. Creation of SwifterJSON objects is tested in "SwifterJSONInitTests.swift".
        
        */

        let json = JSON()
        
        
        // Show that there is nothing yet
        
        XCTAssert(json.count == 0, "Object should be empty")
        XCTAssertFalse(json.isArray, "Object should not yet be a JSON ARRAY")
        XCTAssertTrue(json.isNull, "Object should be a JSON NULL object")

        
        // Append two values
        
        json.append("one")
        json.append(12)

        
        // Show that this is correct
        
        XCTAssertTrue(json.isArray, "Object should be a JSON ARRAY")
        XCTAssertFalse(json.isNull, "Object should not be a JSON NULL object")
        XCTAssert(json.count == 2, "Expected two objects in top")
        XCTAssertEqual(json[0].stringValue!, "one", "Expected value 'one' for the first entry")
        XCTAssertEqual(json[1].intValue!, 12, "Expected value '12' for second entry")

        
        // Add an array of objects
        
        json.append([true, false])
        
        
        // Show that this is correct
        
        XCTAssert(json.count == 4, "Expected four objects in top")
        XCTAssertEqual(json[0].stringValue!, "one", "Expected value 'one' for the first entry")
        XCTAssertEqual(json[1].intValue!, 12, "Expected value '12' for second entry")
        XCTAssertEqual(json[2].boolValue!, true, "Expected value 'true' for the third entry")
        XCTAssertEqual(json[3].boolValue!, false, "Expected value 'false' for the fourth entry")
    }
    
    func testRemoveItAtIndex() {
        
        /*
        
        Test that it does not work on non-ARAY objects.
        Test that it cannot remove non existing objects.
        Test that it removes an object.
        Test that the correct object was removed.
        
        */
        
        let json = JSON()
        
        
        var del = json.removeItemAtIndex(0)
        XCTAssertNil(del, "Cannot remove from a non-ARRAY")
        
        
        // Append two values
        
        let removedItem = SwifterJSON("one")
        json.append(removedItem)
        json.append(12)
        
        XCTAssertTrue(json.isArray, "Object should have changed into an array")
        
        
        // Show that this is correct
        
        XCTAssert(json.count == 2, "Expected two objects in top")
        XCTAssertEqual(json[0].stringValue!, "one", "Expected value 'one' for the first entry")
        XCTAssertEqual(json[1].intValue!, 12, "Expected value '12' for second entry")
        
        
        // Remove a non existing item
        
        del = json.removeItemAtIndex(6)
        XCTAssertNil(del, "Cannot remove from a not existing index")
        XCTAssert(json.count == 2, "Expected two objects in top")

        
        // Remove an existing index
        
        del = json.removeItemAtIndex(0)
        XCTAssertNotNil(del, "Remove should have been successful")
        XCTAssert(json.count == 1, "Expected one object in top")
        XCTAssert(del === removedItem, "Wrong item removed")
    }
    
    func testReplaceItem_AtIndex() {
        
        /*
        
        Test that it does not work on non-ARRAY objects.
        Test that it does not work on not-existing index.
        Test that it replaces the object at the end.
        Test that it replaces the object just before the end.
        
        */
        
        let json = JSON()
        let originalItem1 = JSON("first")
        let originalItem2 = JSON("second")
        let originalItem3 = JSON("third")
        let originalItem4 = JSON("fourth")
        let replaceItem1 = JSON(1)
        let replaceItem2 = JSON(2)
        
        
        // Show that nothing is replaced on a non-ARRAY
        
        XCTAssertNil(json.replaceItem(replaceItem1, atIndex: 0), "Should not have worked on non-ARRAY")
        
        
        // Append values
        
        json.append(originalItem1)
        json.append(originalItem2)
        json.append(originalItem3)
        json.append(originalItem4)
        
        XCTAssertTrue(json.isArray, "Object should have been converted into an array")
        
        
        // Show that this is correct
        
        XCTAssertEqual(json.count, 4, "Expected four objects")
        XCTAssert(json[0] === originalItem1, "Array content error")
        XCTAssert(json[1] === originalItem2, "Array content error")
        XCTAssert(json[2] === originalItem3, "Array content error")
        XCTAssert(json[3] === originalItem4, "Array content error")
        
        
        // Replace a non existing item
        
        XCTAssertNil(json.replaceItem(replaceItem1, atIndex: 4), "Deleting from non existing index should not be possible")
        
        
        // Replace an existing index
        
        _ = json.replaceItem(replaceItem1, atIndex: 2)
        _ = json.replaceItem(replaceItem2, atIndex: 3)
        XCTAssert(json[0] === originalItem1, "Array content error")
        XCTAssert(json[1] === originalItem2, "Array content error")
        XCTAssert(json[2] === replaceItem1, "Array content error")
        XCTAssert(json[3] === replaceItem2, "Array content error")
    }
    
    func testRemoveObject_forName_all() {
        
        /*
        
        Test cases to be examined:
        
        1) item = nil, forName = nil, all = Dont Care
        Expected result => Should not do anything
        
        2) item = not existing item, forName = nil, all = false
        Expected result => Should not do anything
        
        3) item = 1 existing item, forName = nil, all = true
        Expected result => 1 item removed.
        
        4) item = 3 existing items, forName = nil, all = false
        Expected result => 1 items removed.
        
        5) item = 1 existing items, forName = nil, all = true
        Expected result => 1 items removed.
        
        6) item = 3 existing items, forName = nil, all = true
        Expected result => 3 items removed.
        
        7) item = nil, forName = not existing item, all = false
        Expected result => Should not do anything
        
        8) item = nil, forName = 1 existing item, all = true
        Expected result => 1 item removed.
        
        9) item = nil, forName = 2 existing items, all = false
        Expected result => 1 items removed.
        
        10) item = nil, forName = 1 existing items, all = true
        Expected result => 1 items removed.
        
        11) item = nil, forName = 3 existing items, all = true
        Expected result => 3 items removed.
        
        12) item = 1 existing item, forName = other existing item, all = true
        Expected result => Nothing removed.
        
        13) item = 3 existing items, forName = same items, all = false
        Expected result => 1 item removed.
        
        14) item = 3 existing items, forName = same items, all = true
        Expected result => 3 items removed.
        
        */
        
        let item1 = JSON(1)
        let item2 = JSON(2)
        let item3 = JSON(3)
        let item4 = JSON(4)
        let item5 = JSON(5)
        let singleItem = JSON(true)

        
        func setUp() -> SwifterJSON {
            
            let json = SwifterJSON.createJSONHierarchy()
            
            json["array"][0] = item1
            json["array"][1] = item2
            json["array"][2] = item3
            json["array"][3] = item4
            json["array"][4] = item5
            json["item1"] = item1
            json["item2"] = item2
            json["item3"] = item3
            json["item4"] = item4
            json["item5"] = item5
            json["deep"]["item1"] = item1
            json["deep"]["item2"] = item2
            json["deep"]["item3"] = item3
            json["deep"]["item4"] = item4
            json["deep"]["item5"] = item5
            json["deep"]["single"] = singleItem
            
            return json
        }
        
        
        var json = setUp()
        
        
        // 1) item = nil, forName = nil, all = Dont Care
        // Expected result => Should not do anything

        
        XCTAssertEqual(json.removeObject(nil, forName: nil, all: true), -1, "return value should indicate parameter error")
        
        
        // 2) item = not existing item, forName = nil, all = false
        // Expected result => Should not do anything
        
        XCTAssertEqual(json.removeObject(JSON(), forName: nil, all: true), 0, "Operation should not remove anything")

        
        // 3) item = 1 existing item, forName = nil, all = true
        // Expected result => 1 item removed.
        
        XCTAssertNotNil(json["deep"]["single"].boolValue, "Object should exist")
        XCTAssertEqual(json.removeObject(singleItem, forName: nil, all: true), 1, "Operation should remove 1 item")
        XCTAssertNil(json["deep"]["single"].boolValue, "Object should not exist")
        
        
        // 4) item = 3 existing items, forName = nil, all = false
        // Expected result => 1 items removed.
        
        json = setUp()
        
        XCTAssert(json["array"][0] === item1 , "Object should exist")
        XCTAssert(json["item1"] === item1 , "Object should exist")
        XCTAssert(json["deep"]["item1"] === item1 , "Object should exist")
        XCTAssertEqual(json.removeObject(item1, forName: nil, all: false), 1, "Operation should remove 1 item")
        XCTAssert(json["array"][0] === item1 , "Object should exist")
        XCTAssertNil(json["item1"].intValue , "Object should no longer exist")
        XCTAssert(json["deep"]["item1"] === item1 , "Object should exist")

        
        // 5) item = 1 existing items, forName = nil, all = true
        // Expected result => 1 items removed.
        
        json = setUp()
        
        XCTAssert(json["array"][0] === item1 , "Object should exist")
        XCTAssert(json["item1"] === item1 , "Object should exist")
        XCTAssert(json["deep"]["item1"] === item1 , "Object should exist")
        XCTAssertEqual(json.removeObject(singleItem, forName: nil, all: true), 1, "Operation should remove 1 item")
        XCTAssert(json["deep"]["single"].intValue == nil , "Object should exist")

        
        // 6) item = 3 existing items, forName = nil, all = true
        // Expected result => 3 items removed.
        
        json = setUp()
        
        XCTAssert(json["array"][0] === item1 , "Object should exist")
        XCTAssert(json["item1"] === item1 , "Object should exist")
        XCTAssert(json["deep"]["item1"] === item1 , "Object should exist")
        XCTAssertEqual(json.removeObject(item1, forName: nil, all: true), 3, "Operation should remove 3 items")
        XCTAssertEqual(json["array"][0].intValue!, 2 , "Item with value 1 is removed, new item at this place is item 2")
        XCTAssertNil(json["item1"].intValue , "Object should no longer exist")
        XCTAssertNil(json["deep"]["item1"].intValue , "Object should no longerexist")

        
        // 7) item = nil, forName = not existing item, all = false
        // Expected result => Should not do anything
        
        json = setUp()
        
        XCTAssertEqual(json.removeObject(nil, forName: "none", all: true), 0, "Operation should not remove anything")

        
        // 8) item = nil, forName = 1 existing item, all = false
        // Expected result => 1 item removed.
        
        json = setUp()
        
        XCTAssertNotNil(json["deep"]["single"].boolValue, "Object should exist")
        XCTAssertEqual(json.removeObject(nil, forName: "single", all: false), 1, "Operation should remove 1 item")
        XCTAssertNil(json["deep"]["single"].boolValue, "Object should not exist")

        
        // 9) item = nil, forName = 2 existing items, all = false
        // Expected result => 1 items removed.
        
        json = setUp()
        
        XCTAssert(json["item1"].intValue == 1, "Object should exist")
        XCTAssert(json["deep"]["item1"].intValue == 1, "Object should exist")
        XCTAssertEqual(json.removeObject(nil, forName: "item1", all: false), 1, "Operation should remove 1 item")
        XCTAssert(json["item1"].intValue == nil, "Object should no longer exist")
        XCTAssert(json["deep"]["item1"].intValue == 1, "Object should exist")

        
        // 10) item = nil, forName = 1 existing items, all = true
        // Expected result => 1 items removed.
        
        json = setUp()
        
        XCTAssertEqual(json.removeObject(nil, forName: "single", all: true), 1, "Operation should remove 1 item")
        XCTAssertNil(json["deep"]["single"].boolValue, "Object should not exist")

        
        // 11) item = nil, forName = 2 existing items, all = true
        // Expected result => 2 items removed.
        
        json = setUp()
        
        XCTAssertEqual(json.removeObject(nil, forName: "item2", all: true), 2, "Operation should remove 2 item")

        
        // 12) item = 1 existing item, forName = other existing item, all = true
        // Expected result => Nothing removed.
        
        json = setUp()
        
        XCTAssertEqual(json.removeObject(item1, forName: "item2", all: true), 0, "Operation should not remove any items")

        
        // 13) item = 2 existing items, forName = same items, all = false
        // Expected result => 1 item removed.

        json = setUp()
        
        XCTAssertEqual(json.removeObject(item1, forName: "item1", all: false), 1, "Operation should remove 1 items")

        
        // 14) item = 2 existing items, forName = same items, all = true
        // Expected result => 2 items removed.

        json = setUp()
        
        XCTAssertEqual(json.removeObject(item1, forName: "item1", all: true), 2, "Operation should remove 2 items")
    }
    
    func testRemoveAllChildren() {
        
        var json = JSON()
        XCTAssertEqual(json.removeAllChildren(), 0, "No object can be removed")
        
        json = JSON.createJSONHierarchy()
        json.updateValues(["a":1,"b":2])
        XCTAssertEqual(json.count, 2, "Should contain 2 children")
        XCTAssertEqual(json.removeAllChildren(), 2, "All can be removed")
        XCTAssertEqual(json.count, 0, "Should not contain any children")

        json = JSON.createArray()
        json.append(["a","b"])
        XCTAssertEqual(json.count, 2, "Should contain 2 children")
        XCTAssertEqual(json.removeAllChildren(), 2, "All can be removed")
        XCTAssertEqual(json.count, 0, "Should not contain any children")
    }
    
    func testChangeObjectByAssignment() {
        
        let json = JSON()
        
        XCTAssertTrue(json.isNull, "Should be a NULL object")
        
        json.stringValue = "string"
        XCTAssertTrue(json.isString, "Should be a STRING object")
        
        json.intValue = 12
        XCTAssertTrue(json.isNumber, "Should be a NUMBER object")
        
        json.boolValue = true
        XCTAssertTrue(json.isBool, "Should be a BOOL object")
        
        json.doubleValue = 12.12
        XCTAssertTrue(json.isNumber, "Should be a NUMBER object")
        
        json.updateValueNull(forName: "a")
        XCTAssertTrue(json.isObject, "Should be an OBJECT object")
        
        json.append(true)
        XCTAssertTrue(json.isArray, "Should be an ARRAY object")
    }
    
    func testObjectAtPath() {
        
        /*
        
        Access an object existing object in an ARRAY.
        Access an object in a non-upper leven OBJECT.
        Try to access a non-existing object in an ARRAY.
        Try to access a non-existing object in a non-upper level OBJECT.
        
        */
        
        let arrayObject = SwifterJSON(12)
        let objectObject = SwifterJSON(true)
        
        let json = SwifterJSON.createJSONHierarchy()
        json["item1"].intValue = 12
        json["array"][2] = arrayObject
        json["deep"][3]["obj"] = objectObject
        
        XCTAssert(json.objectAtPath("array", "2") === arrayObject, "Expected item not found")
        XCTAssert(json.objectAtPath("deep", "3", "obj") === objectObject, "Expected item not found")
        XCTAssertNil(json.objectAtPath("array", "3", "all"), "There should be no item here")
        XCTAssertNil(json.objectAtPath("deep", "3", "all"), "There should be no item here")
        
        XCTAssertNotNil(json.objectAtPath("array", "0"), "There should be a null object here")
        XCTAssertEqual(json.removeObject(arrayObject, forName: nil, all: true), 1, "Item should be removed")
        XCTAssertNil(json.objectAtPath("array", "0"), "There should no object here")
    }
    
    func testDescription() {
        
        /*
        
        First test with subscript generated empty fields.
        Then remove the inserted objects and see if the generated objects are removed.
        
        */
        
        let arrayObject = SwifterJSON(12)
        let objectObject = SwifterJSON(true)
        
        let json = SwifterJSON.createJSONHierarchy()
        json["item1"].intValue = 12
        json["array"][2] = arrayObject
        json["deep"][3]["obj"] = objectObject

        var expectedString = "{\"deep\":[null,null,null,{\"obj\":true}],\"item1\":12,\"array\":[null,null,12]}"
        XCTAssertEqual(json.description, expectedString, "Unexpected json code")
        
        json.removeObject(arrayObject, forName: nil, all: true)
        json.removeObject(objectObject, forName: nil, all: true)
        
        expectedString = "{\"item1\":12}"
        XCTAssertEqual(json.description, expectedString, "Unexpected json code")
    }
    
    func testGenerator() {
        
        let json = SwifterJSON.createJSONHierarchy()
        json["one"].stringValue = "val_one"
        json["two"].stringValue = "val_two"
        
        var count = 0
        for v1 in json {
            if let str = v1.stringValue {
                if str == "val_one" || str == "val_two" { count++ }
            } else {
                XCTFail("Expected string value")
            }
        }
        XCTAssertEqual(count, 2, "Not all values generated")
        

        json[0].stringValue = "val_one"
        json[1].stringValue = "val_two"
        
        count = 0
        for v2 in json {
            if let str = v2.stringValue {
                if str == "val_one" || str == "val_two" { count++ }
            } else {
                XCTFail("Expected string value")
            }
        }
        XCTAssertEqual(count, 2, "Not all values generated")
    }
}
