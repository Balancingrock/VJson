// =====================================================================================================================
//
//  File:       Name.swift
//  Project:    VJson
//
//  Version:    0.15.3
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2018 Marinus van der Lugt, All rights reserved.
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
// 0.15.3  - Improved documentation
//           Reimplemented undo/redo
//           Harmonized value accessors
// 0.13.3  - Fixed problem with undo support for name changes of a child
// 0.13.0  - Improved unicode character support.
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

import Foundation
import Ascii


public extension VJson {
    
    
    /// The name of this item as a Swift string with the escape sequences replaced by their proper characters.
    ///
    /// This accessor will not generate illegal names and should be the preffered method when changing the name.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence.
    
    public var nameValue: String? {
        get { return name?.jsonStringToString() }
        set { nameValueRaw = newValue?.stringToJsonString()}
    }
    
    
    /// The name of this item as a string if there is any, the escape sequences are replaced by printables.
    ///
    /// This accessor is intended as read-only. While it can be used to set a new name value this is discouraged due to possible changes to the lookup tables that are used for the conversion.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence. Printables will also be converted (back) into their escape sequence.

    public var nameValuePrintable: String? {
        get { return name?.jsonStringToString(lut: printableJsonStringSequenceLUT) }
        set { nameValueRaw = newValue?.stringToJsonString(lut: printableJsonStringSequenceLUT) }
    }
    
    
    /// The raw name of this object as a sequence of single byte UTF8 characters.
    ///
    /// - Warning: When this accessor is used for writing no error's will be flagged for illegal JSON strings!
    ///
    /// - Note: This is the raw data as received/read or stored/transmitted. Complete with escape sequences.
    
    public var nameValueRaw: String? {
        get { return name }
        set {
            if let newName = newValue {
                if newName != name {
                    name = newName
                }
            } else {
                if let parent = parent, parent.isObject {
                    // Cannot remove name
                } else {
                    name = nil
                }
            }
        }
    }
    
    
    /// True if this object is a name/value pair. False otherwise.
    
    public var hasName: Bool { return name != nil }
}
