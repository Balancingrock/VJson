// =====================================================================================================================
//
//  File:       PipeOperator.swift
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


/// Interrogate an item for the existence of an item with a given name. Has no side effects
///
/// - Parameters:
///   - lhs: The item to interrogate
///   - rhs: The name of the sought after item
///
/// - Returns: Either the sought after item or nil if it does not exist.

public func | (lhs: VJson?, rhs: String?) -> VJson? {
    guard let lhs = lhs else { return nil }
    guard let rhs = rhs else { return nil }
    if let result = lhs.children?.cached(rhs.stringToJsonString()) {
        return result
    } else {
        let arr = lhs.items(with: rhs)
        if arr.count == 0 { return nil }
        return arr[0]
    }
}


/// Interrogate an item for the existence of an item at the given index. Has no side effects
///
/// - Parameters:
///   - lhs: The item to interrogate
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

