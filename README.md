# SwifterJSON

Two single class frameworks in Swift to read/write & parse the JSON Format.

SwifterJSON is the original implementation, but as that was rather slow, a new parser called VJson was implented. It is anticipated that SwifterJSON will eventually be retired.

However VJson is faster and has many of the same features as SwifterJSON.

To use SwifterJSON: Just add the SwifterJSON.swift file to your project, this is the only file you need. You can find it in the "SwifterJSON" directory.

To use VJson: Add the files ASCII.swift and VJson to your project.

Example usage (Full example, you can use the code below directly)

<pre>
// Create a string with JSON code

let top = SwifterJSON.createJSONHierarchy()
top["books"][0]["title"].stringValue = "THHGTTG"
let myJsonString = top.description()

// Use the above generated string to read JSON code

let (topOrNil, errorOrNil) = SwifterJSON.createJSONHierarchyFromString(myJsonString)
if let top = topOrNil {
    if let title = top["books"][0]["title"].stringValue {
       println("The title of the first book is: " + title)
    } else {
       println("The title of the first book in myJsonString was not found")
    }
} else {
  println(errorOrNil!)
}
</pre>
See the header of the SwifterJSON file for more on how to start using this framework.

VJson can be used in the same way. Except that the return from the createJsonHierarchy throws its error rather than passing it back as a tuple.

History:

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
