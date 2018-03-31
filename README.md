# VJson

A single class framework in Swift to read, write & parse the JSON Format.

VJson is part of the [Swiftfire](http://swiftfire.nl), the HTTP(S) webserver framework.

# Features
- Creates a fully featured JSON hierarchy from file (Data, Buffer or String).
- Intuitive subscript accessors (for creation).
- Intuitive pipe accessors (for interrogation).
- Interpret items as other types (eg read a Bool as a String or vice-versa).
- Allows multiple values with identical names in an OBJECT.
- Allows ARRAYs with different JSON types.
- Overloaded assignment operators for readable code.
- Auto creation of null values for optional items that are nil.
- Type conflicts can be configured to create fatal errors (is default).
- Build with Swift 3
- Includes extensive unit tests
- Use either integrated parser or Apple's NSJSONSerialization parser
- Builds with SPM (Swift Package Manager)
- Builds with Xcode as modular framework
- Merge function is NSOutlineView compatible
- Limited KVO support to provide easier integration with -for example- an NSOutlineView
- Notifications are isued for KVO updates.
- Undo/redo support for macOS
- Caching of named members for higher performance (usable in most cases)
- Prepared for use under Linux (but not tested yet)

# Installation

## With SPM

To use VJson with a SPM project, make it part of the dependencies in the file Package.swift:

~~~~
   dependencies: [
      ...
      .Package(url: "https://github.com/Balancingrock/VJson", "0.10.0")
      ...
   ]
~~~~

Building the project will then automatically install VJson as needed.

## Xcode (Framework)

To use VJson in a macOS application using Xcode it is necessary to create a framework.

These are the steps to create a framework:

In a terminal window type on the console line:

~~~~
$ git clone https://github.com/Balancingrock/VJson
$ cd VJson
$ swift package generate-xcodeproj
~~~~

Then navigate to the VJson folder using the Finder and double click the xcode project file.

In Xcode select the target frameworks and make sure that under the `Build settings` in the `Packaging` options the `Defines Module` is set to 'yes'.

Then build the target.

In the project that should use VJson add the generated framework's (Ascii & VJson) under the target's `general` settings, to the `Embedded binaries`.

(Note: to find out where the frameworks are located, select the framework and show the file inspector, that will show the path)

Then import the framework where you need it by:

"import VJson"

at the top of the source code files.

# Documentation

The project itself: [VJson](http://swiftfire.nl/projects/vjson/vjson.html)

The reference manual: [reference manual](http://swiftfire.nl/projects/vjson/reference/index.html)

## Full Example

This code can be used as is:

    func testExample() {
    
        let top = VJson() // Create JSON hierarchy
        top["books"][0]["title"] &= "THHGTTG"
        let jsonCode = top.code
        
        do {
            let json = try VJson.parse(jsonCode)
            if let title = (json|"books"|0|"title")?.stringValue {
                XCTAssertEqual(title, "THHGTTG")
            } else {
                XCTFail("The title of the first book in the JSON code was not found")
            }
        } catch let error {
            XCTFail("Parser failed: \(error)")
        }
    }

## Typical use cases:

Create an empty top level JSON item:

	let json = VJson()

Create a JSON hierarchy from input:

	let json = try VJson.parse(fileUrl)
	let json = try VJson.parse(uInt8Ptr, numberOfBytes)
	let json = try VJson.parse(string)
	let json = try VJson.parse(nsMutableData)

Or without exceptions:

	let json = VJson.parse(fileUrl) {... error handler ...}
	let json = VJson.parse(uInt8Ptr, numberOfBytes) {... error handler ...}
	let json = VJson.parse(string) {... error handler ...}
	let json = VJson.parse(nsMutableData) {... error handler ...}
	
Note1: Creating from NSMutableData removes the data that was used from the buffer.

Note2: The signature of the error handler is `(code: Int, incomplete: Bool, message: String) -> Void`.

Creating values:

	let n = VJson(8)
	let n = VJson(3.12)
	let b = VJson(true)
	let s = VJson("A String")
	
Create a collection type:

	let a = VJson.array()
	let o = VJson.object()
	
Creating a named item:

	let n = VJson(8, name: "AnyName")
	let n = VJson(3.12, name: "AnyName")
	let b = VJson(true, name: "AnyName")
	let s = VJson("A String", name: "AnyName")
	let a = VJson.array(name: "AnyName")
	let o = VJson.object(name: "AnyName")

Preferred way of creating a VJson hierarchy:

	let json = VJson()
	json["description"] @= "Book price list"
	json["books"][0]["title"] @= "Book Title"
	json["books"][0]["price"] @= 12.34
	json["books"][1]["title"] @= "Second Book Title"

	
Preferred way of inspecting/retrieving from an hierarchy:

	guard let title = (json|"books"|0|"title")?.stringValue else {...}
	guard let price = (json|"books"|0|"price")?.doubleValue else {...}

Adding a (named) item to an object:

	let o = VJson.object()
	o.add(VJson(8), name: "AnyName")		// {"AnyName":8}
	
is equivalent to:

	let o = VJson.object()
	o.add(VJson(8, name: "AnyName"))		// {"AnyName":8}

Adding an item to an array:

	let a = VJson.array()
	a.append(VJson(8))						// [8]

is equivalent to:

	let a = VJson.array()
	a.append(VJson(8, name: "AnyName"))	// [8]

Create an item in the hierarchy:

	let json = VJson()						// {}
	var i: Int?
	json["first"].intValue = i			// {"first":null}

or

	let json = VJson()						// {}
	var i: Int?
	i = 12
	json["first"].intValue = i			// {"first":12}

Or using the defined operator "&=":

	json["first"] &= 23						// {"first":23}

Changing the type of "first" to a string:

	json["first"] &= "second"  				// {"first":"second"}

Creating JSON OBJECTs and ARRAYs implicitly using subscript accessors:

	let json = VJson()
	json["books"][2]["Authors"][0] &= "Jane" // {"books":[null, null, {"Authors":["Jane"]}]}

Adding a JSON OBJECT to a JSON OBJECT explicitly:

	let json = VJson()						// {}
	json["first"] &= "second"  				// {"first":"second"}
	json.add(VJson.object(name: "Child"))	// {"first":"second","Child":{}}
	
Adding a JSON ARRAY to a JSON OBJECT explicitly:

	json.add(VJson.array(), name: "Array")	// {"first":"second","Child":{},"Array":[]}

Adding a JSON OBJECT to a JSON ARRAY explicitly:

	let json = VJson
	json["Arr"].append(VJson.object(name: "No1")) // {"Arr":[{"No1":{}}]}
	
Testing for and retrieving of values:

	guard let title = (json|"Book"|3|"Title")?.stringValue else { ... }
	
Itterating over all children of an object (or array):

	for child in json { ... }

The above examples all used 'let' variables. If 'var's are used there is another option is available to retrieve values from a VJson object

	let json = try! VJson.parse(string: "{\"title\":\"A Good Read\"}")
	var title: String?
	title &= (json|"title")


# Notes:
## Subscript vs pipe operator

The subscript accessors have a side-effect of creating items that are not present to satisfy the full path.

I.e.

    let json = VJson()
    guard let name = json["root"][2]["name"].stringValue else { return }
    
will create all items necessary to resolve the path. Even though the string value will not be assigned to the let property because it does not exist. The unnecessary items will be removed automatically before persisting the hierarchy. But creating and destroying unneccesary items takes time that could be spend differently. 

To avoid those side effects use the pipe operator:

    let json = VJson()
    guard let name = (json|"root"|2|"name")?.stringValue else { return }

As a general rule: use the pipe operators to read from a JSON hierarchy and use the subscript accessors to create the JSON hierarchy.

It is possible to use the pipe opertors to assign values to the JSON hierarchy, but only if the item that is written to already exists:

	let json = VJson()         			// results in: {}
	(json|"top"|2|"name")? &= 42 		// results in: {}
	json["top"][2]["name"] &= 42		// results in: {"top":[null, null, {"name":42}]}

## Values with names in an array

Every object in a VJson hierarchy is a VJson object. This is very convenient, but also poses somewhat of a challenge: The JSON specification treats values differently depending on whether they are contained in an ARRAY or OBJECT. In an OBJECT the values have names (or key's in NS parlour). In an ARRAY values are simply values without a name. However since VJson provides only one type of object for everything, this object must have a name component. The optionality of this name thus depends on where the VJson object is used.
What if a VJson VALUE with a specified name is inserted into an array? Well, the name will be ignored. This leads (possibly) to information loss, but the alternative would be to create an extra object in the hierarchy. If this is the preferred behaviour, it is up to the application to create that object explicitly.
In an example:

	let json = VJson()
	json["top"].append(VJson(12))				// results in: {"top":[12]}
	
	let json = VJson()
	json["top"].append(VJson(12, name: "one"))	// results in: {"top":[12]}

## JSON item type changes

Allowing the use of subscript accessors without optionality necessitates a leniet behaviour towards JSON item type conversions. To prevent that the application code inadvertently changes the type of a JSON item a fatal error will be thrown if that happens.

Type changes to or from the JSON NULL type are always considered legal.

All other type changes -for example- a BOOL to an ARRAY or from STRING to a NUMBER will result in a fatal error when the static option "fatalErrorOnTypeConversion" is set to 'true' (which is the default). Such type changes can only be made by transistioning explicitly through a JSON NULL type.

To allow leniency for type changes not involving NULL, set "fatalErrorOnTypeConversion" to 'false'.

Do note however that the operations "add" and "append" are not lenient. I.e. it is not possible to "add" to an ARRAY or "append" to an OBJECT as that could result in data loss. However there are operations to change an ARRAY into an OBJECT and vice versa.

## Differences between standard parser or Apple's NSJSONSerialization parser

The advantage of Apple's parser is that it is faster, about twice as fast as the standard parser on the MacBook Pro and PowerMac. However Apple's parser has at least two drawbacks:

- Apple's parser cannot handle multiple name/value pairs with identical names. I.e. {"test":1,"test":2} will fail. With the provided VJson parser this will result in an object with two childeren with identical names. Accessable through the "arrayValue" accessor.

- Apple's parser handles JSON BOOL items as NSNumber's and hence must be interrogated as a JSON NUMBER item. This results in a symmetry break when json code with a bool in it is converted into a VJson hierarchy and that hierachy is then translated back into code. (The in- and output code will not be the same)

# History:

Note: Planned releases are for information only and subject to change without notice.

#### 1.1.0 (Open)

- No new features planned. Features and bugfixes will be made on an ad-hoc basis as needed to support Swiftfire development.
- To request features or bug fixes please contact rien@balancingrock.nl

#### 1.0.0 (Planned)

- Bugfixes or features as necessary for Swiftfire 1.0

#### 0.10.8 (Current)

- BRUtils was updated to 0.10.0

#### 0.10.8

- Split the implementation into multiple source files
- Added undo/redo support
- Harmonized with Foundation class behaviour (minor changes in usage)

#### 0.10.7

- Renamed from SwifterJSON to VJson

#### 0.10.6

- Upped BRUtils to 0.5.0

#### 0.10.5

- Upped BRUtils to 0.4.0

#### 0.10.4

- Added CustomStringConvertible to JType
- Added setter to "asString"
- Added item(at path) methods

#### 0.10.3

- Bugfix: removed the 'parent' retain cycle. (Caused a memory leak)

#### 0.10.2

- Removed unnecessary @discardableresult declaration
- Fixed the sequence of type extractions for key/value coding

#### 0.10.1

- Removed the xcode project from git

#### 0.10.0

- Bugfix: Assigning a nil to a ...Value did not cause an auto-converion to NULL.
- Bugfix: Corrected a bug that would ignore duplicate member names in an object.
- Added "merge" function to update a VJson hierarchy in-place
- Added caching mechanism for object members
- Added limited KVO support
- Reorganised the code
- Added conditional compilation for linux (not tested yet)

#### 0.9.16

- Moved Ascii into its own package.
- Removed custom operator definitions from tests.

#### 0.9.15

- Bugfix: Removed the redefinition of the custom operators.

#### 0.9.14

- Updated documentation and minor modifications to the access levels.
- Moved to package based distribution.

#### v0.9.13

- Bugfix: Added missing 'public' to conveniance initializers
- Added '&=' assignments of VJson to for var's

#### 0.9.12

- Added "findPossibleJsonCode'.
- Fixed bug that failed to skip whitespace characters after a comma. 

#### 0.9.11

- Update for Xcode 8 beta 6 (Swift 3)
- Added &= operator to add VJson objects

#### 0.9.10

- Update for Xcode 8 beta 3 (Swift 3)

#### 0.9.9

- Added NSJSONSerialization parsing

#### 0.9.8 (Major overhaul!)

- Preparations for Swift 3 (name changes)
- Added functions: stringOrNull, integerOrNull, doubleOrNull, boolOrNull and numberOrNull.
- Fixed problem where appendChild would not convert a non-array into an array.
- Added "&=" operators
- Changed VJsonSerializable and created additional protocols VJsonDeserializable and VJsonConvertible
- Added a load of new initializers and factories
- Added a conditional conversion of ARRAY into OBJECT
- Removed createXXXX functions where these duplicated the new initializers.
- Fixed crash when changing from an ARRAY to OBJECT and vice-versa
- Created better distiction between ARRAY and OBJECT access, it is no longer possible to insert in or append to objects just as it is no longer possible to add to arrays. There is no longer an automatic conversion of JSON items for child access/management. Instead, two new operations have been added to change object's into array's and vice versa. Note that value assignment and array accessors still auto-convert JSON item types.
- Added static option fatalErrorOnTypeConversion (for use during debugging)
- Improved iterator: will no longer generates items that are deleted while in the itteration loop
- Changed operation 'object' to 'item'

#### 0.9.7

- Added protocol definition VJsonSerializable
- Added createJsonHierarchy(string)

#### 0.9.6

- Header update to include new website: [swiftfire.nl](http://swiftfire.nl)

#### 0.9.5

- Added "pipe" functions ("|") to allow for better testing of paths. The pipe functions greatly improve the readability when used in 'guard' statements.

#### 0.9.4

- Changed target to a (shared) framework
- Added 'public' definitions to support the framework target
- Added release tags

#### 0.9.3

- Changed "removeChild:atIndex" to "removeChildAtIndex:withChild"
- Added conveniance operation "addChild" that does not need the name of the child to be added.
- Changed behaviour of "addChild:name" to change the item into an OBJECT if it is'nt one.
- Changed behaviour of "appendChild" to change the item into an ARRAY if it is'nt one.
- Upgraded to Swift 2.2
- Removed dependency on SwifterLog
- Updated for changes in ASCII.swift (added hexLookUp, changed is___ functions to var's)

#### 0.9.2

- Fixed a problem where a named NULL object was removed from the hierarchy upon fetching the description.

#### 0.9.1

- Changed parameter to 'addChild' to an optional.
- Fixed a problem where an object without a leading brace in an array would not be thrown as an error
- Changed 'makeCopy()' to 'copy' for constency with other projects
- Fixed the asString for BOOL types
- Changed all "...Value" returns to optionals (makes more sense as this allows the use of guard let statements to check the JSON structure.
- Overhauled the child support interfaces (changes parameters and return values to optionals)
- Removed 'set' access from arrayValue and dictionaryValue as it could potentially lead to an invalid JSON hierarchy
- Fixed subscript accessors, array can now be used on top-level with an implicit name of "array"
- Fixed missing braces around named objects in an array

Also added unit tests for VJson and performance tests for Apple's JSON and VJson.

#### 0.9.0

- Initial release
