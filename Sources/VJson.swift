// =====================================================================================================================
//
//  File:       VJson.swift
//  Project:    SwifterJSON
//
//  Version:    0.10.3
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Balancingrock/SwifterJSON
//
//  Copyright:  (c) 2014-2017 Marinus van der Lugt, All rights reserved.
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
//  I strongly believe that the Non Agression Principle is the way for societies to function optimally. I thus reject
//  the implicit use of force to extract payment. Since I cannot negotiate with you about the price of this code, I
//  have choosen to leave it up to you to determine its price. You pay me whatever you think this code is worth to you.
//
//   - You can send payment via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  I prefer the above two, but if these options don't suit you, you might also send me a gift from my amazon.co.uk
//  wishlist: http://www.amazon.co.uk/gp/registry/wishlist/34GNMPZKAQ0OO/ref=cm_sw_em_r_wsl_cE3Tub013CKN6_wb
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  (It is always a good idea to visit the website/blog/google to ensure that you actually pay me and not some imposter)
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
//  As a general rule: use the pipe operators to read from a JSON hierarchy and use the subscript accessors to create
//  the JSON hierarchy. For more information, see the readme file.
//
// =====================================================================================================================
//
// History
//
// 0.10.4  - Added CustomStringConvertible to JType.
//         - Added setter to "asString".
// 0.10.3  - Bugfix: Made 'parent' weak resp unowned to prevent retain cycles (and leaks)
// 0.10.2  - Removed superfluous discardableresult definitions
//         - Fixed sequence of type conversion in key/value coding
// 0.10.0  - Bugfix: Assigning nil to ...Value did not result in an auto conversion to NULL.
//         - Changed several fileprivate accessors to public fileprivate(set) to allow support for outline views.
//         - Added merge capability
//         - Bugfix: Duplicate named items would not result in mutiple items of an object.
//         - Added 'caching' of object members in an internal dictionary, by default 'on', set "enableCacheForObjects" to 'false' to disable.
//         - Added parent references.
//         - Reorganized code
//         - A couple of harmonization changes.
//         - Removed optionality from some return values
//         - Removed most of the force-unwrap operations (!)
//         - prepared support for linux os
//         - added key/value coding support
// 0.9.16  - Updated for dependency on Ascii, removed Ascii from SwifterJSON project.
// 0.9.15  - Bigfix: Removed the redefinition of the operators
// 0.9.14  - Organizational and documentary changes for SPM and jazzy.
// 0.9.13  - Added missing 'public' to conveniance initializers
//         - Added '&=' assignments of Vjson to for var's
// 0.9.12  - Added "findPossibleJsonCode'.
//         - Fixed bug that failed to skip whitespace characters after a comma.
// 0.9.11  - Updated to Xcode 8 beta 6
//         - Added convenience func to VJsonSerializable to name nameless VJson objects.
//         - Added &= operator for adding/appending VJson objects
//         - Added "code" to replace "description" ("description" remains available)
// 0.9.10  - Updated and harmonized for Swift 3 beta
//         - added int flavor accessors
// 0.9.9   - Added "parseUsingAppleParser"
// 0.9.8   - Preparations for Swift 3 (name changes)
//         - Added functions: stringOrNull, integerOrNull, doubleOrNull, boolOrNull and numberOrNull.
//         - Fixed problem where appendChild would not convert a non-array into an array.
//         - Added "&=" operators
//         - Changed VJsonSerializable and created additional protocols VJsonDeserializable and VJsonConvertible
//         - Added a load of new initializers and factories
//         - Added a conditional conversion of ARRAY into OBJECT
//         - Removed createXXXX functions where these duplicated the new initializers.
//         - Fixed crash when changing from an ARRAY to OBJECT and vice-versa
//         - Created better distiction between ARRAY and OBJECT access, it is no longer possible to insert in or append to objects just as it is no longer possible to add to arrays. There is no longer an automatic conversion of JSON items for child access/management. Instead, two new operations have been added to change object's into array's and vice versa. Note that value assignment en array accessors still auto-convert JSON item types.
//         - Added static option fatalErrorOnTypeConversion (for use during debugging)
//         - Improved iterator: will no longer generates items that are deleted while in the itteration loop
//         - Changed operations "object" to "item"
// 0.9.7   - Added protocol definition VJsonSerializable
//         - Added createJsonHierarchy(string)
// 0.9.6   - Header update
// 0.9.5   - Added "pipe" functions to allow for guard constructs when testing for item existence without side effect
// 0.9.4   - Changed target to a shared framework
//         - Added 'public' declarations to support use as framework
// 0.9.3   - Changed "removeChild:atIndex" to "removeChildAtIndex:withChild"
//         - Added conveniance operation "addChild" that does not need the name of the child to be added.
//         - Changed behaviour of "addChild:name" to change the item into an OBJECT if it is'nt one.
//         - Changed behaviour of "appendChild" to change the item into an ARRAY if it is'nt one.
//         - Upgraded to Swift 2.2
//         - Removed dependency on SwifterLog
//         - Updated for changes in ASCII.swift
// 0.9.2   - Fixed a problem where an assigned NULL object was removed from the hierarchy
// 0.9.1   - Changed parameter to 'addChild' to an optional.
//         - Fixed a problem where an object without a leading brace in an array would not be thrown as an error
//         - Changed 'makeCopy()' to 'copy' for constency with other projects
//         - Fixed the asString for BOOL types
//         - Changed all "...Value" returns to optionals (makes more sense as this allows the use of guard let statements to check the JSON structure.
//         - Overhauled the child support interfaces (changes parameters and return values to optionals)
//         - Removed 'set' access from arrayValue and dictionaryValue as it could potentially lead to an invalid JSON hierarchy
//         - Fixed subscript accessors, array can now be used on top-level with an implicit name of "array"
//         - Fixed missing braces around named objects in an array
// 0.9.0   - Initial release
// =====================================================================================================================

import Foundation
import Ascii
import BRUtils


/// For classes and structs that can be converted into a VJson object

public protocol VJsonSerializable {
    
    
    /// Returns the VJson hierachy representing this object.
    
    var json: VJson { get }
}

/// Default implementations

public extension VJsonSerializable {
    
    
    /// Creates or changes the name for the VJson hierarchy representing this object.
    ///
    /// Usefull if an implementation creates an unnamed VJson object when a named version is needed.
    ///
    /// - Parameter name: The name for the VJson object
    ///
    /// - Returns: The named VJson object
    
    func json(name: String) -> VJson {
        let j = self.json
        j.nameValue = name
        return j
    }
}

/// For classes and structs that can be constructed from a VJson object

public protocol VJsonDeserializable {
    
    
    /// Creates a new object from the VJson hierarchy if possible.
    
    init?(json: VJson?)
}


/// For classes and structs that can be converted into and constructed from a VJson object

public protocol VJsonConvertible: VJsonSerializable, VJsonDeserializable {}


// MARK: - Test for existence of child items

/// Interrogate a JSON object for the existence of a child item with the given name. Has no side effects
///
/// - Parameters:
///   - lhs: The VJson object to interrogate
///   - rhs: The name of the sought after item
///
/// - Returns: Either the sought after item or nil if it does not exist.

public func | (lhs: VJson?, rhs: String?) -> VJson? {
    guard let lhs = lhs else { return nil }
    guard let rhs = rhs else { return nil }
    if let result = lhs.children?.cached(rhs) {
        return result
    } else {
        let arr = lhs.children(with: rhs)
        if arr.count == 0 { return nil }
        return arr[0]
    }
}


/// Interrogate a JSON object for the existence of a child item at the given index. Has no side effects
///
/// - Parameters:
///   - lhs: The VJson object to interrogate
///   - rhs: The index of the sought after item
///
/// - Returns: Either the sought after item or nil if it does not exist.

public func | (lhs: VJson?, rhs: Int?) -> VJson? {
    guard let lhs = lhs else { return nil }
    guard let rhs = rhs else { return nil }
    guard lhs.type == .array else { return nil }
    guard rhs < lhs.nofChildren else { return nil }
    return lhs.children?[rhs]
}


// MARK: - Convenience assignment operators

/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: Int?) {
    guard let lhs = lhs else { return }
    lhs.intValue = rhs
}

/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout Int?, rhs: VJson?) {
    lhs = rhs?.intValue
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: UInt?) {
    guard let lhs = lhs else { return }
    lhs.uintValue = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout UInt?, rhs: VJson?) {
    lhs = rhs?.uintValue
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: Int8?) {
    guard let lhs = lhs else { return }
    lhs.int8Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout Int8?, rhs: VJson?) {
    lhs = rhs?.int8Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: UInt8?) {
    guard let lhs = lhs else { return }
    lhs.uint8Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout UInt8?, rhs: VJson?) {
    lhs = rhs?.uint8Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: Int16?) {
    guard let lhs = lhs else { return }
    lhs.int16Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout Int16?, rhs: VJson?) {
    lhs = rhs?.int16Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: UInt16?) {
    guard let lhs = lhs else { return }
    lhs.uint16Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout UInt16?, rhs: VJson?) {
    lhs = rhs?.uint16Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: Int32?) {
    guard let lhs = lhs else { return }
    lhs.int32Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout Int32?, rhs: VJson?) {
    lhs = rhs?.int32Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: UInt32?) {
    guard let lhs = lhs else { return }
    lhs.uint32Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout UInt32?, rhs: VJson?) {
    lhs = rhs?.uint32Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: Int64?) {
    guard let lhs = lhs else { return }
    lhs.int64Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout Int64?, rhs: VJson?) {
    lhs = rhs?.int64Value
}


/// Assign a given integer value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the integer value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: UInt64?)  {
    guard let lhs = lhs else { return }
    lhs.uint64Value = rhs
}


/// Assign the integer value of the JSON item to the integer if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The integer to assign to.
///   - rhs: The JSON item to extract the integer from.

public func &= (lhs: inout UInt64?, rhs: VJson?) {
    lhs = rhs?.uint64Value
}


/// Assign a given float value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the float value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

public func &= (lhs: VJson?, rhs: Float?) {
    guard let lhs = lhs else { return }
    lhs.doubleValue = rhs == nil ? nil : Double(rhs!) // Force unwrap tested before use
}


/// Assign the float value of the JSON item to the float if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The float to assign to.
///   - rhs: The JSON item to extract the float from.

public func &= (lhs: inout Float?, rhs: VJson?) {
    guard let rhs = rhs else { lhs = nil; return }
    guard let d = rhs.doubleValue else { lhs = nil; return }
    lhs = Float(d)
}


/// Assign a given double value to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the double value is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

@discardableResult
public func &= (lhs: VJson?, rhs: Double?) -> VJson? {
    guard let lhs = lhs else { return nil }
    lhs.doubleValue = rhs
    return lhs
}


/// Assign the double value of the JSON item to the double if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The double to assign to.
///   - rhs: The JSON item to extract the double from.

public func &= (lhs: inout Double?, rhs: VJson?) {
    lhs = rhs?.doubleValue
}


/// Assign a given NSNumber to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a NUMBER if necessary and possible. If the NSNumber is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

@discardableResult
public func &= (lhs: VJson?, rhs: NSNumber?) -> VJson? {
    guard let lhs = lhs else { return nil }
    lhs.numberValue = rhs?.copy() as? NSNumber
    return lhs
}


/// Assign the NSNumber value of the JSON item to the NSNumber if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The NSNumber to assign to.
///   - rhs: The JSON item to extract the NSNumber from.

public func &= (lhs: inout NSNumber?, rhs: VJson?) {
    lhs = rhs?.numberValue
}


/// Assign a given bool to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a BOOL if necessary and possible. If the bool is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

@discardableResult
public func &= (lhs: VJson?, rhs: Bool?) -> VJson? {
    guard let lhs = lhs else { return nil }
    lhs.boolValue = rhs
    return lhs
}


/// Assign the bool value of the JSON item to the bool if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The bool to assign to.
///   - rhs: The JSON item to extract the bool from.

public func &= (lhs: inout Bool?, rhs: VJson?) {
    lhs = rhs?.boolValue
}


/// Assign a given string to a JSON item if possible. Fails silently if not possible.
///
/// Changes the JSON item into a STRING if necessary and possible. If the string is nil, the JSON item becomes a NULL.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The value to be assigned.

