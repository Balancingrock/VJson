#SwifterJSON

Two single class frameworks in Swift to read/write & parse the JSON Format.

SwifterJSON is part of the 5 packages that make up the Swiftfire webserver:

#####Swiftfire

An open source web server in Swift.

#####SwiftfireConsole

A GUI application for Swiftfire.

#####[SwifterSockets](https://github.com/Swiftrien/SwifterSockets)

General purpose socket utilities.

#####[SwifterLog](https://github.com/Swiftrien/SwifterLog)

General purpose logging utility.

There is a 6th package called SwiftfireTester that can be used to challenge a webserver (any webserver) and see/verify the response.

##Note

SwifterJSON is the original implementation, but as that was rather slow, a new parser called VJson was implented. SwifterJSON development has been stopped.

VJson is faster and has many of the same features as SwifterJSON.

#Features
- Creates a fully featured JSON hierarchy from file (or String).
- Easy subscript accessors (creation & interrogation).
- Interrogation operations for item existence and item types.
- Interpret items as other types (eg read a Bool as a String).

#Usage
To use VJson: Add the files ASCII.swift and VJson to your project.

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


History:

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
