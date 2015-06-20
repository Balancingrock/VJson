// =====================================================================================================================
//
//  File:       SwifterJSON.swift
//  Project:    SwifterJSON
//
//  Version:    0.9.1
//
//  Author:     Marinus van der Lugt
//  Website:    http://www.balancingrock.nl/swifterjson
//
//  Copyright:  (c) 2014, 2015 Marinus van der Lugt, All rights reserved.
//
//  License:    Use or redistribute this code any way you like with the following two provision:
//
//  1) You ACCEPT this source code AS IS without any guarantees that it will work as intended. Any liability from its
//  use is YOURS.
//
//  2) You WILL NOT seek damages from the author or balancingrock.nl.
//
//  I also ask you to please leave this header with the source code.
//
//  I strongly believe that NAP is the way for societies to function optimally. I thus reject the implicit use of force
//  to extract payment. Since I cannot negotiate with you about the price of this code, I have choosen to leave it up to
//  you to determine its price. You pay me whatever you think this code is worth to you.
//
//   - You can send payment via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  I prefer the above two, but if these options don't suit you, you might also send me a gift from my amazon.co.uk
//  whishlist: http://www.amazon.co.uk/gp/registry/wishlist/34GNMPZKAQ0OO/ref=cm_sw_em_r_wsl_cE3Tub013CKN6_wb
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  (It is always a good idea to visit the website/google to ensure that you actually pay me and not some imposter)
//
//  For private and non-profit use the suggested price is the price of 1 good cup of coffee, say $4.
//  For commercial use the suggested price is the price of 1 good meal, say $20.
//
//  You are however encouraged to pay more ;-)
//
//  Prices/Quotes for support, modifications or enhancements can be obtained from: rien@balancingrock.nl
//
// =====================================================================================================================
//
//  This JSON implementation was written using the definitions as found on: http://json.org (2015.01.01)
//
// =====================================================================================================================
//
// Quickstart:
//
// 1) There are some TODO's (for you, not me!) in the source code (top and end), have a look at them.
//
// 2)
// let top = SwifterJSON.createJSONHierarchy()
// top["books"][0]["title"].stringValue = "THHGTTG"
// let myJsonString = top.description()
//
// 3)
// let (topOrNil, errorOrNil) = SwifterJSON.createJsonHierarchyFromString(myJsonString)
// if let top = topOrNil {
//    if let title = top["books"][0]["title"].stringValue {
//        println("The title of the first book is: " + title)
//    } else {
//        println("The title of the first book in myJsonString was not found")
//    }
// } else {
//    println(errorOrNil!)
// }
//
// 4) Always check for non-nil results for the value accessors.
//
// 5) Avoid using SwifterJSON objects outside a JSON hierarchy.
//
// =====================================================================================================================
//
// The use of SwifterJSON is actually pretty straight forward. Its more or less as you expect, but you may be caught off
// guard by the lenient implementation of some accessors, specifically the subscript accessors.
//
// Every JSON object (item) is envelloped in a SwifterJSON object. Leniency means that the JSON object (item) inside a
// SwifterJSON will be changed as necessary by the most recent operator. Especially for the subscript accessors this
// might create empty SwifterJSON objects containing an empty JSON item (NULL, OBJECT or ARRAY).
// However when creating a JSON description (string) these empty objects wil only appear when necessary to ensure index
// lookups. I.e. if you place an item at index [2] and have not placed anything at [0] and [1], the [0] and [1] will
// contain a JSON NULL item. (You will probably not want to place an item at index [405764373] because your
// computer will probably run out of memeory!)
//
// Beware of inadvertently changing the top level JSON object, it is possible to create a JSON description from any
// object, but only JSON descriptions from JSON OBJECTS are valid JSON strings.
//
// The value of a JSON NUMBER can always be read as a Double. Sometimes it can also be read as an Int. In case of doubt,
// use Double.
//
// All JSON values except OBJECT and ARRAY can be read as a rawString, and will contain the expected values.
//
// Have fun!
//
// =====================================================================================================================
//
// Oh, ... one more thing ...
//
// The subscript accessors make it possible to retrieve SwifterJSON objects from the hierarchy and insert them at other
// points in the hierarchy. Or to share SwifterJSON objects between hierarchies.
//
// Even though that is indeed possible, my advice is: don't do it.
//
// Why not?
// Since Swift copies objects by reference, retrieving the SwifterJSON object means that multiple references exist
// that point to the same object. Changing the object through one reference will change the object pointed at by all
// references. You might easily, and unintentionally, change the value in the JSON hierarchy. Resulting in sending
// the wrong information.
// Also, future implementations of the SwifterJSON class might contain explicit parent/child relations (pointers).
// Inserting objects at multiple places now could cause incompatibilities with future releases.
//
// =====================================================================================================================
//
// Terminology
//
// A SwifterJSON object refers to an instance of SwifterJSON. A JSON item refers to an JSON object inside a SwifterJSON
// object. When explicitly identified, JSON items (objects) are written in all capitals. I.e. as JSON OBJECT is just
// one of the possible JSON items, like STRING, NULL, NUMBER, BOOL and ARRAY.
//
// Apple uses key/value pairs, but JSON uses name/value pairs.
//
// =====================================================================================================================
//
// History
//
// 0.9.1 Moved the private definitions inside the class to avoid name collisions
//       Replaced type extensions with static class methods
//       Made pseudo 'static" definitions (Swift 1.0) to real class static definitions (Swift 1.2)
//       Changed logging SOURCE from SwiftON to SwifterJSON
//       Changed to all-caps writing of JSON for public interfaces
// 0.9.0 First public release
//
// =====================================================================================================================

import Foundation


// TODO: Decide if you want the next typealias

typealias JSON = SwifterJSON


// MARK: Public interface

// Convenience functions

func += (inout left: SwifterJSON, right: SwifterJSON) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: String) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Int) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Double) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: NSNumber) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Bool) -> SwifterJSON { left.append(right); return left }

func += (inout left: SwifterJSON, right: Array<SwifterJSON>) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Array<String>) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Array<Int>) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Array<Double>) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Array<NSNumber>) -> SwifterJSON { left.append(right); return left }
func += (inout left: SwifterJSON, right: Array<Bool>) -> SwifterJSON { left.append(right); return left }

func &= (inout left: SwifterJSON, right: Dictionary<String, SwifterJSON>) -> SwifterJSON {
    for (name, value) in right {
        left.updateValue(value, forName: name)
    }
    return left
}
func &= (inout left: SwifterJSON, right: Dictionary<String, String>) -> SwifterJSON {
    for (name, value) in right {
        left.updateValue(value, forName: name)
    }
    return left
}
func &= (inout left: SwifterJSON, right: Dictionary<String, Int>) -> SwifterJSON {
    for (name, value) in right {
        left.updateValue(value, forName: name)
    }
    return left
}
func &= (inout left: SwifterJSON, right: Dictionary<String, Double>) -> SwifterJSON {
    for (name, value) in right {
        left.updateValue(value, forName: name)
    }
    return left
}
func &= (inout left: SwifterJSON, right: Dictionary<String, NSNumber>) -> SwifterJSON {
    for (name, value) in right {
        left.updateValue(value, forName: name)
    }
    return left
}
func &= (inout left: SwifterJSON, right: Dictionary<String, Bool>) -> SwifterJSON {
    for (name, value) in right {
        left.updateValue(value, forName: name)
    }
    return left
}

func == (left: SwifterJSON, right: SwifterJSON) -> Bool {
    
    
    // The type of contained object must be identical
    
    if left.itemType != right.itemType { return false }
    
    
    // Remove objects that will not result in generated json code but could impact the comparison
    
    left.removeEmptySubscriptObjects()
    right.removeEmptySubscriptObjects()
    
    
    // From here on the type of contained JSON object is identical
    
    // Note: The rawValue cannot be used to compare across types as string could easily be identical to a bool, null or number.
    
    if left.itemType == .NULL { return true }
    
    if left.itemType == .BOOL { return left.boolValue! == right.boolValue! }
    
    if left.itemType == .STRING { return left.stringValue! == right.stringValue! }
    
    if left.itemType == .NUMBER { return left.rawValue! == right.rawValue! }
    
    
    // Only .ARRAY and .OBJECT left
    
    if left.count != right.count { return false }
    
    if left.itemType == .OBJECT {
        
        for (name, value) in left.objectItem! {
            if right[name] != value { return false }
        }
        
        return true
    }
    
    // Only .ARRAY left
    
    for index in 0 ..< left.arrayItem!.count {
        if left.arrayItem![index] != right.arrayItem![index] { return false }
    }
    
    return true
}

func != (left: SwifterJSON, right: SwifterJSON) -> Bool {
    return !(left == right)
}

/// This defines the SwifterJSON class, a manager and container to generate, parse and maintain values in the JSON format.

class SwifterJSON : Printable, SequenceType {
    
    
    /// Defines all possible types of a JSON item.
    
    enum ItemType: String { case STRING = "STRING", NUMBER = "NUMBER", OBJECT = "OBJECT", ARRAY = "ARRAY", BOOL = "BOOL", NULL = "NULL" }
    
    
    // Creates a new SwifterJSON object containing the given value(s).
    
    convenience init() {
        self.init(type: ItemType.NULL)
        self.stringItem = "null"
    }
    
    convenience init(_ value: String) {
        self.init(type: ItemType.STRING)
        self.stringItem = value
    }
    
    convenience init(_ value: Int) {
        self.init(type: ItemType.NUMBER)
        self.stringItem = value.description
        self.intItem = value
        self.doubleItem = Double(value)
    }
    
