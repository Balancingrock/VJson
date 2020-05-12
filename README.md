# VJson

A framework in Swift to read, write & parse the JSON Format.

VJson is part of the Swiftfire webserver project.

The [Swiftfire website](http://swiftfire.nl)

The [reference manual](http://swiftfire.nl/projects/vjson/reference/index.html)

VJson is also used as the core of our proJSON application in the [App Store](https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1444778157)

# Features

- Creates a fully featured JSON hierarchy from file (Data, Buffer or String).
- Intuitive subscript accessors (for creation).
- Intuitive pipe accessors (for interrogation).
- Interpret items as other types (eg read a Bool as a String or vice-versa).
- Full escape sequence support (including unicode) for names and values
- Allows multiple values with identical names in an OBJECT.
- Allows ARRAYs with different JSON types.
- Allows fragmented JSON code, including named top level items like '"name":true'
- Overloaded assignment operators for readable code.
- Auto creation of null values for optional items that are nil.
- Type conflicts can be configured to create fatal errors (is default).
- Builds with Swift 5
- Includes extensive unit tests
- Use either integrated parser or Apple's NSJSONSerialization parser
- Builds with SPM (Swift Package Manager)
- Builds with Xcode as modular framework
- Merge function is NSOutlineView compatible
- Limited KVO support to provide easier integration with -for example- an NSOutlineView
- Notifications are isued for KVO updates.
- Undo/redo support for macOS
- customData member allows for association of external data with a VJson object
- Caching of named members for higher performance (usable in most cases)
- Includes flattening & unflattening

# Installation

VJson can be used by the Swift Package Manager. Just add it to your package manifest as a dependency.

Alternatively you can clone the project and generate a Xcode framework in the following way:

1. Clone the repository and create a Xcode project:

~~~~
$ git clone https://github.com/Balancingrock/VJson
$ cd VJson
$ swift package generate-xcodeproj
~~~~

1. Double click that project to open it. Once open set the `Defines Module` to 'yes' in the `Build Settings -> Packaging` before creating the framework. (Otherwise the import of the framework in another project won't work)

1. In the project that will use VJson, add the VJson.framework by opening the `General` settings of the target and add the VJson.framework to the `Embedded Binaries`.

1. In the Swift source code where you want to use it, import VJson at the top of the file.

# Examples

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
	json["description"] &= "Book price list"
	json["books"][0]["title"] &= "Book Title"
	json["books"][0]["price"] &= 12.34
	json["books"][1]["title"] &= "Second Book Title"

	
Preferred way of inspecting/retrieving from an hierarchy:

	guard let title = (json|"books"|0|"title")?.stringValue else {...}
	guard let price = (json|"books"|0|"price")?.doubleValue else {...}
	
It is possible to use `guard let title = json["books"][0]["title"].stringValue else {...}` but this can have side effects that can be avoided by using the pipe operator. See 'notes' section below.

Adding a (named) item to an object:

	let o = VJson.object()
	o.add(VJson(8), name: "AnyName")		// {"AnyName":8}
	
is equivalent to:

	let o = VJson.object()
	o.add(VJson(8, name: "AnyName"))		// {"AnyName":8}

Adding an item to an array:

	let a = VJson.array()
	a.append(VJson(8))				// [8]

Create an item in the hierarchy:

	let json = VJson()				// {}
	var i: Int?
	json["first"].intValue = i		  	// {"first":null}

or

	let json = VJson()				// {}
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

The above examples all used 'let' variables. If 'var's are used there is another option available to retrieve values from a VJson object

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

Every object in a VJson hierarchy is a VJson object. This is very convenient, but also poses somewhat of a challenge: The JSON specification treats values differently depending on whether they are contained in an ARRAY or OBJECT. In an OBJECT the values have names. In an ARRAY values are simply values without a name. However since VJson provides only one type of object for everything, this object must have a name component. The optionality of this name thus depends on where the VJson object is used.
What if a VJson VALUE with a specified name is inserted into an array? Well, the name will be ignored. This leads (possibly) to information loss, but the alternative would be to create an extra object in the hierarchy. If this is the preferred behaviour, it is up to the application to create that object explicitly.
In an example:

	let json = VJson()
	json["top"].append(VJson(12))				// results in: {"top":[12]}
	
	let json = VJson()
	json["top"].append(VJson(12, name: "one"))	// results in: {"top":[12]}

## JSON item type changes

Allowing the use of subscript accessors without optionality necessitates a leniet behaviour towards JSON item type conversions. To prevent that the application code inadvertently changes the type of a JSON item a fatal error will be thrown if that happens.

Type changes to or from the JSON NULL type are always considered legal.

All other type changes -for example- a BOOL to an ARRAY or from STRING to a NUMBER will result in a fatal error when the static option `fatalErrorOnTypeConversion` is set to 'true' (which is the default). Such type changes can only be made by transistioning explicitly through a JSON NULL type.

To allow leniency for type changes not involving NULL, set `fatalErrorOnTypeConversion` to 'false'.

Do note however that the operations "add" and "append" are not lenient. I.e. it is not possible to "add" to an ARRAY or "append" to an OBJECT as that could result in data loss. However there are operations to change an ARRAY into an OBJECT and vice versa.

## Differences between standard parser or Apple's NSJSONSerialization parser

The advantage of Apple's parser is that it is faster, about twice as fast as the standard parser on the MacBook Pro and PowerMac. However Apple's parser has at least two drawbacks:

- Apple's parser cannot handle multiple name/value pairs with identical names. I.e. {"test":1,"test":2} will fail. With the provided VJson parser this will result in an object with two childeren with identical names. Accessable through the "arrayValue" accessor.

- Apple's parser handles JSON BOOL items as NSNumber's and hence must be interrogated as a JSON NUMBER item. This results in a symmetry break when json code with a bool in it is converted into a VJson hierarchy and that hierachy is then translated back into code. (The in- and output code will not be the same)

# Version history:

No new features planned. Updates are made on an ad-hoc basis as needed to support Swiftfire development.

#### 1.2.0

- Upgraded BRUtils due to swift 5.2

#### 1.1.0

- Added flattening and unflattening

#### 1.0.0

- Finalized for use with Swiftfire 1.0.0
