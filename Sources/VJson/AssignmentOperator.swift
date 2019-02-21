// =====================================================================================================================
//
//  File:       AssignmentOperator.swift
//  Project:    VJson
//
//  Version:    0.10.8
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
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
//  (It is always a good idea to check the website http://www.balancingrock.nl before payment)
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
// History
//
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

import Foundation


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
    
    //if llhs.parent != nil {
        // This is a child object, replace it in the parent
        //llhs.replaceSelfInParent(with: rhs)
        //return rhs
    //} else {
        // This is a top level object, change the lhs object into the rhs
        llhs.replaceContent(with: rhs)
        return llhs
    //}
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
        llhs.replaceContent(with: rhs)
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


extension VJson {


    /// Replaces the content of self with the content of the given object, but it does not change the parent reference nor the name of self. The the createdBySubscript will be set to false.
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
    
    
    /// Replaces the content of self with other in the parent of self. The name of self remains unchanged. The parent of other must be nil.
    ///
    /// - Note: A fatalError is raised if a type change is attempeted but not supported.
    ///
    /// - Parameter with other: The VJson object which to replace self with.
    ///
    /// - Returns: True if the operation was sucessful, false otherwise.
    /*
    @discardableResult
    public func replaceSelfInParent(with other: VJson?) -> Bool {
        guard let other = other else { return false }
        guard let parent = self.parent else { return false }
        guard other.parent == nil else { return false }
        VJson.fatalIfTypeChangeNotAllowed(from: self.type, to: other.type)
        var success = false
        for (index, child) in (parent.children?.items ?? []).enumerated() {
            if child === self {
                // other.name = self.name
                //_ = parent.children?.replace(at: index, with: other)
                success = true
                break
            }
        }
        return success
    }*/
}