    convenience init(_ value: Double) {
        self.init(type: ItemType.NUMBER)
        self.stringItem = value.description
        self.doubleItem = value
    }
    
    convenience init(_ value: NSNumber) {
        self.init(type: ItemType.NUMBER)
        self.stringItem = value.description
        self.doubleItem = value.doubleValue
    }
    
    convenience init(_ value: Bool) {
        self.init(type: ItemType.BOOL)
        self.stringItem = value ? "true" : "false"
        self.boolItem = value
    }
    
    convenience init(_ values: Array<String>) {
        self.init(type: ItemType.ARRAY)
        arrayItem = []
        for value in values {
            arrayItem!.append(SwifterJSON(value))
        }
    }
    
    convenience init(_ values: Array<Int>) {
        self.init(type: ItemType.ARRAY)
        arrayItem = []
        for value in values {
            arrayItem!.append(SwifterJSON(value))
        }
    }
    
    convenience init(_ values: Array<Double>) {
        self.init(type: ItemType.ARRAY)
        arrayItem = []
        for value in values {
            arrayItem!.append(SwifterJSON(value))
        }
    }
    
    convenience init(_ values: Array<NSNumber>) {
        self.init(type: ItemType.ARRAY)
        arrayItem = []
        for value in values {
            arrayItem!.append(SwifterJSON(value.doubleValue))
        }
    }
    
    convenience init(_ values: Array<Bool>) {
        self.init(type: ItemType.ARRAY)
        arrayItem = []
        for value in values {
            arrayItem!.append(SwifterJSON(value))
        }
    }

    convenience init(_ values: Dictionary<String, String>) {
        self.init(type: ItemType.OBJECT)
        objectItem = [:]
        for (name, value) in values {
            objectItem!.updateValue(SwifterJSON(value), forKey: name)
        }
    }
    
    convenience init(_ values: Dictionary<String, Int>) {
        self.init(type: ItemType.OBJECT)
        objectItem = [:]
        for (name, value) in values {
            objectItem!.updateValue(SwifterJSON(value), forKey: name)
        }
    }
    
    convenience init(_ values: Dictionary<String, Double>) {
        self.init(type: ItemType.OBJECT)
        objectItem = [:]
        for (name, value) in values {
            objectItem!.updateValue(SwifterJSON(value), forKey: name)
        }
    }
    
    convenience init(_ values: Dictionary<String, NSNumber>) {
        self.init(type: ItemType.OBJECT)
        objectItem = [:]
        for (name, value) in values {
            objectItem!.updateValue(SwifterJSON(value.doubleValue), forKey: name)
        }
    }
    
    convenience init(_ values: Dictionary<String, Bool>) {
        self.init(type: ItemType.OBJECT)
        objectItem = [:]
        for (name, value) in values {
            objectItem!.updateValue(SwifterJSON(value), forKey: name)
        }
    }

    
    /// Creates a new SwifterJSON object containing an empty JSON OBJECT item, this can be used as the top level object for a JSON hierarchy.
    
    class func createObject() -> SwifterJSON {
        let newObject = SwifterJSON(type: ItemType.OBJECT)
        newObject.objectItem = [:]
        return newObject
    }

    
    /// Creates a new SwifterJSON object containing an empty JSON OBJECT item, this can be used as the top level object for a JSON hierarchy.
    
    class func createJSONHierarchy() -> SwifterJSON { return SwifterJSON.createObject() }
    
    
    /// Creates a new SwifterJSON object containg an empty JSON ARRAY item.
    
    class func createArray() -> SwifterJSON {
        let newObject = SwifterJSON(type: ItemType.ARRAY)
        newObject.arrayItem = []
        return newObject
    }

    
    /**
    
    Updates the value part of a name/value pair for the given name. It will create a new pair if the pair name does not yet exist.
    
    :param: value The SwifterJSON object to be assigned to the pair value.
    
    :param: forName The pair name for which the pair value will be set.
    
    */
    
    func updateValue(value: SwifterJSON, forName name: String) {

        
        // Change the type if necessary
        
        if (itemType != ItemType.OBJECT) { changeToObjectType() }
        
        
        // Add it to the private dictionary
        
        objectItem!.updateValue(value, forKey: name)
    }

    func updateValue(value: String, forName name: String) { updateValue(SwifterJSON(value), forName:name) }
    
    func updateValue(value: Int, forName name: String) { updateValue(SwifterJSON(value), forName:name) }
    
    func updateValue(value: Double, forName name: String) { updateValue(SwifterJSON(value), forName:name) }
    
    func updateValue(value: NSNumber, forName name: String) { updateValue(SwifterJSON(value.doubleValue), forName:name) }
    
    func updateValue(value: Bool, forName name: String) { updateValue(SwifterJSON(value), forName:name) }

    func updateValueNull(forName name: String) { updateValue(SwifterJSON(), forName:name) }
    
    func updateValues(values: Dictionary<String, String>) {
        for (name, value) in values {
            self.updateValue(SwifterJSON(value), forName: name)
        }
    }
    
    func updateValues(values: Dictionary<String, Int>) {
        for (name, value) in values {
            self.updateValue(SwifterJSON(value), forName: name)
        }
    }
    
    func updateValues(values: Dictionary<String, Double>) {
        for (name, value) in values {
            self.updateValue(SwifterJSON(value), forName: name)
        }
    }
    
    func updateValues(values: Dictionary<String, NSNumber>) {
        for (name, value) in values {
            self.updateValue(SwifterJSON(value.doubleValue), forName: name)
        }
    }
    
    func updateValues(values: Dictionary<String, Bool>) {
        for (name, value) in values {
            self.updateValue(SwifterJSON(value), forName: name)
        }
    }
    
    
    /**
    
    Removes the pair with the given name.
    
    :param: name The name of the pair that will be removed.
    
    :returns: The value of the pair when removed, nil when the pair name was not found or if this SwifterJSON object does not contain a JSON OBJECT item.
    
    */
    
    func removeItemWithName(name: String) -> SwifterJSON? {
        
        if itemType != ItemType.OBJECT { return nil }
        
        return objectItem!.removeValueForKey(name)
    }
    
    
    /**
    
    Append the given SwifterJSON object to an ARRAY.
    
    :param: value The SwifterJSON object to be added.
    
    */
    
    func append(value: SwifterJSON) {
        
        
        // Try to change the object if necessary and allowed
        
        if itemType != ItemType.ARRAY { self.changeToArrayType() }
        

        // Append the value object
        
        arrayItem!.append(value)
    }
    
    func append(value: String) { append(SwifterJSON(value)) }

    func append(value: Int) { append(SwifterJSON(value)) }

    func append(value: Double) { append(SwifterJSON(value)) }

    func append(value: NSNumber) { append(SwifterJSON(value.doubleValue)) }

    func append(value: Bool) { append(SwifterJSON(value)) }

    func appendNull() { append(SwifterJSON()) }

    func append(values: Array<SwifterJSON>) {
        for value in values {
            self.append(value)
        }
    }
    
    func append(values: Array<String>) {
        for value in values {
            self.append(SwifterJSON(value))
        }
    }
    
    func append(values: Array<Int>) {
        for value in values {
            self.append(SwifterJSON(value))
        }
    }
    
    func append(values: Array<Double>) {
        for value in values {
            self.append(SwifterJSON(value))
        }
    }
    
    func append(values: Array<NSNumber>) {
        for value in values {
            self.append(SwifterJSON(value.doubleValue))
        }
    }
    
    func append(values: Array<Bool>) {
        for value in values {
            self.append(SwifterJSON(value))
        }
    }

    
    /**
    
    Removes the item at the given index.
    
    :param: index The index of the item to remove.
    
    :returns: The item that was removed. Nil if there is no item at the given index, or this SwifterJSON object does not contain a JSON ARRAY item.
    */
    
    func removeItemAtIndex(index: Int) -> SwifterJSON? {
        
        if itemType != ItemType.ARRAY { return nil }
        
        if index >= arrayItem!.count { return nil }
        
        return arrayItem!.removeAtIndex(index)
    }
    
    
    /**
    
    Replaces the item at the given index.
    
    :param: item The item to be swapped with the item at the given index.
    
    :param: atIndex The index of the item to be swapped.
    
    :returns: The item that was removed. Nil if there is no item at the given index, or this SwifterJSON object does not contain a JSON ARRAY item.
    
    */
    
