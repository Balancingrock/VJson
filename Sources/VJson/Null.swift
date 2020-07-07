// =====================================================================================================================
//
//  File:       Null.swift
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
    
    
    /// Creates a VJson item containing a JSON NULL.
    ///
    /// - Parameter name: The name for this item (optional)
    ///
    /// - Returns: A new VJson item containing a NULL.
    
    static func null(_ name: String? = nil) -> VJson {
        return VJson(type: .null, name: name)
    }

    
    /// True if this object contains a JSON NULL object.
    
    var isNull: Bool { return self.type == .null }

    
    /// True if this item contains a JSON NULL, nil otherwise. Note that conversions to and from NULL are always allowed.
    
    var nullValue: Bool? {
        get { return type == .null ? true : nil }
        set { type = .null }
    }
}
