# SwifterJSON

A single class framework in Swift to read/write & parse the JSON Format.

Just add the SwifterJSON.swift file to your project, this is the only file you need. You can find it in the "SwifterJSON" directory.

A full xcode project can also be dowloaded which includes the tests.

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

History:

Release 0.9.2, changes against 0.9.1
- Fixed a bug that caused the 'writeJSONHierarchyToFile' to fail when the file already existed
- Added convenience initialiser to accept Array<SwifterJSON>
- Added convenience initialiser to accept Dictionary<String, SwifterJSON>
- Added 'final' to the class definition
- Re-read all text and comments, updated some of it.
- Added the Equatable protocol to the SwifterJSON class definition (this was already defacto the case)

Release 0.9.1 is used in a shipping application, changes against previous release:
- Moved the private definitions inside the class to avoid name collisions
- Replaced type extensions with static class methods
- Made pseudo 'static" definitions (Swift 1.0) to real class static definitions (Swift 1.2)
- Changed logging SOURCE from SwiftON to SwifterJSON
- Changed to all-caps writing of JSON for public interfaces

Release 0.9.0 is not yet real-world tested! But it does pass the unit tests.
