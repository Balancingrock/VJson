// =====================================================================================================================
//
//  File:       Duplicate.swift
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