    func replaceItem(item: SwifterJSON, atIndex index: Int) -> SwifterJSON? {
        
        if itemType != ItemType.ARRAY { return nil }
        
        if index >= arrayItem!.count { return nil }

        let deletedItem = arrayItem!.removeAtIndex(index)
        
        if index < arrayItem!.count {
            arrayItem!.insert(item, atIndex: index)
        } else {
            arrayItem!.append(item)
        }
        
        return deletedItem
    }
    
    
    /**
    
    Removes the given object from the JSON hierarchy if it is present at this or lower levels. It will traverse the JSON hierarchy only downwards in order to find the object to be removed. For large hierarchies it makes sense to start this operation at the lowest possible level to prevent lengthy operations. If the object to be removed is the object itself, the operation will fail.
    
    :param: object The object to be removed. At least one of 'object' or 'forName' must be specified.
    
    :param: forName If specified, the object will be deleted only from the name/value pairs with the specified name. At least one of 'object' or 'forName' must be specified.
    
    :param: all If set to true it will search the entire tree to find all occurances of this object and remove all of them. If set to false (default), it will stop after the first occurance. If there are no multiple occurances then leave this parameter at the default value as this can greatly increase the speed of this operation.
    
    :returns: The number of objects removed. -1 if both 'object' and 'forName' are nil.
    
    */
    
    
    func removeObject(object: SwifterJSON?, forName: String?, all: Bool = false) -> Int {
        
        var totalRemoved = 0
        
        
        // Quick exit on parameter error (note: it is assumed that there are no SW errors in this function that produce -1)
        
        if object == nil && forName == nil { return -1 }
        
        
        // When a name is specified
        
        if let name = forName {
            
            
            // Check self for name/value pairs with the given name/value
            
            if itemType == ItemType.OBJECT {
                
                if object == nil {
                    if objectItem!.removeValueForKey(name) != nil { totalRemoved++ }
                } else {
                    let value = objectItem![name]
                    if value === object {
                        if objectItem!.removeValueForKey(name) != nil { totalRemoved++ }
                    }
                }
            }
            
            
            // If nothing was deleted, or when all occurances have to be deleted, go down the hierarchy
            
            if ((totalRemoved == 0 ) || all) {
                
                if itemType == ItemType.OBJECT {
                    for (_, value) in objectItem! {
                        if ((value.itemType == ItemType.OBJECT) || (value.itemType == ItemType.ARRAY)) {
                            totalRemoved += value.removeObject(object, forName: forName, all: all)
                        }
                        if ((totalRemoved > 0) && !all) { break }
                    }
                } else if itemType == ItemType.ARRAY {
                    for value in arrayItem! {
                        if ((value.itemType == ItemType.OBJECT) || (value.itemType == ItemType.ARRAY)) {
                            totalRemoved += value.removeObject(object, forName: forName, all: all)
                        }
                        if ((totalRemoved > 0) && !all) { break }
                    }
                }
            }
            
        } else {
            
            
            // No name is specified, check both name/value pairs and array's
            
            if itemType == ItemType.OBJECT { // Btw 'object' is now guaranteed to be non-nil
                
                for (key, value) in objectItem! {
                    if value === object! {
                        objectItem!.removeValueForKey(key)
                        totalRemoved++
                        if !all { break }
                    }
                }
                
            } else if itemType == ItemType.ARRAY {
                
                for (index, value) in enumerate(arrayItem!) {
                    if value === object! {
                        arrayItem!.removeAtIndex(index)
                        totalRemoved++
                        if !all { break }
                    }
                }
            }
            
            
            // If nothing was deleted, or when all occurances have to be deleted, go down the hierarchy
            
            if ((totalRemoved == 0) || all) {
                
                if itemType == ItemType.OBJECT {
                    for (_, value) in objectItem! {
                        if ((value.itemType == ItemType.OBJECT) || (value.itemType == ItemType.ARRAY)) {
                            totalRemoved += value.removeObject(object, forName: forName, all: all)
                        }
                        if ((totalRemoved > 0) && !all) { break }
                    }
                } else if itemType == ItemType.ARRAY {
                    for value in arrayItem! {
                        if ((value.itemType == ItemType.OBJECT) || (value.itemType == ItemType.ARRAY)) {
                            totalRemoved += value.removeObject(object, forName: forName, all: all)
                        }
                        if ((totalRemoved > 0) && !all) { break }
                    }
                }
            }
        }

        return totalRemoved
    }
    
    
    /**
    
    Removes all the SwifterJSON objects that are included in this object. It is only effective on SwifterJSON objects that contain JSON ARRAYs or JSON OBJECTs.
    
    :returns: The number of objects removed.
    
    */
    
    func removeAllChildren() -> Int {
        
        if itemType == .OBJECT {
            let total = objectItem!.count
            objectItem!.removeAll(keepCapacity: false)
            return total
        } else if itemType == .ARRAY {
            let total = arrayItem!.count
            arrayItem!.removeAll(keepCapacity: false)
            return total
        }
        return 0
    }
    
    
    /**
    
    Parses the given string -according to the JSON standard- and builds a JSON hierarchy.
    
    :param: string A JSON formatted string.
    
    :returns: A tuple with a toplevel SwifterJSON object if the parsing was without error and an error message if parsing failed.
    
    */
    
    class func createJSONHierarchyFromString(string: String) -> (SwifterJSON?, String?) {
        let newObject = createObject()
        newObject.parse(string)
        if newObject.parseError != nil { return (nil, newObject.parseError) }
        return (newObject, nil)
    }
    
    
    /**
    
    Parses the given file with UTF8 data according to the JSON standard and builds a JSON object hierarchy. Make sure that you have the proper sandbox rights to read the file at the given path.
    
    :param: path The path to a file containing a JSON formatted UTF8 string.
    
    :returns: A tuple with a toplevel SwifterJSON object if the parsing was without error and an error message if parsing failed.
    
    */
    
    class func createJSONHierarchyFromFile(path: String) -> (SwifterJSON?, String?) {
        
        
        // Check if the file exists, and that it is not a directory
        
        if !NSFileManager.defaultManager().isReadableFileAtPath(path) {
            return (nil, "The file does not exist or read access is not granted")
        }
        
        
        // Read the file into a string
        
        var error: NSError?
        let content = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
        if let message = error?.localizedDescription { return (nil, message) }
        
        
        // And deserialize the string
        
        return createJSONHierarchyFromString(content!)
    }
    

    /**
    
    Writes the current contents of the JSON hierarchy to a file at the given path in UTF8 string encoding. Any existing file will be overwritten. Make sure that you have the proper sandbox rights to write at the given path. Note that this function can only be invoked on JSON OBJECT types. But it does not need to be the top level JSON OBJECT.
    
    :param: path The path at which to create or overwrite the contents of this JSON hierarchy.
    
    :returns: nil if the write was successful, an error message if there was an error.
    
    */
    
    func writeJSONHierarchyToFile(path: String) -> (String?) {

        
        // If there is a file, make sure it can be removed
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if NSFileManager.defaultManager().isDeletableFileAtPath(path) {
                return "Existing file at path \(path) cannot be removed"
            }
        }
        
        
        // Get the string representation
        
        let str = self.description
        
        var error: NSError?
        let success = str.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        
        if success { return nil }
        
