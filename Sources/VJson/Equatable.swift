// =====================================================================================================================
//
//  File:       Equatable.swift
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
    
    
    /// Implementation note: does not check the parent or createdBySubscript members.
    
    static func == (lhs: VJson, rhs: VJson) -> Bool {
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