@discardableResult
public func &= (lhs: VJson?, rhs: String?) -> VJson? {
    guard let lhs = lhs else { return nil }
    lhs.stringValue = rhs
    return lhs
}


/// Assign the string value of the JSON item to the string if possible. Fails silently if not possible.
///
/// - Parameters:
///   - lhs: The string to assign to.
///   - rhs: The JSON item to extract the string from.

public func &= (lhs: inout String?, rhs: VJson?) {
    lhs = rhs?.stringValue
}


/// Assigns the right hand side VJson object to the left hand side. This operation makes a "best effort" to fullfill the "intention" of the developper. Be aware that this might turn out differently than expected!
///
/// The following rules will be applied in the given order:
///
/// if rhs is nil then nothing will be done, lhs is returned unchanged.
///
/// if rhs has a parent then nothing will be done, lhs is returned unchanged.
///
/// if lhs is nil then nothing will be done, nil is returned.
///
/// if lhs is an ARRAY, then the rhs will be added to the array.
///
/// if lhs is an OBJECT, then the rhs will be added to the children if the rhs has a name.
///
/// if lhs has a parent, then replace lhs with rhs in that parent but preserve the name of lhs.
///
/// if lhs has no parent, then make the content of lhs equal to rhs but preserve the name of lhs
///
/// - Note: This is a potentially dangerous operation since it can fail silently or even do something different than expected. Be sure to add (unit) test cases to find any errors that might occur.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The JSON item to assign.
///
/// - Returns: The JSON item that was assigned to.

@discardableResult
public func &= (lhs: VJson?, rhs: VJson?) -> VJson? {
    
    
    // if rhs is nil then nothing will be done, lhs is returned unchanged.
    
    guard let rhs = rhs else { return lhs }
    
    
    // if rhs has a parent then nothing will be done, lhs is returned unchanged.
    
    guard rhs.parent == nil else { return lhs }

    
    // if lhs is nil then nothing will be done, nil is returned.
    
    guard let llhs = lhs else { return nil }
    
    
    // if lhs is an ARRAY, then the rhs will be added to the array.
    
    if llhs.type == .array { llhs.append(rhs); return llhs }
    
    
    // if lhs is an OBJECT, then the rhs will be added to the children.
    
    if llhs.type == .object { llhs.add(rhs); return llhs }
    
    
    // Assign rhs to lhs and again preserve the parent and name of lhs.
    
    let name = llhs.name
    if llhs.parent != nil {
        // This is a child object, replace it in the parent
        llhs.replaceSelfInParent(with: rhs)
        if let name = name { rhs.name = name }
        return rhs
    } else {
        // This is a top level object, change the lhs object into the rhs
        llhs.replaceContent(with: rhs)
        if let name = name { rhs.name = name }
        return llhs
    }
}


/// Assigns the right hand side VJson object to the left hand side. This operation makes a "best effort" to fullfill the "intention" of the developper. Be aware that this might turn out differently than expected!
///
/// The following rules will be applied in the given order:
///
/// if rhs is nil then nothing will be done, lhs is returned unchanged.
///
/// if lhs is nil then it is replaced by rhs, the new lhs is returned.
///
/// if either rhs or lhs has a parent then the content of lhs will be updated to reflect rhs but the name of lhs (if any) will be preserved, the new lhs is returned.
///
/// if lhs is an ARRAY, then rhs will be added to the array, returns updated lhs.
///
/// if lhs is an OBJECT, then rhs will be added to the children if the rhs has a name, returns updated lhs.
///
/// All other cases replace lhs with rhs, return new lhs.
///
/// - Note: This is a potentially dangerous operation since it can fail silently or even do something different than expected. Be sure to add (unit) test cases to find any errors that might occur.
///
/// - Parameters:
///   - lhs: The JSON item to assign to.
///   - rhs: The JSON item to assign.
///
/// - Returns: The JSON item that was assigned to.

@discardableResult
public func &= (lhs: inout VJson?, rhs: VJson?) -> VJson? {
    
    
    // if rhs is nil then nothing will be done, lhs is returned unchanged.
    
    guard let rhs = rhs else { return lhs }
    
    
    // if lhs is nil, then it will be replaced by rhs.
    
    guard let llhs = lhs else { lhs = rhs; return lhs }
    
    
    // if either lhs or rhs has a parent then update the content of lhs.
    
    if (rhs.parent != nil) || (llhs.parent != nil) {
        let name = llhs.name
        llhs.replaceContent(with: rhs)
        if let name = name { llhs.name = name }
        return llhs
    }
    
    
    // if lhs is an ARRAY, then the rhs will be added to the array.
    
    if llhs.type == .array { llhs.append(rhs); return llhs }
    
    
    // if lhs is an OBJECT, then the rhs will be added to the children.
    
    if llhs.type == .object { llhs.add(rhs); return llhs }
    
    
    // If lhs is a NULL, then lhs will be replaced by rhs, but the name of lhs -if present- will be preserved as will the parent of lhs. Note that lhs will be replaced in the parent as well!.
    
    VJson.fatalIfTypeChangeNotAllowed(from: llhs.type, to: rhs.type)
    
    lhs = rhs
    
    return lhs
}


/// Implements the JSON specification as found on: http://json.org (2015.01.01)

#if os(Linux)
    
    public final class VJson: Equatable, CustomStringConvertible {
        
        
        /// Set this option to 'true' to help find unwanted type conversions (in the debugging phase?).
        ///
        /// A type conversion occures if -for example- a string is assigned to a JSON item that contains a BOOL. If this flag is set to 'true', such a conversion will result in a fatal error. If this flag is set to 'false', the conversion will happen silently.
        ///
        /// Conversion to and from NULL are always possible, if it is necessary to force a type change irrespective of the value of this flag make two changes, first to NULL then to the desired type.
        
        public static var fatalErrorOnTypeConversion = true
        
        
        /// The JSON type of this object.
        
        public fileprivate(set) var type: JType
        
        
        /// The name of this object if it is part of a name/value pair.
        
        public fileprivate(set) var name: String?
        
        
        /// The value if this is a JSON BOOL.
        
        public fileprivate(set) var bool: Bool?
        
        
        /// The value if this is a JSON NUMBER.
        
        public fileprivate(set) var number: NSNumber?
        
        
        /// The value if this is a JSON STRING.
        
        public fileprivate(set) var string: String?
        
        
        /// The container for all children if self is .array or .object.
        
        public fileprivate(set) var children: Children?
        
        
        /// The parent of a child
        ///
        /// A VJson object cannot have more than one parent. For that reason the parent is stricktly managed: when adding an object, the parent of that object must be nil. When removing an object, the parent of that object will be set to nil.
        
        public fileprivate(set) weak var parent: VJson?
        
        
        /// If this object was created to fullfill a subscript access, this property is set to 'true'. It is false for all other objects.
        
        fileprivate var createdBySubscript: Bool = false
        
        
        /// Default initializer
        
        fileprivate init(type: JType, name: String? = nil) {
            
            self.type = type
            self.name = name
            
            switch type {
            case .object, .array: children = Children(parent: self)
            default: break
            }
        }
        
        
        /// Creates an empty VJson hierarchy
        
        public convenience init() {
            self.init(type: .object)
        }
        
        
        /// Copying
        
        public func copy() -> Any { return duplicate }
        
        
        /// The custom string convertible protocol.
        
        public var description: String { return code }
    }

