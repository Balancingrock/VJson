// =====================================================================================================================
//
//  File:       Duplicate.swift
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
// 0.15.0 - Harmonized names, now uses 'item' or 'items' for items contained in OBJECTs instead of 'child'
//          or 'children'. The name 'child' or 'children' is now used exclusively for operations transcending
//          OBJECTs or ARRAYs.
//          General overhaul of comments and documentation.
// 0.11.4 - Added note explaining that the undo manager is not copied
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Returns an in-depth copy of this JSON object as a self contained hierarchy. I.e. all subitems are also copied.
    ///
    /// - Note: The 'parent' of the duplicate will be 'nil'. However the subitems in the duplicate will have the proper 'parent' as necessary for the hierarchy.
    ///
    /// - Note: The undoManager is not copied, set a new undo manager when necessary.
    
    var duplicate: VJson {
        let other = VJson(type: self.type, name: self.name)
        other.type = self.type
        other.bool = self.bool
        other.string = self.string
        other.number = self.numberValue // Creates a copy of the NSNumber
        other.createdBySubscript = self.createdBySubscript
        if children != nil {
            other.children = Children(parent: other)
            other.children!.cacheEnabled = self.children!.cacheEnabled
            for c in self.children!.items {
                _ = other.children!.append(c.duplicate)
            }
        }
        return other
    }
}
