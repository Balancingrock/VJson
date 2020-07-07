// =====================================================================================================================
//
//  File:       Bool.swift
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
    

    /// Accessor for the bool value of this object if the type is a JSON BOOL value. Nil otherwise.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non BOOL will result in a fatal error.
    
    var boolValue: Bool? {
        get { return bool }
        set {
            if let newValue = newValue {
                if type != .bool { type = .bool }
                bool = newValue
            } else {
                type = .null
            }
        }
    }
    
    
    /// True if this object contains a JSON BOOL object.
    ///
    /// - Note: If the Apple Parser was used, all JSON BOOLs will have been converted into a NUMBER. In that case use 'asBool' instead.
    
    var isBool: Bool { return type == .bool }

    
    /// The value of this object interpreted as a bool.
    ///
    /// A NULL reads as false, a NUMBER 0(.0) reads as false, other numbers read as true, STRING "true" reads as true, all other strings read as false. ARRAY and OBJECT both read as false.
    
    var asBool: Bool {
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
    
    convenience init(_ value: Bool?, name: String? = nil) {
        self.init(type: .bool, name: name)
        bool = value
    }
}
