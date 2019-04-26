// =====================================================================================================================
//
//  File:       Null.swift
//  Project:    VJson
//
//  Version:    0.16.0
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2019 Marinus van der Lugt, All rights reserved.
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
//  I strongly believe that voluntarism is the way for societies to function optimally. So you can pay whatever you
//  think our code is worth to you.
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
// 0.16.0 - Removed warnings for Swift 5
// 0.15.4 - Improved code clarity of undo/redo
// 0.10.8 - Split off from VJson.swift
//        - Removed 'asNull' definition.
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
