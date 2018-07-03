// =====================================================================================================================
//
//  File:       PipeOperator.swift
//  Project:    VJson
//
//  Version:    0.13.0
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
// 0.13.0  - Added escape sequence support
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

import Foundation


/// Interrogate a JSON object for the existence of a child item with the given name. Has no side effects
///
/// - Parameters:
///   - lhs: The VJson object to interrogate
///   - rhs: The name of the sought after item
///
/// - Returns: Either the sought after item or nil if it does not exist.

public func | (lhs: VJson?, rhs: String?) -> VJson? {
    guard let lhs = lhs else { return nil }
    guard let rhs = rhs?.stringToJsonString() else { return nil }
    if let result = lhs.children?.cached(rhs) {
        return result
    } else {
        let arr = lhs.children(with: rhs)
        if arr.count == 0 { return nil }
        return arr[0]
    }
}


/// Interrogate a JSON object for the existence of a child item at the given index. Has no side effects
///
/// - Parameters:
///   - lhs: The VJson object to interrogate
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