#else

    public final class VJson: NSObject {
        
        
        /// This notification is posted when the value of an item was updated due to a key/value update cycle.
        
        public static let KVO_VALUE_UPDATE = Notification.Name(rawValue: "KVO_ValueUpdateNotification")

        
        /// Set this option to 'true' to help find unwanted type conversions (in the debugging phase?).
        ///
        /// A type conversion occures if -for example- a string is assigned to a JSON item that contains a BOOL. If this flag is set to 'true', such a conversion will result in a fatal error. If this flag is set to 'false', the conversion will happen silently.
        ///
        /// Conversion to and from NULL are always possible, if it is necessary to force a type change irrespective of the value of this flag make two changes, first to NULL then to the desired type.
        
        public static var fatalErrorOnTypeConversion = true
        
        
        /// The JSON type of this object.
        
        public fileprivate(set) var type: JType
        
        
        /// The name of this object if it is part of a name/value pair.
        
        public fileprivate(set) var name: String?
        
        
        /// The value if this is a JSON BOOL.
        
        public fileprivate(set) var bool: Bool?
        
        
        /// The value if this is a JSON NUMBER.
        
        public fileprivate(set) var number: NSNumber?
        
        
        /// The value if this is a JSON STRING.
        
        public fileprivate(set) var string: String?
        
        
        /// The container for all children if self is .array or .object.
        
        public fileprivate(set) var children: Children?
        
        
        /// The parent of a child
        ///
        /// A VJson object cannot have more than one parent. For that reason the parent is stricktly managed: when adding an object, the parent of that object must be nil. When removing an object, the parent of that object will be set to nil.
        
        public fileprivate(set) weak var parent: VJson?
        
        
        /// If this object was created to fullfill a subscript access, this property is set to 'true'. It is false for all other objects.
        
        fileprivate var createdBySubscript: Bool = false
        
        
        /// Default initializer
        
        fileprivate init(type: JType, name: String? = nil) {
            
            self.type = type
            self.name = name
            
            super.init()
            
            switch type {
            case .object, .array: children = Children(parent: self)
            default: break
            }
        }
        
        
        /// Creates an empty VJson hierarchy
        
        public convenience override init() {
            self.init(type: .object)
        }
        
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let object = object as? VJson else { return false }
            return self == object
        }
        
        public override func copy() -> Any { return duplicate }
        
        
        /// The custom string convertible protocol.
        
        override public var description: String { return code }
    }
    
    
    // MARK: - Key/Value coding support
    
    extension VJson {
        
        
        /// Create a bool from a string.
        ///
        /// - Parameter str: The string to be converted.
        ///
        /// - Returns: Either 'true', 'false' or nil if the string could not be converted.
        
        private func stringToBool(_ str: String) -> Bool? {
            if str == "0" { return false }
            else if str == "1" { return true }
            else if str.compare("true", options: [.diacriticInsensitive, .caseInsensitive], range: nil, locale: nil) == ComparisonResult.orderedSame { return true }
            else if str.compare("false", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
            else if str.compare("yes", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return true }
            else if str.compare("no", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
            else if str.compare("t", options: [.diacriticInsensitive, .caseInsensitive], range: nil, locale: nil) == ComparisonResult.orderedSame { return true }
            else if str.compare("f", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
            else if str.compare("y", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return true }
            else if str.compare("n", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
            else { return nil }
        }

        
        /// Converts Any? into a Bool.
        ///
        /// - Parameter any: The value to convert.
        ///
        /// - Returns: Either 'true', 'false' or nil if any could not be converted.
        
        private func boolFromAny(_ any: Any?) -> Bool? {
            if let b = any as? Bool { return b }
            if let n = any as? NSNumber { return n.boolValue }
            if let s = any as? String { return stringToBool(s) }
            if let i = any as? Int { return i == 1 }
            return nil
        }
        
        /// Converts Any? into a NSNumber.
        ///
        /// - Parameter any: The value to convert.
        ///
        /// - Returns: Either 'true', 'false' or nil if any could not be converted.
        
        private func numberFromAny(_ any: Any?) -> NSNumber? {
            if let n = any as? NSNumber { return n }
            if let b = any as? Bool { return NSNumber(value: b) }
            if let i = any as? Int { return NSNumber(value: i) }
            if let s = any as? String { return NSNumber(value: Double(s) ?? 0) }
            return nil
        }
        
        /// Converts Any? into a String.
        ///
        /// - Parameter any: The value to convert.
        ///
        /// - Returns: Either 'true', 'false' or nil if any could not be converted.
        
        private func stringFromAny(_ any: Any?) -> String? {
            if let s = any as? String { return s }
            if let n = any as? NSNumber { return n.description }
            if let b = any as? Bool { return b ? "true" : "false" }
            if let i = any as? Int { return i.description }
            return nil
        }

        
        /// Override the KVO 'setValue' to update the members.
        ///
        /// If an update is made, the KVO_VALUE_UPDATE notification is sent for the VJson item that was updated.
        
        public override func setValue(_ value: Any?, forKey key: String) {

            if let item = self|key {
            
                switch item.type {
                
                // While a NULL may be changed into other types, this probably won't ever happen.
                case .null:
                    if let b = boolFromAny(value) {
                        item.boolValue = b
                        NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                        return
                        
                    } else if let n = numberFromAny(value) {
                        item.numberValue = n
                        NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                        return
                        
                    } else if let s = stringFromAny(value) {
                        item.stringValue = s
                        NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                        return
                    }
                
                // Update a bool
                case .bool:
                    if let b = boolFromAny(value) {
                        item.boolValue = b
                        NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                        return
                    }
                    
                // Update a number
                case .number:
                    if let n = numberFromAny(value) {
                        item.numberValue = n
                        NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                        return
                    }
                    
                // Update a string
                case .string:
                    if let s = stringFromAny(value) {
                        item.stringValue = s
                        NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                        return
                    }
                    
                // Not supported (yet?)
                case .array, .object: break
                }
            }
            super.setValue(value, forKey: key)
        }
        
        /*public override func setValue(_ value: Any?, forKeyPath keyPath: String) {
         
        }*/
        
        
        /// Retrieves the value from a child item.
        
        public override func value(forKey key: String) -> Any? {
        
            if let item = self|key {
                switch item.type {
                case .null: return nil
                case .bool: return item.boolValue
                case .number: return item.numberValue
                case .string: return item.stringValue
                case .array, .object: break
                }
            }
            return super.value(forKey: key)
        }
        
        /*public override func value(forKeyPath keyPath: String) -> Any? {
            
        }*/
    }

#endif


// MARK: - The Equatable protocol

extension VJson {


    /// Implementation note: does not check the parent and the createdBySubscript members.
    
    public static func == (lhs: VJson, rhs: VJson) -> Bool {
        if lhs === rhs { return true }
        if lhs.type != rhs.type { return false }
        if lhs.bool != rhs.bool { return false }
        if lhs.number != rhs.number { return false }
        if lhs.string != rhs.string { return false }
        if lhs.name != rhs.name { return false }
        guard let lchildren = lhs.children else { return rhs.children == nil }
        guard let rchildren = rhs.children else { return false }
        if lchildren.count != rchildren.count { return false }
        for i in 0 ..< lchildren.count {
            let lhc = lchildren[i]
            let rhc = rchildren[i]
            if lhc != rhc { return false }
        }
        return true
    }
}


// MARK: - Type

extension VJson {
    
    
    /// The JSON types.
    
    public enum JType: CustomStringConvertible {
        
        
        /// A JSON NULL
        
        case null
        
        
        /// A JSON BOOL
        
        case bool
        
        
        /// A JSON NUMBER
        
        case number
        
        
        /// A JSON STRING
        
        case string
        
        
        /// A JSON OBJECT
        
        case object
        
        
        /// A JSON ARRAY
        
        case array
        
        
        /// Return the string for the case
        ///
        /// Note: This approach has a slight performance edge over 'enum JType: String'
        
        public var description: String {
            switch self {
            case .null: return "Null"
            case .bool: return "Bool"
            case .number: return "Number"
            case .string: return "String"
            case .object: return "Object"
            case .array: return "Array"
            }
        }
    }

    
    /// True if this object contains a JSON NULL object.
    
    public var isNull: Bool { return self.type == JType.null }
    
    
    /// True if this object contains a JSON BOOL object.
    ///
    /// - Note: If the Apple Parser was used, all JSON bools will have been converted into a NUMBER.
    
    public var isBool: Bool { return self.type == JType.bool }
    
    
    /// True if this object contains a JSON NUMBER object.
    ///
    /// - Note: If the Apple Parser was used, all JSON bools will have been converted into a NUMBER.
    
    public var isNumber: Bool { return self.type == JType.number }
    
    
    /// True if this object contains a JSON STRING object.
    
    public var isString: Bool { return self.type == JType.string }
    
    
    /// True if this object contains a JSON ARRAY object.
    
    public var isArray: Bool { return self.type == JType.array }
    
    
    /// True if this object contains a JSON OBJECT object.
    
    public var isObject: Bool { return self.type == JType.object }

    
    /// Checks if a type change is allowed.
    ///
    /// - Parameters:
    ///   - from: The type to change from.
    ///   - to: The type to change to
    ///
    /// - Returns: True when the type change is allowed false otherwise.

    public static func typeChangeIsAllowed(from old: JType, to new: JType) -> Bool {
        if !VJson.fatalErrorOnTypeConversion { return true }
        if old == .null { return true }
        if new == .null { return true }
        if old == new { return true }
        return false
    }
    
    
    /// Raises a fatal error is a type change is not allowed.
    ///
    /// - Parameters:
    ///   - from: The type to change from.
    ///   - to: The type to change to
    ///
    /// - Returns: When the type change is allowed it will return, otherwise a fatal error will be raised.
    
    public static func fatalIfTypeChangeNotAllowed(from old: JType, to new: JType) {
        if typeChangeIsAllowed(from: old, to: new) { return }
        fatalError("Type change from \(old) to \(new) is not supported.")
    }
    
    
    /// Changes the type of self to the specified type. If a type change is performed, the internal variables may be affected. If the newType is the same as the current type, no changes will be made except for the "createdBySubscript" which will be set to false.
    ///
    /// Data members "bool", "number", "string" and "children" will be reset to 'nil'. "parent" and "name" will be unaffected.
    ///
    /// - Parameter to: The type to convert self to.
    
    fileprivate func changeTypeConditionally(to newType: JType) {
    
        createdBySubscript = false

        if self.type == newType { return }
        
        VJson.fatalIfTypeChangeNotAllowed(from: self.type, to: newType)
        
        bool = nil
        number = nil
        string = nil
        children = nil
        
        if newType == .object || newType == .array { children = Children(parent: self) }
        
        self.type = newType
    }
}


// MARK: - Name

extension VJson {
    
    
    /// Accessor for the name of this item if it is a name/value pair. Nil otherwise.
    
    public var nameValue: String? {
        get { return name }
        set { name = newValue }
    }
    
    
    /// True if this object is a name/value pair. False otherwise.
    
    public var hasName: Bool { return name != nil }
}


// MARK: - JSON NULL

extension VJson {
    
    
    /// True if this item contains a JSON NULL, nil otherwise. Note that conversions to and from NULL are always allowed.
    
    public var nullValue: Bool? {
        get { return type == .null ? true : nil }
        set { changeTypeConditionally(to: .null) }
    }
    
    
    /// True if this object contains a JSON NULL, false otherwise.
    
    public var asNull: Bool { return type == .null }
    
    
    /// Creates a VJson item containing a JSON NULL.
    ///
    /// - Parameter name: The name for this item (optional)
    ///
    /// - Returns: A new VJson NULL item.
    
    public static func null(_ name: String? = nil) -> VJson {
        return VJson(type: VJson.JType.null, name: name)
    }
}


// MARK: - JSON BOOL

extension VJson {
    
    
    /// Accessor for the bool value of this object if the type is a JSON BOOL value. Nil otherwise.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non BOOL will result in a fatal error.
    
    public var boolValue: Bool? {
        get { return bool }
        set {
            if newValue == nil {
                changeTypeConditionally(to: .null)
            } else {
                changeTypeConditionally(to: .bool)
                bool = newValue
            }
        }
    }
    
    
    /// The value of this object interpreted as a bool.
    ///
    /// A NULL reads as false, a NUMBER 1(.0) reads as true, other numbers read as false, STRING "true" reads as true, all other strings read as false. ARRAY and OBJECT both read as false.
    
    public var asBool: Bool {
        switch type {
        case .null: return false
        case .bool: return bool ?? false
        case .number: return number?.boolValue ?? false
        case .string: return string == "true"
        case .object: return false
        case .array: return false
        }
    }
    
    
    /// Creates a new VJson item with a JSON BOOL with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Bool?, name: String? = nil) {
        self.init(type: VJson.JType.bool, name: name)
        bool = value
    }
}


// MARK: - JSON NUMBER

extension VJson {
    
    
    /// The number as an NSNumber if this is a JSON NUMBER item, nil otherwise.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var numberValue: NSNumber? {
        get { return number?.copy() as? NSNumber }
        set {
            if newValue == nil {
                changeTypeConditionally(to: .null)
            } else {
                changeTypeConditionally(to: .number)
                number = newValue?.copy() as? NSNumber
            }
        }
    }
    
    
    /// The value of this item interpretated as a number.
    ///
    /// For a NUMBER it returns a copy of that number, for NULL, OBJECT and ARRAY it returns a NSNumber with the value 0, for STRING it tries to read the string as a number (if that fails, it is regarded as a zero) and for a BOOL it creates a NSNumber with the bool as its value.
    
    public var asNumber: NSNumber {
        switch type {
        case .null, .object, .array: return NSNumber(value: 0)
        case .bool:   return NSNumber(value: self.bool ?? false)
        case .number: return numberValue ?? NSNumber(value: 0)
        case .string: return NSNumber(value: Double(string ?? "0") ?? 0)
        }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var intValue: Int? {
        get { return number?.intValue }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int8Value: Int8? {
        get { return number?.int8Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int16Value: Int16? {
        get { return number?.int16Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int32Value: Int32? {
        get { return number?.int32Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int64Value: Int64? {
        get { return number?.int64Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uintValue: UInt? {
        get { return number?.uintValue }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint8Value: UInt8? {
        get { return number?.uint8Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint16Value: UInt16? {
        get { return number?.uint16Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint32Value: UInt32? {
        get { return number?.uint32Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint64Value: UInt64? {
        get { return number?.uint64Value }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// The integer value of this item interpretated as a number.
    ///
    /// For a NUMBER it returns the integer value of that number, for NULL, OBJECT and ARRAY it returns 0, for STRING it tries to read the string as a number (if that fails, it is regarded as a zero) and for a BOOL it is either 0 or 1.
    
    public var asInt: Int {
        return asNumber.intValue
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var doubleValue: Double? {
        get { return number?.doubleValue }
        set { numberValue = newValue == nil ? nil : NSNumber(value: newValue ?? 0) }
    }
    
    
    /// The double value of this item interpretated as a number.
    ///
    /// For a NUMBER it returns the double value of that number, for NULL, OBJECT and ARRAY it returns 0, for STRING it tries to read the string as a number (if that fails, it is regarded as a zero) and for a BOOL it is either 0 or 1.
    
    public var asDouble: Double {
        return asNumber.doubleValue
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int8?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt8?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int16?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt16?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int32?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt32?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int64?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt64?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        intValue = value == nil ? nil : Int(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Float?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        doubleValue = value == nil ? nil : Double(value ?? 0)
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Double?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        doubleValue = value
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(number: NSNumber?, name: String? = nil) {
        self.init(type: VJson.JType.number, name: name)
        numberValue = number
    }
}


// MARK: - JSON STRING

extension VJson {
    
    
    /// The string value if this is a JSON STRING item, nil otherwise.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non string will result in a fatal error.
    
    public var stringValue: String? {
        get {
            if string == nil { return nil }
            return self.string?.replacingOccurrences(of: "\\\"", with: "\"")
        }
        set {
            if newValue == nil {
                changeTypeConditionally(to: .null)
            } else {
                changeTypeConditionally(to: .string)
                string = newValue?.replacingOccurrences(of: "\"", with: "\\\"")
            }
        }
    }
    
    
    /// The value of this item interpretated as a string.
    ///
    /// NUMBER and BOOL return their string representation. NULL it returns "null" for OBJECT and ARRAY it returns an empty string.
    
    public var asString: String {
        get {
            switch type {
            case .null: return "null"
            case .bool: return bool == nil ? "null" : "\(bool ?? false)"
            case .string: return stringValue ?? "null"
            case .number: return number == nil ? "null" : (number ?? NSNumber(value: 0)).stringValue
            case .array, .object: return ""
            }
        }
        set {
            switch type {
            case .null, .array, .object: break
            case .bool: if let b = Bool(newValue) { boolValue = b }
            case .string: stringValue = newValue
            case .number: numberValue = NSNumber.factory(boolIntDouble: newValue)
            }
        }
    }
    
    
    /// Creates a new VJson item with a JSON STRING with the given value.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ string: String?, name: String? = nil) {
        self.init(type: VJson.JType.string, name: name)
        self.string = string
    }
}


// MARK: - JSON ARRAY and OBJECT

extension VJson {

    
    /// A wrapper for the child items, used only for ARRAYs and OBJECTs
    
    public class Children {
        
        
        // May only be created internally
        
        fileprivate init(parent: VJson) { self.parent = parent }
        
        
        // The parent of the children (which will always be the enclosing VJson item)
        
        private unowned let parent: VJson
        
        
        // A chache that is used to speed up access to OBJECT items
        
        private var objectMemberCache: Dictionary<String, VJson>?
        
        
        // Enables or disables the cache
        
        fileprivate var cacheEnabled: Bool = false {
            didSet { objectMemberCache = nil }
        }
        
        
        /// The child items under management
        
        public fileprivate(set) var items: Array<VJson> = [] {
            didSet { objectMemberCache = nil }
        }
        
        
        /// Subscript access to the child items
        
        fileprivate private(set) subscript(index: Int) -> VJson? {
            get {
                guard index < items.count else { return nil }
                guard index >= 0 else { return nil }
                return items[index]
            }
            set {
                guard let child = newValue else { return }
                guard index < items.count else { return }
                guard index >= 0 else { return }
                
                
                // Ensures the child's parent is always set
                
                child.parent = parent
                
                
                // Remove the parent from the child to be replaced
                
                items[index].parent = nil
                
                
                // Replace the child
                
                items[index] = child
            }
        }
        
        
        /// A shortcut to the count of the array of children
        
        public var count: Int { return items.count }
        
        
        /// Returns the index of the given child item.
        ///
        /// - Parameter of: The child to be found.
        ///
        /// - Returns: The index of the requested child, or nil if not found.
        
        fileprivate func index(ofChild child: VJson?) -> Int? {
            guard let child = child else { return nil }
            for (index, item) in items.enumerated() {
                if item === child { return index } // Compare and break if the child is found
            }
            return nil
        }
        
        
        /// Returns an array with the indicies of all items that are equal to the given child.
        ///
        /// - Parameter ofChildrenEqualTo: The child to compare the items to.
        ///
        /// - Returns: An array with the indicies of the items that match the child.
        
        fileprivate func index(ofChildrenEqualTo child: VJson?) -> [Int] {
            guard let child = child else { return [] }
            var result: Array<Int> = []
            for (index, item) in items.enumerated() {
                if item == child { result.append(index) }
            }
            return result
        }
        
        
        /// Add the given child item to the end of the existing children
        ///
        /// - Parameter child: The child to be added.
        ///
        /// - Returns: The child that was added.
        
        @discardableResult
        fileprivate func append(_ child: VJson?) -> VJson? {
            guard let child = child else { return parent }
            
            child.parent = parent // Ensures the child's parent is always set
            items.append(child)
            return child
        }
        
        
        /// Add the given child items to the end of the existing children
        ///
        /// - Parameter array: The array with new child items.
        
        fileprivate func append(_ array: Array<VJson>) {
            array.forEach() { append($0) }
        }
        
        
        /// Inserts the given child item at the specified position.
        ///
        /// - Parameters:
        ///   - child: The item to be inserted.
        ///   - at: The index where to insert the child.
        ///
        /// - Returns: The inserted item.
        
        @discardableResult
        fileprivate func insert(_ child: VJson?, at index: Int) -> VJson? {
            guard let child = child else { return parent }
            guard index < items.count else { return nil }
            guard index >= 0 else { return nil }
            
            child.parent = parent // Ensures the child's parent is always set
            items.insert(child, at: index)
            return child
        }
        
        
        /// Replaces the child at the specified index with the new child.
        ///
        /// - Parameters:
        ///   - childAt: The index of the child to be replaced.
        ///   - with: The child item to be placed at the specified index.
        ///
        /// - Returns: The inserted child.
        
        @discardableResult
        fileprivate func replace(childAt index: Int, with child: VJson?) -> VJson? {
            guard let child = child else { return parent }
            guard index < items.count else { return nil }
            guard index >= 0 else { return nil }
            
            items[index].parent = nil // The child at the index will no longer be a child
            child.parent = parent // Ensures the child's parent is always set
            items[index] = child
            return child
        }
        
        
        /// Removes the child at the specified index.
        ///
        /// - Parameter childAt: The index of the child item to be removed.
        ///
        /// - Returns: The child that was removed, or nil if the index did not exist.
        
        @discardableResult
        fileprivate func remove(childAt index: Int) -> VJson? {
            guard index < items.count else { return nil }
            guard index >= 0 else { return nil }
            
            items[index].parent = nil // Make sure it is decoupled from the parent
            return items.remove(at: index)
        }
        
        
        /// Removes the specified child.
        ///
        /// - Parameter child: The child to be removed.
        ///
        /// - Returns: The child that was removed, nil if nothing was removed.
        
        @discardableResult
        fileprivate func remove(_ child: VJson?) -> VJson? {
            guard let child = child else { return parent }
            
            if let index = index(ofChild: child) {
                items[index].parent = nil // Make sure it is decoupled from the parent
                return items.remove(at: index)
            } else {
                return nil
            }
        }
        
        
        /// Remove all child items that are identical to the specified child item.
        ///
        /// - Parameter childrenWith: The child against which to compare the internal items.
        ///
        /// - Returns: The number of children removed.
        
        @discardableResult
        fileprivate func remove(childrenWith name: String?) -> Int {
            guard let name = name else { return 0 }
            
            var result = 0
            for i in (0 ..< items.count).reversed() {
                if items[i].name == name {
                    remove(childAt: i)
                    result += 1 // Count the number of removed children
                }
            }
            return result
        }
        
        
        /// Removes all children.
        
        fileprivate func removeAll() {
            items.forEach(){ $0.parent = nil }
            items.removeAll()
        }
        
        
        /// Returns a cached value if chaching is enabled.
        ///
        /// It will also build the cache if the cache is not present, but enabled.
        
        fileprivate func cached(_ key: String) -> VJson? {
            if !cacheEnabled { return nil }
            if objectMemberCache == nil {
                objectMemberCache = [:]
                for child in items {
                    guard let name = child.name else {
                        objectMemberCache = nil
                        return nil
                    }
                    objectMemberCache?[name] = child
                }
            }
            return objectMemberCache?[key]
        }
    }


    /// Returns a copy of the child items in this object if this object contains a JSON ARRAY or JSON OBJECT. An empty array for all other JSON types.
    
    public var arrayValue: Array<VJson> {
        guard type == .array || type == .object else { return [] }
        var arr: Array<VJson> = []
        children?.items.forEach(){ arr.append($0.duplicate) }
        return arr
    }
    
    
    /// Returns a copy of the children in a dictionary if this object contains a JSON OBJECT. An empty dictionary for all other JSON types.
    
    public var dictionaryValue: Dictionary<String, VJson> {
        if type != .object { return [:] }
        var dict: Dictionary<String, VJson> = [:]
        children?.items.forEach(){
            if let name = $0.name {
                dict[name] = $0.duplicate
            }
        }
        return dict
    }
    
    
    /// True if this item contains any childeren. False if this item does not have any children.
    
    public var hasChildren: Bool {
        return (children?.count ?? 0) > 0
    }
    
    
    /// The number of child items this object contains.
    
    public var nofChildren: Int {
        return children?.count ?? 0
    }

    
    /// Removes all children from either ARRAY or OBJECT
    
    public func removeAllChildren() {
        children?.removeAll()
    }
    
    
    /// Removes the child items from self that are equal to the given item. Self must be an ARRAY or OBJECT.
    ///
    /// - Note: The parent is not compared when testing for equal.
    ///
    /// - Parameters:
    ///   - childrenEqualTo: The item to compare against.
    ///
    /// - Returns: The number of child items removed.
    
    public func remove(childrenEqualTo item: VJson?) -> Int {
        guard type == .array || type == .object else { return 0 }
        var count = 0
        if let indicies = children?.index(ofChildrenEqualTo: item) {
            for index in indicies.reversed() {
                _ = children?.remove(childAt: index)
                count += 1
            }
        }
        return count
    }

    
    /// Turns the JSON ARRAY in this object into a JSON OBJECT. Note that this can only succeed if all child items have a name. (I.e. are name/value pairs)
    ///
    /// - Returns: true if the conversion was successful. False otherwise.
    
    @discardableResult
    public func arrayToObject() -> Bool {
        if type != .array { return false }
        for child in children?.items ?? [] {
            if !child.hasName { return false }
        }
        self.type = .object
        return true
    }
    
    
    /// Turns the JSON OBJECT in this object into a JSON ARRAY.
    ///
    /// Note that the names will be preserved until the array is saved. Then they will be discarded.
    ///
    /// - Returns: True if succesful.
    
    @discardableResult
    public func objectToArray() -> Bool {
        if type != .object { return false }
        type = .array
        return true
    }
    

    /// Controls the status of the dictionary cache for JSON OBJECTs. The dictionary cache can be used to speed up subscript access. As a ROM when looking for an OBJECT members 3 times or more, the cache will pay back its overhead. In some cases 2 times may be enough. More than 3 times is generally always quicker with cache enabled.
    ///
    /// - Note: The dictionary cache will speed up access for OBJECT members, but will "lose" members with duplicate names. I.e. a {"one":1, "one":2} object will only contain {"one":2} when caching is enabled. However the lost member is still present in the "children" array and will be saved (or be part of the generated code).
    
    public var enableCacheForObjects: Bool {
        set { children?.cacheEnabled = newValue }
        get { return children?.cacheEnabled ?? false}
    }
    
    
    /// Creates an empty JSON ARRAY item with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: The new VJson item containing a JSON ARRAY.
    
    public static func array(_ name: String? = nil) -> VJson {
        return VJson([VJson?](), name: name)
    }
    
    
    /// Creates an empty JSON OBJECT item with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: The new VJson item containing a JSON OBJECT.
    
    public static func object(_ name: String? = nil) -> VJson {
        return VJson(type: .object, name: name)
    }
    
    
    /// Returns a new VJson object with a JSON ARRAY containing the given items. Only those items that have their 'parent' member set to 'nil' will be included.
    ///
    /// - Parameters:
    ///   - items: An array with VJson objects to be added as children, only those with parent == nil.
    ///   - name: The name for the JSON ARRAY item.
    ///   - includeNil: If true (default = false) then nil items in the array will be included as JSON NULL items.
    
    public convenience init(_ items: [VJson?], name: String? = nil, includeNil: Bool = false) {
        self.init(type: .array, name: name)
        let parentIsNilItems = items.filter(){ return $0?.parent == nil }
        if includeNil {
            self.children?.append(parentIsNilItems.map(){ $0 ?? VJson.null()})
        } else {
            self.children?.append(parentIsNilItems.flatMap(){$0})
        }
    }
    
    
    /// Returns a new VJson object with a JSON ARRAY containing the given items.
    ///
    /// - Parameters:
    ///   - items: An array with VJson objects to be added as children.
    ///   - name: The name for the contained item (optional).
    ///   - includeNil: If true (default = false) then nil items in the array will be included as JSON NULL items.
    
    public convenience init(_ items: [VJsonSerializable?], name: String? = nil, includeNil: Bool = false) {
        self.init(items.map({$0?.json}), name: name, includeNil: includeNil)
    }
    
    
    /// Returns a new VJson object with a JSON OBJECT containing the items from the dictionary. Only those items that have their 'parent' member set to 'nil' will be included.
    ///
    /// - Parameters:
    ///   - items: A dictionary with the name/value pairs to be included as children.
    ///   - name: The name for the contained item (optional).
    
    public convenience init(items: [String:VJson], name: String? = nil) {
        self.init(type: .object, name: name)
        var newItems: Array<VJson> = []
        let parentIsNilItems = items.filter(){ return $0.value.parent == nil }
        for (pname, item) in parentIsNilItems {
            item.name = pname
            newItems.append(item)
        }
        self.children?.append(newItems)
    }
    
    
    /// Returns a new VJson object with a JSON OBJECT containing the items from the dictionary.
    ///
    /// - Parameters:
    ///   - items: A dictionary with the name/value pairs to be included as children.
    ///   - name: The name for the contained item (optional).
    
    public convenience init(_ items: [String:VJsonSerializable], name: String? = nil) {
        self.init(type: VJson.JType.object, name: name)
        var newItems: [VJson] = []
        for (name, item) in items {
            let jitem = item.json
            jitem.name = name
            newItems.append(jitem)
        }
        self.children?.append(newItems)
    }
}


// MARK: - Child manipulation of JSON ARRAYs

extension VJson {

    
    /// Returns the child at the given index if it exists. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - at: The index of the requested child.
    ///
    /// - Returns: The object or nil if no object exists at the given index. If self is not an array, it also returns nil.
    
    public func child(at index: Int) -> VJson? {
        guard type == .array else { return nil }
        return self|index
    }
    
    
    /// The index of the given child. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - ofChild: The child to find the index of.
    ///
    /// - Returns: The index of the child if it is present. Nil if none was found.
    
    public func index(ofChild child: VJson?) -> Int? {
        guard let child = child else { return nil }
        guard type == .array else { return nil }
        return children?.index(ofChild: child)
    }

    
    /// The indicies of the children with identical contents as the given child. An empty array if no comparable child is found. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - ofChildEqualTo: The child to compare the content with.
    ///
    /// - Returns: The indicies of the child items with the same content. An empty array if none was found.
    
    public func index(ofChildrenEqualTo item: VJson?) -> [Int] {
        guard let item = item else { return [] }
        guard type == .array else { return [] }
        return children?.index(ofChildrenEqualTo: item) ?? []
    }

    
    /// Removes the given object from self. Self must be an array.
    ///
    /// - Parameters:
    ///   - child: The child object to remove.
    ///
    /// - Returns: Nil on failure, the item that was removed on success.
    
    @discardableResult
    public func remove(child item: VJson?) -> VJson? {
        guard type == .array else { return nil }
        if let index = children?.index(ofChild: item) {
            return children?.remove(childAt: index)
        } else {
            return nil
        }
    }
    
    
    /// Replaces the child at the given index with the given child. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - childAt: The index of the child to be replaced.
    ///   - with: The VJson object to be inserted.
    ///
    /// - Returns: The inserted child, or nil if an error occured.
    
    @discardableResult
    public func replace(childAt index: Int, with child: VJson?) -> VJson? {
        guard let child = child else { return nil }
        guard type == .array else { return nil }
        return children?.replace(childAt: index, with: child)
    }

    
    /// Inserts the given child at the given index. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be inserted.
    ///   - at index: The index at which it will be inserted. Must be >= 0 && < nofChildren to succeed.
    ///
    /// - Returns: The inserted child, or nil if an error occured.
    
    @discardableResult
    public func insert(_ child: VJson?, at index: Int) -> VJson? {
        guard let child = child else { return nil }
        changeTypeConditionally(to: .array)
        guard type == .array else { return nil }
        return children?.insert(child, at: index)
    }
    
    
    /// Appends the given object to the end of the array. Self must be a JSON ARRAY.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be appended.
    ///
    /// - Returns: The appended child, or nil if an error occured.
    
    @discardableResult
    public func append(_ child: VJson?) -> VJson? {
        guard let child = child else { return nil }
        changeTypeConditionally(to: .array)
        guard type == .array else { return nil }
        return children?.append(child)
    }

    
    /// Appends the given object to the end of the array. Self must be a JSON ARRAY.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be appended.
    ///
    /// - Returns: The appended child, or nil if an error occured.
    
    @discardableResult
    public func append(_ item: VJsonSerializable?) -> VJson? {
        return append(item?.json)
    }

    
    /// Appends the given objects to the end of the array. Self must be a JSON ARRAY.
    ///
    /// - Parameters:
    ///   - children: The items to add.
    ///   - includeNil: If true, a NULL will be added for each 'nil' in the array.
    
    public func append(children items: [VJson?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        items.forEach() {
            if $0 == nil {
                if includeNil { append(VJson.null()) }
            } else {
                append($0)
            }
        }
    }

    
    /// Appends the given objects to the end of the array. Self must be a JSON ARRAY.
    ///
    /// - Parameters:
    ///   - children: The items to add.
    ///   - includeNil: If true, a NULL will be added for each 'nil' in the array.

    public func append(children items: [VJsonSerializable?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        let newItems = items.map() { $0?.json }
        append(children: newItems, includeNil: includeNil)
    }
}


// MARK: - Child manipulation of JSON OBJECTs

extension VJson {
    
    
    /// Returns the child with the requested name, if any.
    ///
    /// - Parameters:
    ///   - name: The name of the requested child.
    ///
    /// - Returns: The requested child if it is present, nil otherwise.
    
    public func child(with name: String) -> VJson? {
        guard type == .object else { return nil }
        return self|name
    }
    
    
    /// Return all children with the given name. The count will be zero if no child with the given name exists.
    ///
    // - Parameter with: The name of the sought after child items.
    ///
    /// - Returns: An array with the found child items, may be empty.

    public func children(with name: String) -> [VJson] {
        guard type == .object else { return [] }
        return self.children?.items.filter(){ $0.name == name } ?? []
    }
    
    
    /// Add a new item with the given name or replace a current item with that same name (when "replace" = 'true'). Self must contain a JSON OBJECT item or a NULL. If it is a NULL it will be converted into an OBJECT.
    ///
    /// - Parameters:
    ///   - child: The child that should replace or be appended. The child must have a name or a name must be provided in the parameter "for name". If a name is provided in "for name" then that name will take precedence and replace the name contained in the child item.
    ///   - name: If nil, the child must already have a name. If non-nil, then this name will be used and the name of the child (if present) will be overwritten.
    ///   - replace: If 'true' (default) it will replace all existing items with the same name. If 'false', then the child will be added and no check on duplicate names will be performed.
    /// - Returns: The child that was added or nil on failure.
    
    @discardableResult
    public func add(_ child: VJson?, for name: String? = nil, replace: Bool = true) -> VJson? {
        guard let child = child else { return nil }
        if name == nil && !child.hasName { return nil }
        changeTypeConditionally(to: .object)
        if name != nil { child.name = name }
        if replace { children?.remove(childrenWith: child.name) }
        return children?.append(child)
    }

    
    /// Add a new item with the given name or replace a current item with that same name (when "replace" = 'true'). Self must contain a JSON OBJECT item or a NULL. If it is a NULL it will be converted into an OBJECT.
    ///
    /// - Parameters:
    ///   - child: The child that should replace or be appended. The child must have a name or a name must be provided in the parameter "for name". If a name is provided in "for name" then that name will take precedence and replace the name contained in the child item.
    ///   - name: If nil, the child must already have a name. If non-nil, then this name will be used and the name of the child (if present) will be overwritten.
    ///   - replace: If 'true' (default) it will replace all existing items with the same name. If 'false', then the child will be added and no check on duplicate names will be performed.
    /// - Returns: The child that was added or nil on failure.

    @discardableResult
    public func add(_ item: VJsonSerializable?, for name: String? = nil, replace: Bool = true) -> VJson? {
        return add(item?.json, for: name, replace: replace)
    }
    
    
    /// Removes all children with the given name from this object only. Self must contain a JSON OBJECT.
    ///
    /// - Parameters:
    ///   - childrenWith: The name of the child items to be removed.
    ///
    /// - Returns: The number of children removed.
    
    @discardableResult
    public func remove(childrenWith name: String) -> Int {
        guard type == .object else { return 0 }
        return children?.remove(childrenWith: name) ?? 0
    }
}


// MARK: - Hierarchy support

extension VJson {
    
    
    /// Looks for a specific item in the hierachy.
    ///
    /// - Parameters:
    ///   - of: The JSON TYPE of object to look for.
    ///   - at path: An array of strings describing the path at which the item should exist. Note that integer indexing will convert the string into an index before using. Hence a path of ["12"] can refer to the item at index 12 as well as the item for name "12".
    ///
    /// - Returns: the item at the given path if it exists and is of the given type. Otherwise nil.
    
    public func item(of type: JType, at path: [String]) -> VJson? {
        
        if path.count == 0 {
            
            if self.type == type { return self }
            return nil
            
        } else {
            
            switch self.type {
                
            case .array:
                
                let i = (path[0] as NSString).integerValue
                
                if i >= self.nofChildren { return nil }
                
                var reducedPath = path
                reducedPath.removeFirst()
                
                return children?.items[i].item(of: type, at: reducedPath)
                
                
            case .object:
                
                for child in children?.items ?? [] {
                    if child.name == nil { return nil } // Should not be possible
                    if child.name == path[0] {
                        
                        var reducedPath = path
                        reducedPath.removeFirst()
                        
                        return child.item(of: type, at: reducedPath)
                    }
                }
                return nil
                
                
            default: return nil
            }
        }
    }
    
    
    /// Looks for a specific item in the hierachy.
    ///
    /// - Parameters:
    ///   - of: The JSON TYPE of object to look for.
    ///   - at path: A set of strings describing the path at which the item should exist. Note that integer indexing will convert the string into an index before using. Hence a path of "12" can refer to the item at index 12 as well as the item for name "12".
    ///
    /// - Returns: the item at the given path if it exists and is of the given type. Otherwise nil.
    
    public func item(of: JType, at path: String ...) -> VJson? {
        return item(of: of, at: path)
    }
}


// MARK: - Merging hierarchies

extension VJson {
    
    
    /// Updates the content of this object with the content of the object to be merged. Child members with the same name in self as in other will be made identical to the member in other.
    ///
    /// This merge function was designed to support the outline view. When members are merged the original member will remain, only its data content will change. This also applies to array items.
    ///
    /// After merging the two hierarchies will not share objects, i.e. all shared data is duplicated.
    ///
    /// - Note: This operation can change the types of the content in self to and from null. Other type conversions are only possible if VJson.fatalErrorOnTypeConversion is set to 'false'
    ///
    /// - Note: If other has two children with the same name, the order in which they appear will be preserved
    ///
    /// - Parameters
    ///   - with: The object to be merged into self.
    
    public func merge(with other: VJson) {
        
        
        // Copy the name
        
        self.name = other.name
        
        
        // The other type drives the merge, for the simple types (non-array non-object) the other is simply copied.
        
        switch other.type {
            
        case .null:
            changeTypeConditionally(to: .null);
            return
            
        case .bool:
            changeTypeConditionally(to: .bool)
            self.bool = other.bool
            return
            
        case .string:
            changeTypeConditionally(to: .string)
            self.string = other.string
            return
            
        case .number:
            changeTypeConditionally(to: .number)
            self.number = other.numberValue
            return
            
        case .object:
            
            // If self is not an object, then make self the same as other
            
            switch self.type {
                
            case .null, .bool, .number, .string, .array:
                changeTypeConditionally(to: .object)
                self.children = Children(parent: self)
                self.children?.append(other.children?.items ?? [])
                return
                
            case .object:
                
                // Override children with the same name as in others, add those that are not present.
                
                
                // Adds a checkmark to each element, just to keep score.
                
                struct CheckBoxed<T> {
                    var checked: Bool = false
                    let value: T
                    init(_ value: T) { self.value = value }
                }
                
                
                // Create a list of all self children with a marker for each
                
                var selfChildren: Array<CheckBoxed<VJson>> = []
                self.children?.items.forEach({ selfChildren.append(CheckBoxed($0))})
                
                
                // Any other children that are not contained in self children will be added in this array before adding them to self.
                
                var newChildren: Array<VJson> = []
                
                
                // Merge self children with same name as other children
                
                for oc in other.children?.items ?? [] {
                    var sc: VJson?
                    for index in 0 ..< selfChildren.count {
                        if !selfChildren[index].checked && (selfChildren[index].value.name == oc.name) {
                            sc = selfChildren[index].value
                            selfChildren[index].checked = true
                            break
                        }
                    }
                    if sc == nil {
                        newChildren.append(oc)
                    } else {
                        sc?.merge(with: oc)
                    }
                }
                
                
                // Add the new children in other to self
                
                self.children?.append(newChildren)
            }
            
            
        case .array:
            
            switch self.type {
            case .null, .bool, .number, .string, .object:
                changeTypeConditionally(to: .array)
                self.children = Children(parent: self)
                self.children?.append(other.arrayValue)
                return
                
            case .array:
                
                for index in 0 ..< (other.children?.count ?? 0) {
                    if index < (self.children?.count ?? 0) {
                        self.children?.items[index].merge(with: other.children!.items[index])  // Force unwrap tested before use
                    } else {
                        _ = self.children?.append(other.children!.items[index])  // Force unwrap tested before use
                    }
                }
            }
        }
    }
}


// MARK: - Sequence protocol

extension VJson: Sequence {
    
    
    /// The generator for the VJson object.
    
    public struct MyGenerator: IteratorProtocol {
        
        public typealias Element = VJson
        
        // The object for which the generator generates
        private let source: VJson
        
        // The objects already delivered through the generator
        private var sent: Array<VJson> = []
        
        fileprivate init(source: VJson) {
            self.source = source
        }
        
        /// Returns the next child item
        ///
        /// - Returns: The next child item.
        
        mutating public func next() -> Element? {
            
            // Only when the source has values to deliver
            if let values = source.children?.items {
                
                // Find a value that has not been sent already
                OUTER: for i in values {
                    
                    // Check if the value has not been sent already
                    for s in sent {
                        
                        // If it was sent, then try the next value
                        if i === s { continue OUTER }
                    }
                    
                    // Found a value that was not sent yet
                    // Remember that it will be sent
                    sent.append(i)
                    
                    // Send it
                    return i
                }
            }
            
            // Nothing left to send
            return nil
        }
    }
    
    
    /// defines the struct used as the iterator
    
    public typealias Iterator = MyGenerator
    
    
    /// Creates an iterator
    ///
    /// - Returns: A new iterator.
    
    public func makeIterator() -> Iterator { return MyGenerator(source: self) }
}


// MARK: - Subscript support

extension VJson {

    
    /// Assigns/retrieves based on the given index.
    ///
    /// Only valid for VJson objects containing a JSON ARRAY.
    ///
    /// - Note: Can result in a fatal error if the VJson.fatalErrorOnTypeConversion is set to 'true' (= default)
    
    public subscript(index: Int) -> VJson {
        
        set {
            
            // If this is an ARRAY object, then make sure there are enough elements and create the requested element
            
            if type != .array { changeTypeConditionally(to: .array) }
            
            
            // Ensure that enough elements are present in the array
            
            if let children = children {
                
                while index > (children.count - 1) {
                    let item = VJson.null()
                    item.createdBySubscript = true
                    _ = children.append(item)
                }
                
                children.replace(childAt: index, with: newValue)
            }
        }
        
        get {
            
            
            // If this is an ARRAY object, then make sure there are enough elements and return the requested element
            
            if type != .array { changeTypeConditionally(to: .array) }
            
            
            // Ensure that enough elements are present in the array
            
            if let children = children {
                while index > (children.count - 1) {
                    let item = VJson.null()
                    item.createdBySubscript = true
                    _ = children.append(item)
                }
            }
            
            return children?.items[index] ?? VJson("***ERROR***") // The ?? should never be activated
        }
    }
    
    
    /// Assigns/retrieves based on the given key.
    ///
    /// Only valid for VJson objects containing a JSON OBJECT.
    ///
    /// - Note: Can result in a fatal error if the VJson.fatalErrorOnTypeConversion is set to 'true' (= default)
    
    public subscript(key: String) -> VJson {
        
        set {
            
            
            // If this is not an object type, change it into an object
            
            if type != .object { changeTypeConditionally(to: .object) }
            
            add(newValue, for: key)
        }
        
        get {
            
            
            // If this is not an object type, change it into an object
            
            if type != .object { changeTypeConditionally(to: .object) }
            
            
            // If the requested object exist, return it
            
            if let result = children!.cached(key) { return result } // Try the cache
            
            let arr = children(with: key)
            
            if arr.count > 0 { return arr[0] }
            
            
            // If the request value does not exist, create it
            // This allows object creation for 'object["key1"]["key2"]["key3"] = SwifterJSON(12)' constructs.
            
            let new = VJson.null()
            new.createdBySubscript = true
            add(new, for: key)
            
            return new
        }
    }
    
    
    // Remove empty objects that resulted from subscript access.
    
    fileprivate func removeEmptySubscriptObjects() {
        
        
        // For JSON OBJECTs, remove all name/value pairs that are created by a subscript and do not contain any non-subscript generated value
        
        if type == .object {
            
            
            // Itterate over all name/value pairs
            
            for child in children?.items ?? [] {
                
                
                // Make sure that this value has all its subscript generated values removed
                
                if child.nofChildren > 0 { child.removeEmptySubscriptObjects() }
                
                
                // Remove the value if it is generated by subscript and contains no usefull items
                
                if child.createdBySubscript && child.nofChildren == 0 {
                    _ = children?.remove(child)
                }
            }
            
            return
        }
        
        
        // For JSON ARRAYs, remove all values that are createdby a subscript and do not contain any non-subscript generated value
        
        if type == .array {
            
            
            // This array will contain the indicies of all values that should be removed
            
            var itemsToBeRemoved = [Int]()
            
            
            // Loop over all values, backwards. As soon as a value is hit that cannot be removed, stop iterating
            
            if (children?.count ?? 0) > 0 {
                
                for index in (0 ..< (children?.count ?? 0)).reversed() {
                    
                    if let child = children?[index] {
                    
                    
                        // Make sure that this value has all its subscript generated values removed
                        
                        if child.nofChildren > 0 { child.removeEmptySubscriptObjects() }
                        
                        
                        // If this value is created by subscript, then check if it has content
                        
                        if child.createdBySubscript && child.nofChildren == 0 {
                            itemsToBeRemoved.append(index)
                        } else {
                            break
                        }
                    }
                }
                
                
                // Actually remove items, if any.
                // Note: Because of the reverse loop above, the indexes in itemsToBeRemoved count down.
                
                for i in itemsToBeRemoved { children!.remove(childAt: i) }
            }
        }
    }
}


// MARK: - Copying support

extension VJson {

    
    /// Returns a full in-depth copy of this JSON object. I.e. all child elements are also copied.
    
    public var duplicate: VJson {
        let other = VJson(type: self.type, name: self.name)
        other.type = self.type
        other.bool = self.bool
        other.string = self.string
        other.number = self.numberValue // Creates a copy of the NSNumber
        other.createdBySubscript = self.createdBySubscript
        for c in self.children?.items ?? [] {
            _ = other.children?.append(c.duplicate)
        }
        return other
    }

    
    /// Replaces the content of self with the content of the given object, but it does not change the parent reference and the createdBySubscript will be set to false.
    ///
    /// - Note: A fatalError is raised if a type change is attempeted but not supported.
    ///
    /// - Parameter with other: The VJson object from which to copy the data.
    ///
    /// - Returns: True if the operation was sucessful, false otherwise.
    
    @discardableResult
    public func replaceContent(with other: VJson?) -> Bool {
        guard let other = other else { return false }
        VJson.fatalIfTypeChangeNotAllowed(from: self.type, to: other.type)
        self.type = other.type
        self.bool = other.bool
        self.string = other.string
        self.number = other.numberValue // Creates a copy of the NSNumber if not nil
        self.createdBySubscript = false
        if other.children != nil { self.children = Children(parent: self) }
        for child in other.children?.items ?? [] { _ = self.children?.append(child) }
        return true
    }
    
    
    /// Replaces self with other in the parent of self. The parent of other must be nil.
    ///
    /// - Note: A fatalError is raised if a type change is attempeted but not supported.
    ///
    /// - Parameter with other: The VJson object which to replace self with.
    ///
    /// - Returns: True if the operation was sucessful, false otherwise.
    
    @discardableResult
    public func replaceSelfInParent(with other: VJson?) -> Bool {
        guard let other = other else { return false }
        guard let parent = self.parent else { return false }
        guard other.parent == nil else { return false }
        VJson.fatalIfTypeChangeNotAllowed(from: self.type, to: other.type)
        var success = false
        for (index, child) in (parent.children?.items ?? []).enumerated() {
            if child === self {
                _ = parent.children?.replace(childAt: index, with: other)
                success = true
                break
            }
        }
        return success
    }
}


// MARK: - Creating a VJson hierarchy from json code

extension VJson {
    
    
    /// A general purpose wrapper for function results that return ParseFunctionResult's
    ///
    /// Recommended use: let json = VJson.parse(data(from: myJsonCode)){ ... error handler ... }
    
    public typealias parseErrorSignature = (_ code: Int, _ incomplete: Bool, _ message: String) -> Void
    
    
    /// This error type gets thrown if errors are found during parsing.
    ///
    /// - reason: The details of the error.
    
    public enum Exception: Error, CustomStringConvertible {
        
        
        /// The details of the error
        ///
        /// - code: An integer number that references the error location
        /// - incomplete: When true, the error occured because the parser ran out of characters.
        /// - message: A textual description of the error.
        
        case reason(code: Int, incomplete: Bool, message: String)
        
        
        /// The textual description of the exception.
        
        public var description: String {
            if case let .reason(code, incomplete, message) = self { return "[\(code), Incomplete:\(incomplete)] \(message)" }
            return "VJson: Error in Exception enum"
        }
    }

    
    /// Error info from the parser for the parse operations that do not throw.
    
    public struct ParseError {
        
        
        /// An integer number that references the error location
        
        public var code: Int
        
        
        /// When true, the error occured because the parser ran out of characters.
        
        public var incomplete: Bool
        
        
        /// A textual description of the error.
        
        public var message: String
        
        
        /// Create a new ParseError
        ///
        /// - Parameters:
        ///   - code: An integer number that references the error location
        ///   - incomplete: True if the error occured because the parser ran out of characters.
        ///   - message: A textual description of the error.
        
        public init(code: Int, incomplete: Bool, message: String) {
            self.code = code
            self.incomplete = incomplete
            self.message = message
        }
        
        
        /// Creates an empty ParseError
        
        public init() {
            self.init(code: -1, incomplete: false, message: "")
        }
        
        
        /// The textual description of the ParseError
        
        public var description: String {
            return "[\(code), Incomplete:\(incomplete)] \(message)"
        }
    }

    
    /// Parsing a JSON hierarchy stored in a file
    ///
    /// - Parameter from: The URL of a file.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(file: URL, onError: parseErrorSignature) -> VJson? {
        do {
            return try parse(file: file)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            onError(code, incomplete, message)
            
        } catch let error {
            onError(-1, false, "\(error)")
        }
        return nil
    }
    
    
    /// Create a VJson hierarchy from the contents of the given file.
    ///
    /// - Parameter file: The URL that designates the file to be read.
    ///
    /// - Returns: A VJson hierarchy with the contents of the file.
    ///
    /// - Throws: Either an VJson.Error.reason or an NSError if the VJson hierarchy could not be created or the file not be read.
    
    public static func parse(file: URL) throws -> VJson {
        var data = try Data(contentsOf: URL(fileURLWithPath: file.path), options: Data.ReadingOptions.uncached)
        return try vJsonParser(data: &data)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given file.
    ///
    /// - Parameters:
    ///   - file: The URL that designates the file to be read.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(file: URL, errorInfo: inout ParseError?) -> VJson? {
        
        do {
            return try parse(file: file)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
    
    
    /// Parsing a JSON hierarchy stored in a buffer
    ///
    /// - Parameter from: The buffer to parse.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(buffer: UnsafeBufferPointer<UInt8>, onError: parseErrorSignature) -> VJson? {
        
        do {
            return try VJson.vJsonParser(buffer: buffer)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            onError(code, incomplete, message)
            
        } catch let error {
            onError(-1, false, "\(error)")
        }
        return nil
    }
    
    
    /// Create a VJson hierarchy with the contents of the given buffer.
    ///
    /// - Parameters:
    ///   - buffer: The buffer containing the data to be parsed.
    ///
    /// - Returns: A VJson hierarchy with the contents of the buffer.
    ///
    /// - Throws: A VJson.Error.reason if the parsing failed.
    
    public static func parse(buffer: UnsafeBufferPointer<UInt8>) throws -> VJson {
        return try VJson.vJsonParser(buffer: buffer)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given buffer.
    ///
    /// - Parameters
    ///   - buffer: The buffer containing the data to be parsed.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(buffer: UnsafeBufferPointer<UInt8>, errorInfo: inout ParseError?) -> VJson? {
        
        do {
            return try parse(buffer: buffer)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
    
    
    /// Parsing a JSON hierarchy stored in a string.
    ///
    /// - Parameter from: The string to parse.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(string: String, onError: parseErrorSignature) -> VJson? {
        do {
            return try VJson.parse(string: string)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            onError(code, incomplete, message)
            
        } catch let error {
            onError(-1, false, "\(error)")
        }
        return nil
    }

    
    /// Create a VJson hierarchy with the contents of the given string.
    ///
    /// - Parameters:
    ///   - string: The string containing the data to be parsed.
    ///
    /// - Returns: A VJson hierarchy with the contents of the buffer.
    ///
    /// - Throws: A VJson.Error.reason if the parsing failed.
    
    public static func parse(string: String) throws -> VJson {
        guard var data = string.data(using: String.Encoding.utf8) else {
            throw VJson.Exception.reason(code: 59, incomplete: false, message: "Could not convert string to UTF8")
        }
        return try VJson.vJsonParser(data: &data)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given buffer.
    ///
    /// - Parameters
    ///   - string: The string containing the data to be parsed.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(string: String, errorInfo: inout ParseError?) -> VJson? {
        
        do {
            return try parse(string: string)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
    
    
    /// Parsing a JSON hierarchy stored in a Data object
    ///
    /// - Parameter from: The data to parse.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(data: inout Data, onError: parseErrorSignature) -> VJson? {
        do {
            return try VJson.vJsonParser(data: &data)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            onError(code, incomplete, message)
        
        } catch let error {
            onError(-1, false, "\(error)")
        }
        return nil
    }


    /// Create a VJson hierarchy with the contents of the given data object.
    ///
    /// - Parameters:
    ///   - data: The data object containing the data to be parsed.
    ///
    /// - Returns: A VJson hierarchy with the contents of the data object.
    ///
    /// - Throws: A VJson.Error.reason if the parsing failed.
    
    public static func parse(data: inout Data) throws -> VJson {
        return try VJson.vJsonParser(data: &data)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given data object.
    ///
    /// - Parameters
    ///   - data: The data object containing the data to be parsed.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(data: inout Data, errorInfo: inout ParseError?) -> VJson? {
        do {
            return try VJson.vJsonParser(data: &data)
            
        } catch let .reason(code, incomplete, message) as VJson.Exception {
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
}


// MARK: - Create code from the json hierarchy

extension VJson {

    
    /// Returns the JSON code that represents the hierarchy of this item.
    
    public var code: String {
        
        // Get rid of subscript generated objects that no longer serve a purpose
        
        self.removeEmptySubscriptObjects()
        
        var str = ""
        
        switch type {
            
        case .null:
            
            str += "null"
            
            
        case .bool:
            
            if bool == nil {
                str += "null"
            } else {
                str += "\(self.bool!)"
            }
            
            
        case .number:
            
            if number == nil {
                str += "null"
            } else {
                str += "\(self.number!)"
            }
            
            
        case .string:
            
            if string == nil {
                str += "null"
            } else {
                str += "\"\(self.string!)\""
            }
            
            
        case .object:
            
            str += "{"
            
            for i in 0 ..< (children?.count ?? 0) {
                if let child = children?.items[i], let name = child.name {
                    if i != (children?.count ?? 0) - 1 {
                        str += "\"\(name)\":\(child),"
                    } else {
                        str += "\"\(name)\":\(child)"
                    }
                } else {
                    str += "*** ERROR ***"
                }
            }
            
            str += "}"
            
            
        case .array:
            
            str += "["
            
            for i in 0 ..< (children?.count ?? 0) {
                if let child = children?.items[i] {
                    if i != children!.count - 1 {
                        str += "\(child),"
                    } else {
                        str += "\(child)"
                    }
                } else {
                    str += "*** ERROR ***"
                }
            }
            
            str += "]"
        }
        
        return str
    }
}


// MARK: - Persisting

extension VJson {

    
    /// Tries to saves the contents of the JSON hierarchy to the specified file.
    ///
    /// - Parameter to: The URL of the file location where to save this hierarchy.
    ///
    /// - Returns: Nil on success, Error description on fail.
    
    @discardableResult
    public func save(to: URL) -> String? {
        let str = self.code
        do {
            try str.write(to: to, atomically: false, encoding: String.Encoding.utf8)
            return nil
        } catch let error as NSError {
            return error.localizedDescription
        }
    }
}


// MARK: - Apple's parser

extension VJson {
    
    
    /// This parser uses the Apple NSJSONSerialization class to parse the given data.
    ///
    /// - Note: Parser differences: Apple's parser is usually faster (about 2x). However Apple's parser cannot parse multiple key/value pairs with the same name and Apple's parser will create a VJson NUMBER items for BOOL's.
    ///
    /// - Returns: A VJson hierarchy
    ///
    /// - Throws: The error thrown by NSJSONSerialization. Error code 100 should be impossible.
    
    public static func parseUsingAppleParser(_ data: Data) throws -> VJson {
        
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return try getVJsonFrom(json as AnyObject)
    }
    
    private static func getVJsonFrom(_ o: AnyObject) throws -> VJson {
        
        if let str = o as? NSString {
            
            return VJson(str as String)
            
        } else if let num = o as? NSNumber {
            
            return VJson(number: num)
            
        } else if o is NSNull {
            
            return VJson.null()
            
        } else if let arr = o as? NSArray {
            
            let vjson = VJson.array()
            
            for e in arr {
                vjson.append(try getVJsonFrom(e as AnyObject))
            }
            
            return vjson
            
        } else if let dict = o as? NSDictionary {
            
            let vjson = VJson.object()
            
            for e in dict {
                let name = (e.key as? String) ?? "***ERROR***"
                let value = try getVJsonFrom(e.value as AnyObject)
                vjson.add(value, for: name)
            }
            
            return vjson
            
        } else {
            
            // This should be impossible.
            throw Exception.reason(code: 100, incomplete: true, message: "Illegal value in AppleParser result")
        }
    }
}


// MARK: - The VJson parser

extension VJson {

    
    /// Parses the given sequence of bytes (ASCII or UTF8 encoded) according to ECMA-404, 1st edition October 2013. The sequence should contain exactly one JSON hierarchy. Any errors will result in a throw.
    ///
    /// - Parameter buffer: A buffer with ASCII or UTF8 formatted data to be parsed.
    ///
    /// - Returns: The VJson hierarchy representing the data in the buffer.
    ///
    /// - Throws: Error.reason
    
    fileprivate static func vJsonParser(buffer: UnsafeBufferPointer<UInt8>) throws -> VJson {
        
        guard buffer.count > 0 else { throw Exception.reason(code: 1, incomplete: true, message: "Empty buffer") }
        
        
        // Start at the beginning
        
        var offset: Int = 0
        
        
        // Top level, a value is expected
        
        let val = try readValue(buffer.baseAddress!, numberOfBytes: buffer.count, offset: &offset)
        
        
        // Only whitespaces allowed after the value
        
        if offset < buffer.count {
            
            skipWhitespaces(buffer.baseAddress!, numberOfBytes: buffer.count, offset: &offset)
            
            if offset < buffer.count { throw Exception.reason(code: 2, incomplete: false, message: "Unexpected characters after end of parsing at offset \(offset - 1)") }
        }
        
        return val
    }
    
    
    /// Parses the data according to ECMA-404, 1st edition October 2013. The sequence should contain exactly one JSON hierarchy. Any errors will result in a throw.
    ///
    /// - Parameter data: A data object with ASCII or UTF8 formatted data to be parsed.
    ///
    /// - Returns: The VJson hierarchy representing the data in the buffer.
    ///
    /// - Throws: Error.reason
    
    fileprivate static func vJsonParser(data: inout Data) throws -> VJson {
        
        guard data.count > 0 else { throw Exception.reason(code: 3, incomplete: true, message: "Empty buffer") }
        
        
        // Start at the beginning
        
        var offset: Int = 0
        
        
        // Top level, a value is expected
        
        let val = try data.withUnsafeBytes() {
            
            (ptr: UnsafePointer<UInt8>) -> VJson in
            
            try readValue(ptr, numberOfBytes: data.count, offset: &offset)
        }
        
        
        // Remove consumed bytes
        
        if offset > 0 {
            let range = Range(uncheckedBounds: (lower: 0, upper: offset))
            var dummy: UInt8 = 0
            let empty = UnsafeBufferPointer<UInt8>(start: &dummy, count: 0)
            data.replaceSubrange(range, with: empty)
        }
        
        return val
    }
    
    
    // The number formatter for the number value
    
    private static var formatter: NumberFormatter?
    
    
    // The conversion from string to number using the above number formatter
    
    private static func toDouble(_ str: String) -> Double? {
        if VJson.formatter == nil {
            VJson.formatter = NumberFormatter()
            VJson.formatter?.decimalSeparator = "."
        }
        return VJson.formatter?.number(from: str)?.doubleValue
    }
    
    
    // Read the last three characters of a "true" value
    
    private static func readTrue(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(code: 4, incomplete: true, message: "Illegal value, missing 'r' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._r { throw Exception.reason(code: 5, incomplete: false, message: "Illegal value, no 'r' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 6, incomplete: true, message: "Illegal value, missing 'u' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._u { throw Exception.reason(code: 7, incomplete: false, message: "Illegal value, no 'u' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 8, incomplete: true, message: "Illegal value, missing 'e' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._e { throw Exception.reason(code: 9, incomplete: false, message: "Illegal value, no 'e' in 'true' at offset \(offset)") }
        offset += 1
        
        return VJson(true)
    }
    
    
    // Read the last four characters of a "false" value
    
    private static func readFalse(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(code: 10, incomplete: true, message: "Illegal value, missing 'a' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._a { throw Exception.reason(code: 11, incomplete: false, message: "Illegal value, no 'a' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 12, incomplete: true, message: "Illegal value, missing 'l' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._l { throw Exception.reason(code: 13, incomplete: false, message: "Illegal value, no 'l' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 14, incomplete: true, message: "Illegal value, missing 's' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._s { throw Exception.reason(code: 15, incomplete: false, message: "Illegal value, no 's' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 16, incomplete: true, message: "Illegal value, missing 'e' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._e { throw Exception.reason(code: 17, incomplete: false, message: "Illegal value, no 'e' in 'true' at offset \(offset)") }
        offset += 1
        
        return VJson(false)
    }
    
    
    // Read the last three characters of a "null" value
    
    private static func readNull(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(code: 18, incomplete: true, message: "Illegal value, missing 'u' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._u { throw Exception.reason(code: 19, incomplete: false, message: "Illegal value, no 'u' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 20, incomplete: true, message: "Illegal value, missing 'l' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._l { throw Exception.reason(code: 21, incomplete: false, message: "Illegal value, no 'l' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(code: 22, incomplete: true, message: "Illegal value, missing 'l' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._l { throw Exception.reason(code: 23, incomplete: false, message: "Illegal value, no 'l' in 'true' at offset \(offset)") }
        offset += 1
        
        return VJson.null()
    }
    
    
    // Read the next characters as a string, ends with non-escaped double quote
    
    private static func readString(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(code: 24, incomplete: true, message: "Missing end of string at end of buffer") }
        
        var strbuf = Array<UInt8>()
        
        var stringEnd = false
        
        while !stringEnd {
            
            if buffer[offset] == Ascii._DOUBLE_QUOTES {
                stringEnd = true
            } else {
                
                if buffer[offset] == Ascii._BACKSLASH {
                    
                    offset += 1
                    if offset >= numberOfBytes { throw Exception.reason(code: 25, incomplete: true, message: "Missing end of string at end of buffer") }
                    
                    switch buffer[offset] {
                    case Ascii._DOUBLE_QUOTES, Ascii._BACKWARD_SLASH, Ascii._FOREWARD_SLASH: strbuf.append(buffer[offset])
                    case Ascii._b: strbuf.append(Ascii._BACKSPACE)
                    case Ascii._f: strbuf.append(Ascii._FORMFEED)
                    case Ascii._n: strbuf.append(Ascii._NEWLINE)
                    case Ascii._r: strbuf.append(Ascii._CARRIAGE_RETURN)
                    case Ascii._t: strbuf.append(Ascii._TAB)
                    case Ascii._u:
                        strbuf.append(buffer[offset])
                        offset += 1
                        if offset >= numberOfBytes { throw Exception.reason(code: 26, incomplete: true, message: "Missing second byte after \\u in string") }
                        strbuf.append(buffer[offset])
                        offset += 1
                        if offset >= numberOfBytes { throw Exception.reason(code: 27, incomplete: true, message: "Missing third byte after \\u in string") }
                        strbuf.append(buffer[offset])
                        offset += 1
                        if offset >= numberOfBytes { throw Exception.reason(code: 28, incomplete: true, message: "Missing fourth byte after \\u in string") }
                        strbuf.append(buffer[offset])
                    default:
                        throw Exception.reason(code: 29, incomplete: false, message: "Illegal character after \\ in string")
                    }
                    
                } else {
                    
                    strbuf.append(buffer[offset])
                }
            }
            
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(code: 30, incomplete: true, message: "Missing end of string at end of buffer") }
        }
        
        if let str: String = String(bytes: strbuf, encoding: String.Encoding.utf8) {
            return VJson(str)
        } else {
            throw Exception.reason(code: 31, incomplete: false, message: "NSUTF8StringEncoding conversion failed at offset \(offset - 1)")
        }
    }
    
    private static func readNumber(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        var numbuf = Array<UInt8>()
        
        // Sign
        if buffer[offset] == Ascii._MINUS {
            numbuf.append(buffer[offset])
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(code: 32, incomplete: true, message: "Missing number at end of buffer") }
        }
        
        // First digit series
        if buffer[offset].isAsciiNumber {
            while buffer[offset].isAsciiNumber {
                numbuf.append(buffer[offset])
                offset += 1
                // If the original string is a fraction, it could end right after the number
                if offset >= numberOfBytes {
                    if let numstr = String(bytes: numbuf, encoding: String.Encoding.utf8) {
                        if let double = toDouble(numstr) {
                            return VJson(double)
                        } else {
                            throw Exception.reason(code: 33, incomplete: false, message: "Could not convert to double at end of buffer") // Probably impossible
                        }
                    } else {
                        throw Exception.reason(code: 34, incomplete: false, message: "NSUTF8StringEncoding conversion failed at end of buffer")
                    }
                }
            }
        } else {
            throw Exception.reason(code: 35, incomplete: false, message: "Illegal character in number at offset \(offset)")
        }
        
        // Fraction
        if buffer[offset] == Ascii._DOT {
            numbuf.append(buffer[offset])
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(code: 36, incomplete: true, message: "Missing digits (expecting fraction) at offset \(offset - 1)") }
            if buffer[offset].isAsciiNumber {
                while buffer[offset].isAsciiNumber {
                    numbuf.append(buffer[offset])
                    offset += 1
                    // If the original string is a fraction, it could end right after the number
                    if offset >= numberOfBytes {
                        if let numstr = String(bytes: numbuf, encoding: String.Encoding.utf8) {
                            if let double = toDouble(numstr) {
                                return VJson(double)
                            } else {
                                throw Exception.reason(code: 37, incomplete: false, message: "Could not convert to double at end of buffer") // Probably impossible
                            }
                        } else {
                            throw Exception.reason(code: 38, incomplete: false, message: "NSUTF8StringEncoding conversion failed at end of buffer")
                        }
                    }
                }
            } else {
                throw Exception.reason(code: 39, incomplete: false, message: "Illegal character in fraction at offset \(offset)")
            }
        }
        
        // Mantissa
        if buffer[offset] == Ascii._e || buffer[offset] == Ascii._E {
            numbuf.append(buffer[offset])
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(code: 40, incomplete: true, message: "Missing mantissa at buffer end") }
            if buffer[offset] == Ascii._MINUS || buffer[offset] == Ascii._PLUS {
                numbuf.append(buffer[offset])
                offset += 1
                if offset >= numberOfBytes { throw Exception.reason(code: 41, incomplete: true, message: "Missing mantissa at buffer end") }
            }
            if buffer[offset].isAsciiNumber {
                while buffer[offset].isAsciiNumber {
                    numbuf.append(buffer[offset])
                    offset += 1
                    if offset >= numberOfBytes { break }
                }
            } else {
                throw Exception.reason(code: 42, incomplete: false, message: "Illegal character in mantissa at offset \(offset)")
            }
        }
        
        // Number completed
        
        if let numstr = String(bytes: numbuf, encoding: String.Encoding.utf8) {
            return VJson((toDouble(numstr) ?? Double(0.0)))
        } else {
            throw Exception.reason(code: 43, incomplete: false, message: "NSUTF8StringEncoding conversion failed for number ending at offset \(offset - 1)")
        }
        
    }
    
    private static func readArray(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
        
        if offset >= numberOfBytes { throw Exception.reason(code: 44, incomplete: true, message: "Missing array end at end of buffer") }
        
        
        let result = VJson(type: .array, name: nil)
        
        
        // Index points at value or end-of-array bracket
        
        if buffer[offset] == Ascii._SQUARE_BRACKET_CLOSE {
            offset += 1
            return result
        }
        
        
        // The offset should point at a value
        
        while offset < numberOfBytes {
            
            let value = try readValue(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            // Value received, walk to the next "]" or "," or end of json
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(code: 45, incomplete: true, message: "Missing array end at end of buffer") }
            
            if buffer[offset] == Ascii._COMMA {
                result.append(value)
                offset += 1
            } else if buffer[offset] == Ascii._SQUARE_BRACKET_CLOSE {
                offset += 1
                result.append(value)
                return result
            } else {
                throw Exception.reason(code: 58, incomplete: false, message: "Expected comma or end-of-array bracket")
            }
        }
        
        throw Exception.reason(code: 46, incomplete: true, message: "Missing array end at end of buffer")
    }
    
    
    // The value should never return an .ERROR type. If an error occured it should be reported through the errorString and errorReason.
    
    private static func readValue(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
        
        if offset >= numberOfBytes { throw Exception.reason(code: 47, incomplete: true, message: "Missing value at end of buffer") }
        
        
        // index points at non-whitespace
        
        var val: VJson
        
        switch buffer[offset] {
            
        case Ascii._BRACE_OPEN:
            offset += 1
            val = try readObject(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._SQUARE_BRACKET_OPEN:
            offset += 1
            val = try readArray(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._DOUBLE_QUOTES:
            offset += 1
            val = try readString(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._MINUS:
            val = try readNumber(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._0...Ascii._9:
            val = try readNumber(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._n:
            offset += 1
            val = try readNull(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._f:
            offset += 1
            val = try readFalse(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._t:
            offset += 1
            val = try readTrue(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        default: throw Exception.reason(code: 48, incomplete: false, message: "Illegal character at start of value at offset \(offset)")
        }
        
        return val
    }
    
    private static func readObject(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
        
        if offset >= numberOfBytes { throw Exception.reason(code: 49, incomplete: true, message: "Missing object end at end of buffer") }
        
        
        // Result object
        
        let result = VJson(type: .object, name: nil)
        
        
        // Index points at non-whitespace
        
        if buffer[offset] == Ascii._BRACE_CLOSE {
            offset += 1
            return result
        }
        
        
        // Add name/value pairs
        
        while offset < numberOfBytes {
            
            
            // The offset should point at "
            
            var name: String
            
            if buffer[offset] == Ascii._DOUBLE_QUOTES {
                
                offset += 1
                let str = try readString(buffer, numberOfBytes: numberOfBytes, offset: &offset)
                
                if str.type == .string {
                    name = str.string!
                } else {
                    throw Exception.reason(code: 50, incomplete: false, message: "Programming error")
                }
                
            } else {
                throw Exception.reason(code: 51, incomplete: false, message: "Expected double quotes of name in name/value pair at offset \(offset)")
            }
            
            
            // The colon is next
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(code: 52, incomplete: true, message: "Missing ':' in name/value pair at offset \(offset - 1)") }
            
            if buffer[offset] != Ascii._COLON {
                throw Exception.reason(code: 53, incomplete: false, message: "Missing ':' in name/value pair at offset \(offset)")
            }
            
            offset += 1 // Consume the ":"
            
            
            // A value should be next
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(code: 54, incomplete: true, message: "Missing value of name/value pair at buffer end") }
            
            let val = try readValue(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            
            // Add the name/value pair to this object
            
            val.name = name
            result.add(val, for: name, replace: false)
            
            
            // A comma or brace end should be next
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(code: 55, incomplete: true, message: "Missing end of object at buffer end") }
            
            if buffer[offset] == Ascii._BRACE_CLOSE {
                offset += 1
                return result
            }
            
            if buffer[offset] != Ascii._COMMA { throw Exception.reason(code: 56, incomplete: false, message: "Unexpected character, expected comma at offset \(offset)") }
            
            offset += 1 // Consume the ','
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(code: 60, incomplete: true, message: "Missing name/value pair at buffer end") }
        }
        
        throw Exception.reason(code: 57, incomplete: true, message: "Missing name in name/value pair of object at buffer end")
    }
    
    private static func skipWhitespaces(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) {
        
        if offset >= numberOfBytes { return }
        while buffer[offset].isAsciiWhitespace {
            offset += 1
            if offset >= numberOfBytes { break }
        }
    }
}


// MARK: - Auxillary functions

extension VJson {
    
    
    /// Scans a memory area for a JSON formatted message as defined by opening and closing braces. Scanning for the opening brace starts at the first byte. Scanning continues until either the closing brace or the end of the range is encountered. Braces inside strings are not evaluated.
    ///
    /// - Note: This function does not guarantee that the JSON code between the braces is valid JSON code.
    ///
    /// - Note: When a buffer is returned, the start of the buffer is the location of the opening brace, which is not necessarily equal to the start-pointer.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of an area that must be scnanned for a JSON message.
    ///   - count: The number of bytes that must be scanned.
    ///
    /// - Returns: Nil if no (complete) JSON message was found, otherwise an UnsafeBufferPointer covering the area with the JSON message. Note that the bufer is not copied. Hence make sure to process the JSON message before removing or moving the data in that area.
    
    public static func findPossibleJsonCode(start: UnsafeMutableRawPointer, count: Int) -> UnsafeBufferPointer<UInt8>? {
        
        enum ScanPhase { case normal, inString, escaped, hex1, hex2, hex3, hex4 }
        
        var scanPhase: ScanPhase = .normal
        
        var countOpeningBraces = 0
        var countClosingBraces = 0
        
        var bytePtr = start.assumingMemoryBound(to: UInt8.self)
        let pastLastBytePtr = start.assumingMemoryBound(to: UInt8.self).advanced(by: count)
        
        var jsonAreaStart = bytePtr // Any value, will be overwritten on success
        var jsonCount = 0 // Any value, will be overwritten on success
        
        while bytePtr < pastLastBytePtr {
            let byte = bytePtr.pointee
            switch scanPhase {
            case .normal:
                if byte == Ascii._BRACE_OPEN {
                    countOpeningBraces += 1
                    if countOpeningBraces == 1 {
                        jsonAreaStart = bytePtr
                        jsonCount = 0
                    }
                } else if byte == Ascii._BRACE_CLOSE {
                    countClosingBraces += 1
                    if countOpeningBraces == countClosingBraces {
                        jsonCount += 1
                        let jsonBufferArea = UnsafeBufferPointer<UInt8>(start: jsonAreaStart, count: jsonCount)
                        return jsonBufferArea
                    }
                } else if byte == Ascii._DOUBLE_QUOTES {
                    scanPhase = .inString
                }
            case .inString:
                if byte == Ascii._DOUBLE_QUOTES {
                    scanPhase = .normal
                } else if byte == Ascii._BACKWARD_SLASH {
                    scanPhase = .escaped
                }
            case .escaped:
                if byte == Ascii._u {
                    scanPhase = .hex1
                } else {
                    scanPhase = .inString
                }
            case .hex1: scanPhase = .hex2
            case .hex2: scanPhase = .hex3
            case .hex3: scanPhase = .hex4
            case .hex4: scanPhase = .inString
            }
            bytePtr = bytePtr.advanced(by: 1)
            jsonCount += 1
        }
        return nil
    }
}
