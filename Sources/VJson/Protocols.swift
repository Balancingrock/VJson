// =====================================================================================================================
//
//  File:       Protocols.swift
//  Project:    VJson
//
//  Version:    1.3.4
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2020 Marinus van der Lugt, All rights reserved.
//
//  License:    MIT, see LICENSE file
//
//  And because I need to make a living:
//
//   - You can send payment (you choose the amount) via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  Prices/Quotes for support, modifications or enhancements can be obtained from: rien@balancingrock.nl
//
// =====================================================================================================================
// PLEASE let me know about bugs, improvements and feature requests. (rien@balancingrock.nl)
// =====================================================================================================================
//
// History
//
// 1.3.4 - Updated LICENSE
// 1.0.0 - Removed older history
// =====================================================================================================================

import Foundation


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
