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

let (topOrNil, errorOrNil) = SwifterJSON.createJsonHierarchyFromString(myJsonString)
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

Warning: Release 0.9 is not yet real-world tested! But it does pass the unit tests.
