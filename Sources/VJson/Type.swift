// =====================================================================================================================
//
//  File:       Type.swift
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


public extension VJson {
    
    
    /// Set this option to 'true' to help find unwanted type conversions (in the debugging phase?).
    ///
    /// A type conversion occures if -for example- a string is assigned to a JSON item that contains a BOOL. If this flag is set to 'true', such a conversion will result in a fatal error. If this flag is set to 'false', the conversion will happen silently.
    ///
    /// Conversion to and from NULL are always possible, if it is necessary to force a type change irrespective of the value of this flag make two changes, first to NULL then to the desired type.
    
    static var fatalErrorOnTypeConversion = true

    
    /// The JSON types.
    
    enum JType: CustomStringConvertible {
        
        
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
    
    
    /// Raises a fatal error is a type change is not allowed.
    ///
    /// - Parameters:
    ///   - from: The type to change from.
    ///   - to: The type to change to
    ///
    /// - Returns: When the type change is allowed it will return, otherwise a fatal error will be raised.
    
    static func fatalIfTypeChangeNotAllowed(from old: JType, to new: JType) {
        if typeChangeIsAllowed(from: old, to: new) { return }
        fatalError("Type change from \(old) to \(new) is not supported.")
    }
    
    
    /// Checks if a type change is allowed.
    ///
    /// - Parameters:
    ///   - from: The type to change from.
    ///   - to: The type to change to
    ///
    /// - Returns: True when the type change is allowed false otherwise.
    
    static func typeChangeIsAllowed(from old: JType, to new: JType) -> Bool {
        if old == .null { return true }
        if new == .null { return true }
        if old == new { return true }
        return !VJson.fatalErrorOnTypeConversion
    }
}