        if let message = error?.localizedDescription {
            return message
        } else {
            return "Unknown error occured when writing to \(path)"
        }
    }
    
    
    /// Returns the raw string value for the JSON types STRING, BOOL, NUMBER and NULL. Returns nil for ARRAY and OBJECT
    
    var rawValue: String? { get { return stringItem } }
    
    
    /// The string value is used, and can be retrieved, for the ItemType STRING. If 'nil' is assigned, the resulting ItemType of this SwifterJSON will be NULL, not STRING.
    
    var stringValue: String? {
        
        set {

            // Remove old data
            
            self.stringItem = nil
            self.intItem = nil
            self.boolItem = nil
            self.doubleItem = nil
            self.arrayItem = nil
            self.objectItem = nil
                
                
            // Set the new type and value
            
            if newValue == nil {
                self.itemType = .NULL
                self.stringItem = "null"
            } else {
                self.itemType = .STRING
                self.stringItem = newValue
            }
        }
        
        get {
            return itemType == .STRING ? self.stringItem : nil
        }
    }

    
    /// The int value is used, and can be retrieved, for the ItemType NUMBER, but only if the NUMBER was constructed as an Int. If the NUMBER was constructed as a Double, the intValue will return nil. The rawValue will be updated to "Int.description". If 'nil' is assigned, the resulting ItemType of this SwifterJSON will be NULL, not NUMBER.
    
    var intValue: Int? {
        
        set {
            
            // Remove old data
            
            self.stringItem = nil
            self.intItem = nil
            self.boolItem = nil
            self.doubleItem = nil
            self.arrayItem = nil
            self.objectItem = nil
            
            
            // Set the new type and value
            
            if newValue == nil {
                self.itemType = .NULL
                self.stringItem = "null"
            } else {
                self.itemType = .NUMBER
                self.stringItem = newValue!.description
                self.intItem = newValue
                self.doubleItem = Double(newValue!)
            }
        }
        
        get {
            return itemType == .NUMBER ? self.intItem : nil
        }
    }
    
    
    /// The double value is used, and can be retrieved, for the ItemType NUMBER. It can be retrieved for NUMBER's that are constructed as a double or as an int. The stringValue will be updated to "Double.description". If 'nil' is assigned, the resulting ItemType of this SwifterJSON will be NULL, not NUMBER.

    var doubleValue: Double? {
        
        set {
            
            // Remove old data
            
            self.stringItem = nil
            self.intItem = nil
            self.boolItem = nil
            self.doubleItem = nil
            self.arrayItem = nil
            self.objectItem = nil
            
            
            // Set the new type and value
            
            if newValue == nil {
                self.itemType = ItemType.NULL
                self.stringItem = "null"
            } else {
                self.itemType = ItemType.NUMBER
                self.stringItem = newValue!.description
                self.doubleItem = newValue
            }
        }
        
        get {
            return itemType == .NUMBER ? self.doubleItem : nil
        }
    }
    
    
    /// The bool value is used, and can be retrieved, for the ItemType BOOL. The stringValue will be updated to either "true" or "false" de pending on the new value. If 'nil' is assigned, the resulting ItemType of this SwifterJSON will be NULL, not BOOL.

    var boolValue: Bool? {
        
        set {
            
            // Remove old data
            
            self.stringItem = nil
            self.intItem = nil
            self.boolItem = nil
            self.doubleItem = nil
            self.arrayItem = nil
            self.objectItem = nil
            
            
            // Set the new type and value
            
            if newValue == nil {
                self.itemType = .NULL
                self.stringItem = "null"
            } else {
                self.itemType = .BOOL
                self.stringItem = newValue! ? "true" : "false"
                self.boolItem = newValue
            }
        }
        
        get {
            return itemType == .BOOL ? self.boolItem : nil
        }
    }
    
    
    /// The null value is used, and can be retrieved, for the ItemType NULL. Note that when this value can be retrieved it always is "true". It can thus only return the values true or nil, never false. Use the convenience function "isNull" to get either true or false. The stringValue will be updated to "null". Any assignment to this value (either "true", "false" or "nil") will always result in a SwifterJSON of type ItemType NULL.
    
    var nullValue: Bool? {
        
        set {
            
            // Remove old data
            
            self.stringItem = nil
            self.intItem = nil
            self.boolItem = nil
            self.doubleItem = nil
            self.arrayItem = nil
            self.objectItem = nil
            
            
            // Set the new type and value
            
            self.itemType = ItemType.NULL
            self.stringItem = "null"
        }
        
        get {
            return itemType == .NULL ? true : nil
        }
    }
    
    
    /// Returns 'true' if the SwifterJSON object is a JSON NULL
    
    func isNull() -> Bool { return itemType == ItemType.NULL }
    
    
    /// Returns 'true' if the SwifterJSON object is a JSON ARRAY
    
    func isArray() -> Bool { return itemType == ItemType.ARRAY }
    
    
    /// Returns 'true' if the SwifterJSON object is a JSON OBJECT
    
    func isObject() -> Bool { return itemType == ItemType.OBJECT }

    
    /// Returns 'true' if the SwifterJSON object is a JSON STRING
    
    func isString() -> Bool { return itemType == ItemType.STRING }


    /// Returns 'true' if the SwifterJSON object is a JSON NUMBER
    
    func isNumber() -> Bool { return itemType == ItemType.NUMBER }

    
    /// Returns 'true' if the SwifterJSON object is a JSON BOOL
    
    func isBool() -> Bool { return itemType == ItemType.BOOL }
    
    
    /**
    
    Returns either nil, or the object at the given path. Works only on JSON OBJECT items or JSON ARRAY items. This function works by using the given string as either the name of a name/value pair, or it converts the string into an Int to get the index to retrieve.
    
    :param: path The array with strings designating an object in the JSON hierarchy. For name/value pair, include the name, for values in an array include the index as a String.
    
    :returns: The requested object or nil if it does not exist. Also returns nil if this function is called on a type that does not contain JSON objects. If a string has to be converted into an array index and the conversion fails, this function will also return a nil.

    */
    
    func objectAtPath(path: Array<String>) -> SwifterJSON? {
        
        
        // Protect against missing path
        
        if path.count == 0 { return nil }
        
        
        // Clean out empty subscript generated objects
        
        removeEmptySubscriptObjects()
        
        
        // Use the private function to do the work
        
        return privateObjectAtPath(path)
    }
    
    
    /// Convenience function for 'objectAtPath(path: Array<String>) -> SwifterJSON?'
    
    func objectAtPath(path: String...) -> SwifterJSON? { return objectAtPath(path) }
    
    
    /**
    
    Returns true if an object exists at the destination. Only works on SwifterJSON objects containing a JSON OBJECT or JSON ARRAY
    
    :param: path The array with strings designating an object in the JSON hierarchy. For name/value pair, include the name, for values in an array include the index as a String.
    
    :returns: True if an object exists at the given destination, false if not. Empty JSON objectes do not count as objects. Also returns false when an index is expected but the given string cannot be converted into a number.
    
    */
    
    func objectExistsAtPath(path: Array<String>) -> Bool {
        return objectAtPath(path) != nil
    }
    
    
    /// Convenience function that maps to 'objectExistsAtPath(path: Array<String>) -> Bool'
    
    func objectExistsAtPath(path: String...) -> Bool {
        return objectExistsAtPath(path)
    }
    
    
    /**
    
    Returns true if an object of the requested type exists at he given path. Only works on objects of the types JSON OBJECT and JSON ARRAY.
    
    :param: type The type of object requested.
    
    :param: existsAtPath The array with strings designating an object in the JSON hierarchy. For name/value pair, include the name, for values in an array include the index as a String.
    
    :returns: True if there is an object of the requested type at the specified location. False otherwise.

    */
    
    func itemOfType(type: ItemType, existsAtPath path: Array<String>) -> Bool {
        if let object = objectAtPath(path) {
            return object.itemType == type
        }
        return false
    }
    

    /// Convenience function that maps to 'objectOfType(type: ItemType, existsAtPath path: Array<String>) -> Bool'

    func itemOfType(type: ItemType, existsAtPath path: String...) -> Bool {
        return itemOfType(type, existsAtPath: path)
    }
    
    
    // Subscript getter/setter for a JSON ARRAY type.
    
    subscript(index: Int) -> SwifterJSON {
        
        set {

            
            // Ensure that this is an ARRAY object
            
            if itemType != ItemType.ARRAY { changeToArrayType() }
            
            
            // Ensure that enough elements are present in the array
            
            if index >= self.arrayItem!.count {
                for i in self.arrayItem!.count ... index {
                    var newObject = SwifterJSON()
                    newObject.createdBySubscript = true
                    self.arrayItem?.append(newObject)
                }
            }
            
            
            // Assign the new value
            
            self.arrayItem![index] = newValue
        }
        
        get {
            
            
            // Ensure that this is an ARRAY object
            
            if itemType != ItemType.ARRAY { changeToArrayType() }
            
            
            // Ensure that enough elements are present in the array
            
            if index >= self.arrayItem!.count {
                for i in self.arrayItem!.count ... index {
                    var newObject = SwifterJSON()
                    newObject.createdBySubscript = true
                    self.arrayItem?.append(newObject)
                }
            }
            
            
            // Return the requested value
            
            return self.arrayItem![index]
        }
    }
    

    // Subscript getter/setter for a JSON OBJECT type.
    
    subscript(key: String) -> SwifterJSON {
        
        set {
            
            
            // Ensure that this is an OBJECT type
            
            if itemType != ItemType.OBJECT { changeToObjectType() }
            
            
            // Add the object
            
            objectItem!.updateValue(newValue, forKey: key)
        }
        
        get {
            

            // Ensure that this is an OBJECT type

            if itemType != ItemType.OBJECT { changeToObjectType() }
            
            
            // If the requested object exist, return it
            
            if let val = objectItem![key] { return val }
            
            
            // If the request value does not exist, create it
            // This allows object creation for 'object["key1"]["key2"]["key3"] = SwifterJSON(12)' constructs.

            var newObject = SwifterJSON()
            newObject.createdBySubscript = true
            objectItem?.updateValue(newObject, forKey: key)
            
            return objectItem![key]!
        }
    }
    

    /**
    
    Returns the number of JSON objects in this SwifterJSON object, excluding the elements in the child objects.
    
    :returns: The number of JSON objects in this object.
    
    Side effect: removes empty JSON ARRAY and empty JSON OBJECT objects from the hierarchy.

    */
    
    var count: Int {
        if itemType == ItemType.ARRAY  {
            removeEmptySubscriptObjects()
            return arrayItem!.count
        }
        if itemType == ItemType.OBJECT {
            removeEmptySubscriptObjects()
            return objectItem!.count
        }
        return 0
    }
    
    
    /// The parsing duration from createJsonHierarchyFromXXXX in seconds (NSTimeInterval is a typealias for a double)
    /// Note: This is the total elapsed time, not necessarily the total processing time.
    
    var parseDuration: NSTimeInterval = 0.0
    
    
    /**
    
    Return an unsorted array with all the name's from this object. Only works on JSON OBJECTs.
    
    :returns: An array containing all the keys that are present in the name/value pairs.
    
    Side effect: removes empty JSON ARRAY and empty JSON OBJECT objects from the hierarchy.

    */
    
    func names() -> Array<String>? {
        
        
        // Only works on JSON OBJECTs
        
        if itemType != ItemType.OBJECT { return nil }
        

        // Remove the empty objects
        
        removeEmptySubscriptObjects()

        
        // Build the array
        
        var arr = [String]()
        for (key, value) in objectItem! {
            arr.append(key)
        }
        
        
        // And return it
        
        return arr
    }
    
    
    /**
    
    Return an unsorted array with all the values from this object.
    
    :returns: An array containing all the values that are present in this object.
    
    Side effect: removes empty JSON ARRAY and empty JSON OBJECT objects from the hierarchy.

    */
    
    func values() -> Array<SwifterJSON>? {
        
        
        // For JSON OBJECTs
        
        if itemType == ItemType.OBJECT {
            
            
            // First remove empty objects
            
            removeEmptySubscriptObjects()
            
            
            // Build the array
            
            var arr = [SwifterJSON]()
            for (key, value) in objectItem! { arr.append(value) }
            
            if arr.count == 0 {
                if createdBySubscript { return nil }
            }
            return arr
        }
        
        
        // For JSON ARRAYs
        
        if itemType == ItemType.ARRAY {
            
            
            // First remove empty objects
            
            removeEmptySubscriptObjects()

            
            if arrayItem!.count == 0 {
                if createdBySubscript { return nil }
            }
            return arrayItem
        }
        
        
        // Just one element
        
        if createdBySubscript { return nil }
        
        var arr = [SwifterJSON]()
        arr.append(self)
        return arr
    }
    
    
    // MARK: -
    // MARK: Adopted protocols
    
    
    // The printable protocol
    
    var description: String {
        
        var str = ""
        
        switch itemType {
            
        case ItemType.STRING:
            str = "\"\(self.stringItem!)\""
            
        case ItemType.BOOL, ItemType.NULL, ItemType.NUMBER:
            str = self.stringItem!
            
        case ItemType.OBJECT:
            removeEmptySubscriptObjects()
            if (createdBySubscript && (objectItem!.count == 0)) { return "" }
            str = "{"
            var c = 1 // Because index starts at 0
            for (key, value) in self.objectItem! {
                str += "\"" + key + "\"" + ":" + value.description
                if c < self.objectItem!.count { str += "," }
                c++
            }
            str += "}"
            
        case ItemType.ARRAY:
            removeEmptySubscriptObjects()
            if (createdBySubscript && (arrayItem!.count == 0)) { return "" }
            str = "["
            var c = 1 // Because index starts at 0
            for value in self.arrayItem! {
                str += value.description
                if c < self.arrayItem!.count { str += "," }
                c++
            }
            str += "]"
        }
        
        return str
    }

    
    // The sequence protocol
    
    struct SwifterJSONGenerator: GeneratorType {        // Implements the GeneratorType protocol
        typealias Element = SwifterJSON
        let source: SwifterJSON                         // The object for which the generator generates
        var sent: Array<SwifterJSON> = []               // The objects already delivered through the generator
        init(source: SwifterJSON) {
            self.source = source
        }
        mutating func next() -> Element? {              // The GeneratorType protocol
            if var values = source.values() {           // Only when the source has values to deliver
                OUTER: for i in values {                // Find a value that has not been sent already
                    for s in sent {                     // Check if the value has not been sent already
                        if i === s { continue OUTER }   // If it was sent, then try the next value
                    }
                    sent.append(i)                      // Found a value that was not sent yet, remember that it will be sent
                    return i                            // Send it
                }
            }
            return nil                                  // Nothing left to send
        }
    }
    
    typealias Generator = SwifterJSONGenerator
    func generate() -> Generator {
        return SwifterJSONGenerator(source: self)
    }
    
    
    // MARK: -
    // MARK: From here on only private definitions
    
    
    // Set if self was created by a subscript accessor
    
    private var createdBySubscript = false
    
    
    // Defines the type of this object
    
    private var itemType: ItemType
    

    // Prevent the creation of types that have no defined content
    
    private init(type: ItemType) {
        self.itemType = type
    }
    
    
    // Remove empty objects that resulted from subscript access.
    
    private func removeEmptySubscriptObjects() {
        
        func removeEmptySubscriptsObjectsFromValue(value: SwifterJSON) {
            // Do not use value.count, that would create an endless loop
            if value.itemType == .OBJECT { if value.objectItem!.count > 0 { value.removeEmptySubscriptObjects()}}
            if value.itemType == .ARRAY { if value.arrayItem!.count > 0 { value.removeEmptySubscriptObjects()}}
        }
        
        
        // For JSON OBJECTs, remove all name/value pairs that are created by a subscript and do not contain any non-subscript generated value
        
        if itemType == .OBJECT {
            
            
            // Itterate over all name/value pairs
            
            for (name, value) in objectItem! {
                
                
                // Make sure that this value has all its subscript generated values removed
                
                removeEmptySubscriptsObjectsFromValue(value)
                
                
                // Remove the value if it is generated by subscript and contains no usefull items
                
                if value.createdBySubscript {
                    
                    if value.itemType == .NULL {
                        objectItem!.removeValueForKey(name)
                    } else if value.itemType == .ARRAY {
                        if value.arrayItem!.count == 0 {
                            objectItem!.removeValueForKey(name)
                        }
                    } else if value.itemType == .OBJECT {
                        if value.objectItem!.count == 0 {
                            objectItem!.removeValueForKey(name)
                        }
                    }
                }
            }
            
        } else if itemType == .ARRAY { // For JSON ARRAYs, remove all values that are createdby a subscript and do not contain any non-subscript generated value
            
            
            // This array will contain the indicies of all values that should be removed
            
            var itemsToBeRemoved = [Int]()
            
            
            // Loop over all values, backwards. As soon as a value is hit that cannot be removed, stop iterating
            
            if arrayItem!.count > 0 {
                
                for index in reverse(0 ..< arrayItem!.count) {
                    
                    let value = arrayItem![index]
                

                    // Make sure that this value has all its subscript generated values removed (cannot use value.count here!)
                    
                    removeEmptySubscriptsObjectsFromValue(value)

                    
                    // If this value is created by subscript, then check if it has content
                    
                    if value.createdBySubscript {
                        
                        if value.itemType == .NULL {
                            itemsToBeRemoved.append(index)
                        } else if value.itemType == .ARRAY {
                            if value.arrayItem!.count == 0 {
                                itemsToBeRemoved.append(index)
                            } else {
                                break
                            }
                        } else if value.itemType == .OBJECT {
                            if value.objectItem!.count == 0 {
                                itemsToBeRemoved.append(index)
                            } else {
                                break
                            }
                        } else {
                            break
                        }
                    } else {
                        break
                    }
                }
                
                
                // Actually remove items, if any.
                // Note: Because of the reverse loop above, the indexes in itemsToBeRemoved count down.
                
                for i in itemsToBeRemoved { arrayItem!.removeAtIndex(i) }
            }
        }
    }
    
    // Actual implementation of itemAtPath, note that this function will not remove empty subscript generated objects.
    
    func privateObjectAtPath(path: Array<String>) -> SwifterJSON? {
        
        
        // Only for JSON OBJECT or ARRAY
        
        if itemType == ItemType.OBJECT {    // For JSON OBJECT
            
            
            // Read the path component as a String to be used as a name for a name/value pair
            
            let name = path[0]
            
            
            // Get the value of the name/value pair
            
            if let object = objectItem![name] {
                
                
                // Determine of more path elements have to be evaluated
                
                if path.count > 1 {
                    
                    
                    // Repeat (recursive) further evaluation on the found object
                    
                    let partialPath: Array<String> = Array(path[1..<path.count])
                    return object.privateObjectAtPath(partialPath)
                    
                } else {
                    
                    
                    // No more path elements present, thus return the found object
                    
                    return object
                }
                
                
            } else {
                
                
                // There was no name/value pair with the given name
                
                return nil
            }
            
        } else if itemType == ItemType.ARRAY {  // For JSON ARRAY
            
            
            // Read the path component as an Int, to be used as an index into the array
            
            let index = path[0].toInt()
            
            
            // Continue only if an index could be read, if not, the path is in error
            
            if index != nil {
                
                
                // Does the requested object exist in the array?
                
                if index < arrayItem!.count {
                    
                    
                    // get the object from the array
                    
                    let object = arrayItem![index!]
                    
                    
                    // Determine of more path elements have to be evaluated
                    
                    if path.count > 1 {
                        
                        
                        // Repeat (recursive) further evaluation on the found object
                        
                        let partialPath: Array<String> = Array(path[1..<path.count])
                        return object.privateObjectAtPath(partialPath)
                        
                    } else {    // No more path elements present, thus return the found object
                        
                        return object
                    }
                    
                } else {    // The object could not be found in the array
                    
                    return nil
                }
                
            } else { // The path has an error in it as the current element could not be converted into an Int
                
                return nil
            }
        }
        
        return nil // This item is neither an OBJECT or ARRAY
    }

    
    // The parent SwifterJSON object (either an array or an object) or nil for the top level object. This value is only used during parsing and is not maintained thereafter.
    
    private var parseParent: SwifterJSON?

    
    // The real data stores
    
    private var stringItem: String?
    private var intItem: Int?
    private var doubleItem: Double?
    private var boolItem: Bool?
    private var nullItem: Bool?
    private var arrayItem: Array<SwifterJSON>?
    private var objectItem: Dictionary<String, SwifterJSON>?
    
    
    // Changes the object content to a JSON ARRAY
    
    private func changeToArrayType() {
        
        
        // Remove old data
            
        self.stringItem = nil
        self.intItem = nil
        self.boolItem = nil
        self.doubleItem = nil
        self.arrayItem = nil
        self.objectItem = nil
            
            
        // Set the new type and value
            
        self.itemType = ItemType.ARRAY
        self.arrayItem = []
    }
    
    
    // Changes the object content to a JSON OBJECT.
    
    private func changeToObjectType() {
        
    
        // Remove old data
        
        self.stringItem = nil
        self.intItem = nil
        self.boolItem = nil
        self.doubleItem = nil
        self.arrayItem = nil
        self.objectItem = nil
            
    
        // Set new data
            
        self.itemType = ItemType.OBJECT
        self.objectItem = [:]
    }
    
    
    // This variable will contain a clear text error message if createFromXXXX factories experienced a parsing error.
    
    private var parseError: String?

    
    // Keeps track of the hierarchy during parsing. It is initialized when a new top level object is created in waitForTopLevelObject.
    
    private var activeObject: SwifterJSON?

    
    // The location of the character currently beiing parsed, only used for error information
    
    private var charLocation = Location()
    
    
    // Buffer to accumulate a name string
    
    private var name = ""
    
    
    // Buffer to accumulate a value string
    
    private var value = ""

    
    // Flag to indicate if a string is beiing read or not
    
    private var readingString = false
    
    
    // Marker that is set when the ending brace has been found
    
    private var endOfJsonBraceFound = false
    
    
    // MARK: -
    // MARK: From here on parsing related functions
    
    
    // The main entry for the parser
    
    private func parse(source: String) {
        
        
        // For the duration measurement
        
        let startTime = NSDate()
        
        
        // Check input parameters
        
        if source.isEmpty {
            parseError = "Empty JSON source."
            return
        }
        
        
        // Set active object to nil, to enable detection of the start-of-JSON brace "{"
        
        activeObject = nil
        
        
        // Set marker to ensure end-of-json "}" detection
        
        endOfJsonBraceFound = false
        
        
        // Initialize for skippable characters
        
        readingString = false
        
        
        // TODO: REMOVE BEFORE PUBLISHING
        
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".parse", message: "Source = " + source)
        
        
        // Start the parser at this mode
        
        var next = parseFunctionForSameChar(waitForTopLevelObject)
        
        
        // Iterate over all characters in the source
        
        for char in source {
            
            
            // Count the number of lines and the character position in the line that we are processing (used in error messages)
            
            if char == "\r" {
                charLocation.nextLine()
            } else {
                charLocation.nextCharacter()
            }
            
            
            // If this character is not part of a string and it is skippable, skip it
            
            if !readingString && SwifterJSON.charIsSkippable(char) { continue }
            
            
            // Keep on parsing this character until it is consumed, then progress to the next character

            var charProcessed = false
            while !charProcessed {
                next = next.parseStep(char)
                charProcessed = next.charIsConsumed // For some reason "while !next.charIsConsumed" will not work, a swift compiler or optimization bug?
            }
            
            
            // Check if an error occured
            
            if parseError != nil { break }
        }
        
        
        // When no error was found, check for other possible error conditions
        
        if parseError == nil {
            
        
            // Check if the start-of-JSON "{" marker was found
            
            if activeObject == nil {
                parseError = "No JSON code found, missing opening brace."
                log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".parse", message: parseError!)
                return
            }
            
            
            // Check if the end-of-JSON "}" marker was found
            
            if !endOfJsonBraceFound {
                parseError = "Incomplete JSON code, missing ending brace."
                log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".parse", message: parseError!)
                return
            }
        }
        
        
        // Meaure how long it took to parse
        
        parseDuration = -startTime.timeIntervalSinceNow
        
        
        // Log the duration
        
        let message = "JSON parser completed in \(parseDuration * 1000) mSec, JSON parsing " + (activeObject != nil ? "was successful" : "failed")
        log.atLevelInfo(id: 0, source: SwifterJSON.SOURCE + ".parse", message: message)
        
        
        return
    }
    

    
    /// Wait for the top level JSON object to start.
    
    private func waitForTopLevelObject(char: Character) -> Next {
        
        
        // Check if the top level object has started
        
        if char == SwifterJSON.OBJECT_START {
            
            
            // Self is the top level object
            
            activeObject = self
            activeObject!.parseParent = nil  // Unecessary, but makes it clear that when this member is nil, the active object is in fact the top level object.
            
            return parseFunctionForNextChar(waitForNameOrObjectEnd)
        }

        
        // Any other character is an error
        
        parseError = "Expected '{', parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".parseWaitForTopLevelObject", message: parseError!)
        
        return stopParsing()
    }
    

    /// An OBJECT start has been read.
    
    private func waitForNameOrObjectEnd(char: Character) -> Next {
        
        
        // Check for name start
        
        if char == SwifterJSON.NAME_STRING_START {
            name = ""
            readingString = true
            return parseFunctionForNextChar(waitForNameEnd)
        }

        
        // Check for end of object
        
        if char == SwifterJSON.OBJECT_END { return objectEndFound() }
            

        // Anything else is an error
        
        parseError = "Expected '}' or '\"', parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForNameOrObjectEnd", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// Wait for a name
    
    private func waitForName(char: Character) -> Next {

        
        // Check for start of name string
        
        if char == SwifterJSON.NAME_STRING_START {
            name = ""
            readingString = true
            return parseFunctionForNextChar(waitForNameEnd)
        }
            
        
        // Anything else is an error
        
        parseError = "Expected a name string to start '\"', parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForName", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// Waiting for a name string to end
    
    private func waitForNameEnd(char: Character) -> Next {
        
        
        // Check if an escape sequence started
        
        if char == SwifterJSON.ESCAPE_SEQUENCE_START {
            name.append(char)
            return parseFunctionForNextChar(nameEscapeSequence)
        }
        
        
        // Check if the the name ended
        
        if char == SwifterJSON.NAME_STRING_END {
            readingString = false
            return parseFunctionForNextChar(waitForColon)
        }
        
        
        // Anything else is added to the name string
        
        name.append(char)
        
        return parseFunctionForNextChar(waitForNameEnd)
    }
    
    
    /// An escape sequence has been found in a name string.
    
    private func nameEscapeSequence(char: Character) -> Next {
        
        
        // Is it a dual character escape sequence?
        
        if SwifterJSON.charIsSecondCharOfDoubleCharEscapeSequence(char) {
            name.append(char)
            return parseFunctionForNextChar(waitForNameEnd)
        }
        
        
        // Does a hex string follow?
        
        if char == SwifterJSON.HEX_STRING_ESCAPE_SEQUENCE {
            name.append(char)
            return parseFunctionForNextChar(nameHexDigit1)
        }
        
        
        // Anything else is an error
        
        parseError = "Expecting an escaped character, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".nameEscapeSequence", message: parseError!)
        
        return stopParsing()
    }
    
    
    // The hex digits functions
    
    private func nameHexDigit1(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            name.append(char)
            return parseFunctionForNextChar(nameHexDigit2)
        }
        
        return hexDigitsError("nameHexDigit1")
    }
    private func nameHexDigit2(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            name.append(char)
            return parseFunctionForNextChar(nameHexDigit3)
        }
        
        return hexDigitsError("nameHexDigit2")
    }
    private func nameHexDigit3(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            name.append(char)
            return parseFunctionForNextChar(nameHexDigit4)
        }
        
        return hexDigitsError("nameHexDigit3")
    }
    private func nameHexDigit4(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            name.append(char)
            return parseFunctionForNextChar(waitForNameEnd)
        }
        
        return hexDigitsError("nameHexDigit4")
    }

    
    /// Wait for object end
    
    private func objectEndFound() -> Next {

            
        // Object end, if this is the top level object, then nothing should follow
        
        if activeObject!.parseParent == nil {
            endOfJsonBraceFound = true
            return parseFunctionForNextChar(afterTopLevelObjectEnd)
        }

        
        // Not the end, go up one object in the SwifterJSON hierarchy
        
        activeObject = activeObject!.parseParent
        
        
        // If the active object is an OBJECT, then a comma or object end should follow
        
        if activeObject!.itemType == ItemType.OBJECT { return parseFunctionForNextChar(waitForCommaOrObjectEnd) }
        
        
        // The active object is an ARRAY
        
        return parseFunctionForNextChar(waitForCommaOrArrayEnd)
    }
    
    
    /// Wait for array end
    
    private func arrayEndFound() -> Next {

            
        // Array end, this cannot be the top level object, go up one object in the SwifterJSON hierarchy
        
        activeObject = activeObject!.parseParent
        
        
        // If the active object is an OBJECT, then a comma or object end should follow
        
        if activeObject!.itemType == ItemType.OBJECT { return parseFunctionForNextChar(waitForCommaOrObjectEnd) }
        
        
        // The active object is an ARRAY
        
        return parseFunctionForNextChar(waitForCommaOrArrayEnd)
    }

    
    /// Wait for a comma or the end of the object
    
    private func waitForCommaOrObjectEnd(char: Character) -> Next {
    
        
        // After a comma a new name/value pair should follow
        
        if char == SwifterJSON.COMMA { return parseFunctionForNextChar(waitForName) }
        
        
        // Not a comma, then this must be an object end
        // To enhance the error message, handle the error here, but handle the end of object in the dedicated parsing function
        
        if char == SwifterJSON.OBJECT_END { return objectEndFound() }
        
        parseError = "Expected a comma ',' or object end '}', parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForCommaOrObjectEnd", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// Wait for a comma or the end of the array
    
    private func waitForCommaOrArrayEnd(char: Character) -> Next {
        
        
        // After a comma a new value should follow
        
        if char == SwifterJSON.COMMA { return parseFunctionForNextChar(waitForValue) }
        
        
        // Not a comma, then this must be an array end
        // To enhance the error message, handle an error here, but handle the end of array in the dedicated parsing function
        
        if char == SwifterJSON.ARRAY_END { return arrayEndFound() }
        
        parseError = "Expected a comma ',' or object end ']', parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForCommaOrArrayEnd", message: parseError!)

        return stopParsing()
    }

    
    /// A name string has been completed.
    
    private func waitForColon(char: Character) -> Next {

        
        // Check if this is the colon
        
        if char == SwifterJSON.COLON { return parseFunctionForNextChar(waitForValue) }
        
        
        // The character is not expected
        
        parseError = "Expected a colon ':', parsing stopped at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForColon", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// When characters occur after the top level object has ended
    
    private func afterTopLevelObjectEnd(char: Character) -> Next {
    
        parseError = "Character occured after top level object end, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".afterTopLevelObjectEnd", message: parseError!)

        return stopParsing()
    }

    
    /// An array opening bracket has been found
    
    private func waitForValueOrArrayEnd(char: Character) -> Next {
    
        
        // Check for the end of an array
        
        if char == SwifterJSON.ARRAY_END { return arrayEndFound() }
        
        
        // Then it must be a value, handle the value in the waitForValue function, but do the error message here
        
        if char == SwifterJSON.VALUE_STRING_START  { return parseFunctionForSameChar(waitForValue) }
        if char == SwifterJSON.MINUS_SIGN          { return parseFunctionForSameChar(waitForValue) }
        if char == "0"                             { return parseFunctionForSameChar(waitForValue) }
        if SwifterJSON.charIsNumber(char)          { return parseFunctionForSameChar(waitForValue) }
        if char == SwifterJSON.OBJECT_START        { return parseFunctionForSameChar(waitForValue) }
        if char == SwifterJSON.ARRAY_START         { return parseFunctionForSameChar(waitForValue) }
        if char == "t" || char == "T"              { return parseFunctionForSameChar(waitForValue) }
        if char == "f" || char == "F"              { return parseFunctionForSameChar(waitForValue) }
        if char == "n" || char == "N"              { return parseFunctionForSameChar(waitForValue) }
        
        parseError = "Expected the start of a value or the closing brace of an empty array, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForValueOrArrayEnd", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// A name string has been completed and the colon value was read.
    
    private func waitForValue(char: Character) -> Next {
        
        
        // Check for a string start
        
        if char == SwifterJSON.VALUE_STRING_START {
            value = ""
            readingString = true
            return parseFunctionForNextChar(waitForValueStringEnd) // Note: may be an empty string
        }
        
        
        // Check for the start of a number value
        
        if char == SwifterJSON.MINUS_SIGN {
            value = ""
            readingString = true
            value.append(char)
            return parseFunctionForNextChar(valueNumberAfterSign)
        }
        if char == "0" {
            value = ""
            value.append(char)
            return parseFunctionForNextChar(valueNumberAfterFirstDigitSeries)
        }
        if SwifterJSON.charIsNumber(char) {
            value = ""
            value.append(char)
            return parseFunctionForNextChar(valueNumberFirstDigitSeries)
        }
        
        
        // Check for the start of a new object
        
        if char == SwifterJSON.OBJECT_START {
            
            
            // Add a new object to the active object, then switch the active object to the new object
            
            var newObject = SwifterJSON.createObject()
            newObject.parseParent = activeObject

            if activeObject!.itemType == ItemType.ARRAY { activeObject!.arrayItem!.append(newObject) }
            if activeObject!.itemType == ItemType.OBJECT { activeObject!.objectItem!.updateValue(newObject, forKey: name) }
            
            activeObject = newObject
            
            return parseFunctionForNextChar(waitForNameOrObjectEnd)
        }
        
        
        // Check for the start of an array
        
        if char == SwifterJSON.ARRAY_START {
            
            
            // Create a new array and add it to the active object, switch the active array to the new array
            
            var newArray = SwifterJSON.createArray()
            newArray.parseParent = activeObject

            if activeObject!.itemType == ItemType.ARRAY { activeObject!.arrayItem!.append(newArray) }
            if activeObject!.itemType == ItemType.OBJECT { activeObject!.objectItem!.updateValue(newArray, forKey: name) }

            activeObject = newArray
            return parseFunctionForNextChar(waitForValueOrArrayEnd)
        }
        
        
        // Check for the start of a boolean true value
        
        if char == "t" || char == "T" { return parseFunctionForNextChar(valueBooleanTrueChar2) }
        
        
        // Check for the start of a boolean false value
        
        if char == "f" || char == "F" { return parseFunctionForNextChar(valueBooleanFalseChar2) }
        
        
        // Check for the start of a null value
        
        if char == "n" || char == "N" { return parseFunctionForNextChar(valueNullChar2) }
        
        
        // Illegal start of value
        
        parseError = "Expected the start of a value, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".waitForValue", message: parseError!)
        
        return stopParsing()
    }

    
    ///  A value string has started.
    
    private func waitForValueStringEnd(char: Character) -> Next {
        
        
        // Check if an escape sequence started
        
        if char == SwifterJSON.ESCAPE_SEQUENCE_START {
            value.append(char)
            return parseFunctionForNextChar(valueStringEscapeSequence)
        }
        
        
        // If this is the end of the string, then add the read value to either object or array
        
        if char == SwifterJSON.VALUE_STRING_END {
            
            readingString = false
            
            let obj = SwifterJSON(value)
            obj.parseParent = activeObject
            
            var next = addValueToParent(obj)
            return parseFunctionForNextChar(next.parseStep) // Because the end-of-string character must be discarded
        }
        
        
        // Just another string character
        
        value.append(char)
        return parseFunctionForNextChar(waitForValueStringEnd)
    }
    
    
    /// The value object is ready for insertion in the enclosing object
    
    private func addValueToParent(obj: SwifterJSON) -> Next {

        
        // Add the value to the current object, and wait for more or the end of the current object
        
        if activeObject!.itemType == ItemType.ARRAY {
            
            activeObject!.arrayItem!.append(obj)
            return parseFunctionForSameChar(waitForCommaOrArrayEnd)
            
        } else {
            
            activeObject!.objectItem!.updateValue(obj, forKey: name)
            return parseFunctionForSameChar(waitForCommaOrObjectEnd)
        }
    }

    
    /// An escape sequence for a string value has started. The escape sequence must be validated.
    
    private func valueStringEscapeSequence(char: Character) -> Next {
        
        
        // Is it a dual character escape sequence?
        
        if SwifterJSON.charIsSecondCharOfDoubleCharEscapeSequence(char) {
            value.append(char)
            return parseFunctionForNextChar(waitForValueStringEnd)
        }
        
        
        // Does a hex string follow?
        
        if char == SwifterJSON.HEX_STRING_ESCAPE_SEQUENCE {
            value.append(char)
            return parseFunctionForNextChar(valueStringHexDigit1)
        }
        
        
        // Anything else is an error
        
        parseError = "Expected an escaped character, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".valueStringEscapeSequence", message: parseError!)
        
        return stopParsing()
    }
    
    
    // The hex digit functions
    
    private func valueStringHexDigit1(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            value.append(char)
            return parseFunctionForNextChar(valueStringHexDigit2)
        }
        
        return hexDigitsError("valueStringHexDigit1")
    }
    private func valueStringHexDigit2(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            value.append(char)
            return parseFunctionForNextChar(valueStringHexDigit3)
        }
        
        return hexDigitsError("valueStringHexDigit2")
    }
    private func valueStringHexDigit3(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            value.append(char)
            return parseFunctionForNextChar(valueStringHexDigit4)
        }
        
        return hexDigitsError("valueStringHexDigit3")
    }
    private func valueStringHexDigit4(char: Character) -> Next {
        
        if SwifterJSON.charIsHexadecimalDigit(char) {
            value.append(char)
            return parseFunctionForNextChar(waitForValueStringEnd)
        }
        
        return hexDigitsError("valueStringHexDigit4")
    }

    
    /// The sign character of a number was found, process next character.
    
    private func valueNumberAfterSign(char: Character) -> Next {

        
        // If it is a zero, then the first digit series has ended
        
        if char == "0" {
            value.append(char)
            return parseFunctionForNextChar(valueNumberAfterFirstDigitSeries)
        }
        
        
        // If the first character is not a zero, but another number, then the first digit series is ongoing
        
        if SwifterJSON.charIsNumber(char) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberFirstDigitSeries)
        }
        
        
        // This is an error
        
        parseError = "Expected a number, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".valueNumberAfterSign", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// The value part of an value number has started with a non-zero number.
    
    private func valueNumberFirstDigitSeries(char: Character) -> Next {
        
        
        // Continue the first digit series if it is a number
        
        if SwifterJSON.charIsNumber(char) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberFirstDigitSeries)
        }
        
        
        // Its not a number, then the first digit series has ended
        
        return parseFunctionForSameChar(valueNumberAfterFirstDigitSeries)
    }
    
    
    /// The first digit series of a value number has ended, next should be a dot, a blank, an exponent or the end of the number.
    
    private func valueNumberAfterFirstDigitSeries(char: Character) -> Next {
        
        
        // If this is a period, then the fraction can start
        
        if char == "." {
            value.append(char)
            return parseFunctionForNextChar(valueNumberFractionStart)
        }
        
        
        // There is no period, thus no fraction. If there is also no exponent, then the number must be an integer
        
        if ((char != "e") && (char != "E")) {
            
            let obj = SwifterJSON(value.toInt()!)
            obj.parseParent = activeObject
            
            return addValueToParent(obj)
        }
        
        
        // Anything else means that the fraction has ended
        
        return parseFunctionForSameChar(valueNumberAfterFraction)
    }
    
    
    /// A period was encountered, a number must follow to start the fraction.
    
    private func valueNumberFractionStart(char: Character) -> Next {
        
        
        // There must at least be one fraction digit (after a period)
        
        if SwifterJSON.charIsNumber(char) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberFractionContinue)
        }
        
        
        // Anything else is an error
        
        parseError = "Expected a number, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".valueNumberFractionStart", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// A fraction digit series is ongoing
    
    private func valueNumberFractionContinue(char: Character) -> Next {
        
        
        // If it is a number, then its part of the fraction
        
        if SwifterJSON.charIsNumber(char) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberFractionContinue)
        }
        
        
        // Else the fraction has ended
        
        return parseFunctionForSameChar(valueNumberAfterFraction)
    }
    
    
    /// The fraction part has finished check if an exponent is present
    
    private func valueNumberAfterFraction(char: Character) -> Next {
        
        
        // If it is an e or E then the exponent can start
        
        if (char == "e") || (char == "E") {
            value.append(char)
            return parseFunctionForNextChar(valueNumberStartExponent)
        }
        
        
        // Anything else means the exponent is not present, but this is still a double value
        
        let obj = SwifterJSON(SwifterJSON.toDouble(value)!)
        obj.parseParent = activeObject
        
        return addValueToParent(obj)
    }
    
    
    /// A number has been read up to and including the 'e' or 'E'
    
    private func valueNumberStartExponent(char: Character) -> Next {
        
        
        // Signs are OK
        
        if ((char == "-") || (char == "+")) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberStartExponentDigits)
        }
        
        
        // Any number is OK
        
        if SwifterJSON.charIsNumber(char) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberExponentDigits)
        }
        
        
        // Anything else is an error
        
        parseError = "Expected start of exponent, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".valueNumberStartExponent", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// The exponent sign has been read.
    
    private func valueNumberStartExponentDigits(char: Character) -> Next {
        
        // Only numbers may be added
        
        if SwifterJSON.charIsNumber(char) { return parseFunctionForSameChar(valueNumberExponentDigits) }
        
        
        //  In an exponent there must be at least one number.
        
        parseError = "Expected a number, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + ".valueNumberStartExponentDigits", message: parseError!)
        
        return stopParsing()
    }
    
    
    /// At least one number of the exponent has already been read.
    
    private func valueNumberExponentDigits(char: Character) -> Next {
        
        
        // Only numbers may be added
        
        if SwifterJSON.charIsNumber(char) {
            value.append(char)
            return parseFunctionForNextChar(valueNumberExponentDigits)
        }
        
        
        // Anything else is the end of the number, add it to the active object
        
        let obj = SwifterJSON(SwifterJSON.toDouble(value)!)
        obj.parseParent = activeObject
        
        return addValueToParent(obj)
    }
    
    
    // The boolean true functions
    
    private func valueBooleanTrueChar2(char: Character) -> Next {
        
        if char == "r" || char == "R" { return parseFunctionForNextChar(valueBooleanTrueChar3) }
        
        return booleanTrueError(forCharacter: "r", inFunction: "valueBooleanTrueChar2")
    }
    private func valueBooleanTrueChar3(char: Character) -> Next {
        
        if char == "u" || char == "U" { return parseFunctionForNextChar(valueBooleanTrueChar4) }
        
        return booleanTrueError(forCharacter: "u", inFunction: "valueBooleanTrueChar3")
    }
    private func valueBooleanTrueChar4(char: Character) -> Next {
        
        if char == "e" || char == "E" {
            let obj = SwifterJSON(true)
            obj.parseParent = activeObject
            var next = addValueToParent(obj)
            return parseFunctionForNextChar(next.parseStep) // Because this character must be discarded
        }
        
        return booleanTrueError(forCharacter: "e", inFunction: "valueBooleanTrueChar4")
    }
    
    
    // The boolean false functions
    
    private func valueBooleanFalseChar2(char: Character) -> Next {
        
        if char == "a" || char == "A" { return parseFunctionForNextChar(valueBooleanFalseChar3) }
        
        return booleanFalseError(forCharacter: "a", inFunction: "valueBooleanFalseChar2")
    }
    private func valueBooleanFalseChar3(char: Character) -> Next {
        
        if char == "l" || char == "L" { return parseFunctionForNextChar(valueBooleanFalseChar4) }
        
        return booleanFalseError(forCharacter: "l", inFunction: "valueBooleanFalseChar3")
    }
    private func valueBooleanFalseChar4(char: Character) -> Next {
        
        if char == "s" || char == "S" { return parseFunctionForNextChar(valueBooleanFalseChar5) }
        
        return booleanFalseError(forCharacter: "s", inFunction: "valueBooleanFalseChar4")
    }
    private func valueBooleanFalseChar5(char: Character) -> Next {
        
        if char == "e" || char == "E" {
            let obj = SwifterJSON(false)
            obj.parseParent = activeObject
            var next = addValueToParent(obj)
            return parseFunctionForNextChar(next.parseStep) // Because this character must be discarded

        }
        
        return booleanFalseError(forCharacter: "e", inFunction: "valueBooleanFalseChar5")
    }
    
    
    // The null functions
    
    private func valueNullChar2(char: Character) -> Next {
        
        if char == "u" || char == "U" { return parseFunctionForNextChar(valueNullChar3) }
        
        return nullError(forCharacter: "u", inFunction: "valueNullChar2")
    }
    private func valueNullChar3(char: Character) -> Next {
        
        if char == "l" || char == "L" { return parseFunctionForNextChar(valueNullChar4) }
        
        return nullError(forCharacter: "l", inFunction: "valueNullChar3")
    }
    private func valueNullChar4(char: Character) -> Next {
        
        if char == "l" || char == "L" {
            let obj = SwifterJSON()
            obj.parseParent = activeObject
            var next = addValueToParent(obj)
            return parseFunctionForNextChar(next.parseStep) // Because this character must be discarded
        }
        
        return nullError(forCharacter: "l", inFunction: "valueNullChar4")
    }

    
    // Used when no other usefull function can be returned.
    // Note: None of these two functions should ever be called.
    
    private func dummy(char: Character) -> Next {
        let message = "Dummy JSON parsing function called, this should not happen, " + charLocation.description()
        log.atLevelError(id: 0, source: SwifterJSON.SOURCE + ".dummy", message: message)
        return Next(parseStep: dummyNoLog, charIsConsumed: true)
    }
    private func dummyNoLog(char: Character) -> Next {
        return Next(parseStep: dummyNoLog, charIsConsumed: true)
    }
    

    // A helper function to generate error information when a not-hex character is encountered in a '\uXXXX' escape sequence.
    
    private func hexDigitsError(location: String) -> Next {
        parseError = "Expected a hexadecimal digit, parsing aborted at " + charLocation.description()
        log.atLevelError(id: 0, source: SwifterJSON.SOURCE + "." + location, message: parseError!)
        return stopParsing()
    }
    
    
    // A helper function to generate error information when an unexpected character occurs in a boolean true value.
    
    private func booleanTrueError(forCharacter e: Character, inFunction: String) -> Next {
        parseError = "Expected '\(e)' of boolean true, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + "." + inFunction, message: parseError!)
        return stopParsing()
    }
    
    
    // A helper function to generate error information when an unexpected character occurs in a boolean false value.
    
    private func booleanFalseError(forCharacter e: Character, inFunction: String) -> Next {
        parseError = "Expected '\(e)' of boolean false, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + "." + inFunction, message: parseError!)
        return stopParsing()
    }
    
    
    // A helper function to generate error information when an unexpected character occurs in a null value.
    
    private func nullError(forCharacter e: Character, inFunction: String) -> Next {
        parseError = "Expected '\(e)' of null value, parsing aborted at " + charLocation.description()
        log.atLevelDebug(id: 0, source: SwifterJSON.SOURCE + "." + inFunction, message: parseError!)
        return stopParsing()
    }

    
    // A helper to make the code more readable
    
    private func parseFunctionForNextChar(step: parseFunction) -> Next {
        return Next(parseStep: step, charIsConsumed: true)
    }
    
    
    // A helper to make the code more readable
    
    private func parseFunctionForSameChar(step: parseFunction) -> Next {
        return Next(parseStep: step, charIsConsumed: false)
    }
    
    
    // A helper to make the code more readable

    private func stopParsing() -> Next {
        return Next(parseStep: dummy, charIsConsumed: true)
    }
    

    // For logging purposes, identifies the source of a logging entry

    private static let SOURCE = "SwifterJSON"
    
    
    // Default leniency, used for all default leniency parameters, not including the subscript operations.
    
    private static var defaultLeniency = true
    
    
    // A few definitions that make the code more readable
    
    private static let NAME_STRING_START: Character = "\""
    private static let NAME_STRING_END: Character = "\""
    private static let VALUE_STRING_START: Character = "\""
    private static let VALUE_STRING_END: Character = "\""
    private static let OBJECT_START: Character = "{"
    private static let OBJECT_END: Character = "}"
    private static let ARRAY_START: Character = "["
    private static let ARRAY_END: Character = "]"
    private static let COMMA: Character = ","
    private static let PLUS_SIGN: Character = "+"
    private static let MINUS_SIGN: Character = "-"
    private static let ESCAPE_SEQUENCE_START: Character = "\\"
    private static let HEX_STRING_ESCAPE_SEQUENCE: Character = "u"
    private static let COLON: Character = ":"
    
    
    // Keep track of the line and character position within a line
    
    private struct Location {
        var inLine = 1
        var atCharacter = 0
        mutating func nextLine() {
            inLine += 1
            atCharacter = 0
        }
        mutating func nextCharacter() {
            atCharacter += 1
        }
        func description() -> String {
            return "line = \(inLine), character = \(atCharacter)"
        }
    }

    
    // Signature of the parsing functions with helper functions to make the code more readable
    
    private typealias parseFunction = (Character) -> Next
    private struct Next {
        let parseStep: parseFunction
        let charIsConsumed: Bool
    }
    
    
    // Helper functions to determine the class of character
    
    private static func charIsSkippable(char: Character) -> Bool {
        switch char {
        case " ", "\t", "\r", "\n": return true
        default: return false
        }
    }
    
    private static func charIsNumber(char: Character) -> Bool {
        switch char {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9": return true
        default: return false
        }
    }
    
    private static func charIsHexadecimalDigit(char: Character) -> Bool {
        if charIsNumber(char) { return true }
        switch char {
        case "a", "A", "b", "B", "c", "C", "d", "D", "e", "E", "f", "F": return true
        default: return false
        }
    }
    
    private static func charIsSecondCharOfDoubleCharEscapeSequence(char: Character) -> Bool {
        switch char {
        case "\"", "\\", "/", "b", "f", "n", "r", "t": return true
        default: return false
        }
    }

    private static var formatter: NSNumberFormatter?
    
    private static func toDouble(str: String) -> Double? {
        if SwifterJSON.formatter == nil {
            SwifterJSON.formatter = NSNumberFormatter()
            SwifterJSON.formatter!.decimalSeparator = "."
        }
        return SwifterJSON.formatter!.numberFromString(str)!.doubleValue
    }
}


// TODO: Either provide your own logger and remove the following class, or leave the following class in, or modify the code

private class Log {
    func atLevelDebug(#id: Int32, source: String, message: String){}
    func atLevelInfo(#id: Int32, source: String, message: String){}
    func atLevelError(#id: Int32, source: String, message: String){}
}
private let log = Log()

/** End of file **/
