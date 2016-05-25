#SwifterJSON

A single class framework in Swift to read/write & parse the JSON Format.

SwifterJSON is part of the 5 packages that make up the [Swiftfire](http://swiftfire.nl) webserver:

#####[Swiftfire](https://github.com/Swiftrien/Swiftfire)

An open source web server in Swift.

#####[SwiftfireConsole](https://github.com/Swiftrien/SwiftfireConsole)

A GUI application for Swiftfire.

#####[SwifterSockets](https://github.com/Swiftrien/SwifterSockets)

General purpose socket utilities.

#####[SwifterLog](https://github.com/Swiftrien/SwifterLog)

General purpose logging utility.

There is a 6th package called SwiftfireTester that can be used to challenge a webserver (any webserver) and see/verify the response.


#Features
- Creates a fully featured JSON hierarchy from file (or String).
- Intuitive subscript accessors (for creation & interrogation).
- Interrogation operations for item existence and item types.
- Interpret items as other types (eg read a Bool as a String or vice-versa).

#Usage
Add the files ASCII.swift and VJson.swift to your project.

Example usage (Full example, you can use the code below directly)

    func testExample() {
        
        let top = VJson.createJsonHierarchy()
        top["books"][0]["title"].stringValue = "THHGTTG"
        let myJsonString = top.description
        
        // Use the above generated string to read JSON code
        
        let data = myJsonString.dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            let json = try VJson.createJsonHierarchy(UnsafePointer<UInt8>(data.bytes), length: data.length)
            if let title = json["books"][0]["title"].stringValue {
                print("The title of the first book is: " + title)
            } else {
                print("The title of the first book in myJsonString was not found")
            }
        } catch let error as VJson.Exception {
            print(error.description)
        } catch {}
    }

#Notes:

The subscript accessors have a side-effect of creating items that are not present to satisfy the full path.

I.e.

    let json = VJson.createJsonHierarchy()
    guard let name = json["root"][2]["name"].stringValue else { return }
    
will create all items necessary to resolve the path. Even though the string value will not be assigned to the let property because it does not exist. This can easily produce undesired side effects even though unnecessary items will be removed automatically before persisting the hierarchy.

To avoid those side effects use the pipe operators:

    let json = VJson.createJsonHierarchy()
    guard let name = (json|"root"|2|"name")?.stringValue else { return }

As a general rule: use the pipe operators to read from a JSON hierarchy and use the subscript accessors to create the JSON hierarchy.

#History:

####v0.9.5

- Added "pipe" functions ("|") to allow for better testing of paths. The pipe functions greatly improve the readability when used in 'guard' statements.


####v0.9.4

- Changed target to a (shared) framework
- Added 'public' definitions to support the framework target
- Added release tags

####v0.9.3 (VJson)

- Changed "removeChild:atIndex" to "removeChildAtIndex:withChild"
- Added conveniance operation "addChild" that does not need the name of the child to be added.
- Changed behaviour of "addChild:name" to change the item into an OBJECT if it is'nt one.
- Changed behaviour of "appendChild" to change the item into an ARRAY if it is'nt one.
- Upgraded to Swift 2.2
- Removed dependency on SwifterLog
- Updated for changes in ASCII.swift (added hexLookUp, changed is___ functions to var's)

####v0.9.2 (VJson)

- Fixed a problem where a named NULL object was removed from the hierarchy upon fetching the description.

####v0.9.1 (VJson)

- Changed parameter to 'addChild' to an optional.
- Fixed a problem where an object without a leading brace in an array would not be thrown as an error
- Changed 'makeCopy()' to 'copy' for constency with other projects
- Fixed the asString for BOOL types
- Changed all "...Value" returns to optionals (makes more sense as this allows the use of guard let statements to check the JSON structure.
- Overhauled the child support interfaces (changes parameters and return values to optionals)
- Removed 'set' access from arrayValue and dictionaryValue as it could potentially lead to an invalid JSON hierarchy
- Fixed subscript accessors, array can now be used on top-level with an implicit name of "array"
- Fixed missing braces around named objects in an array

Also added unit tests for VJson and performance tests for Apple's JSON, SwifterJSON and VJson.

####v0.9.0 (VJson)

- Initial release

######The versions below refer to the older SwifterJSON class (this is no longer updated)

V0.9.5

- Added some throw-ing functions that duplicate existing functions.
- Changed type inspection functions to var's.
- Added note about performance.

V0.9.4

- Updated to Swift 2.0 syntax

V0.9.3

- Removed the method "values"
- Added var dictionary to retrieve and set the Dictionary<String, SwifterJSON> from a json OBJECT.
- Added var array to retrieve and set the Array<SwifterJSON> from a json ARRAY.

V0.9.2

- Fixed a bug that caused the 'writeJSONHierarchyToFile' to fail when the file already existed
- Added convenience initialiser to accept Array<SwifterJSON>
- Added convenience initialiser to accept Dictionary<String, SwifterJSON>
- Added 'final' to the class definition
- Re-read all text and comments, updated some of it.
- Added the Equatable protocol to the SwifterJSON class definition (this was already defacto the case)

V0.9.1

- is used in a shipping application
- Moved the private definitions inside the class to avoid name collisions
- Replaced type extensions with static class methods
- Made pseudo 'static" definitions (Swift 1.0) to real class static definitions (Swift 1.2)
- Changed logging SOURCE from SwiftON to SwifterJSON
- Changed to all-caps writing of JSON for public interfaces

V0.9.0

- is not yet real-world tested! But it does pass the unit tests.
