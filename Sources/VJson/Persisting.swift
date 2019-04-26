// =====================================================================================================================
//
//  File:       Persisting.swift
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
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Tries to saves the contents of the JSON hierarchy to the specified file.
    ///
    /// - Parameter to: The URL of the file location where to save this hierarchy.
    ///
    /// - Returns: Nil on success, Error description on fail.
    
    @discardableResult
    func save(to: URL) -> String? {
        let str = self.code
        do {
            try str.write(to: to, atomically: false, encoding: String.Encoding.utf8)
            return nil
        } catch let error as NSError {
            return error.localizedDescription
        }
    }
}
