// =====================================================================================================================
//
//  File:       Name.swift
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
// 1.2.1 - Made nameValueRaw internal
// 1.0.0 - Removed older history
// =====================================================================================================================

import Foundation
import Ascii


public extension VJson {
    
    
    /// The name of this item as a Swift string with the escape sequences replaced by their proper characters.
    ///
    /// This accessor will not generate illegal names and should be the preffered method when changing the name.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence.
    
    var nameValue: String? {
        get { return name?.jsonStringToString() }
        set { nameValueRaw = newValue?.stringToJsonString()}
    }
    
    
    /// The name of this item as a string if there is any, the escape sequences are replaced by printables.
    ///
    /// This accessor is intended as read-only. While it can be used to set a new name value this is discouraged due to possible changes to the lookup tables that are used for the conversion.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence. Printables will also be converted (back) into their escape sequence.

    var nameValuePrintable: String? {
        get { return name?.jsonStringToString(lut: printableJsonStringSequenceLUT) }
        set { nameValueRaw = newValue?.stringToJsonString(lut: printableJsonStringSequenceLUT) }
    }
    
    
    /// The raw name of this object as a sequence of single byte UTF8 characters.
    ///
    /// - Warning: When this accessor is used for writing no error's will be flagged for illegal JSON strings!
    ///
    /// - Note: This is the raw data as received/read or stored/transmitted. Complete with escape sequences.
    
    fileprivate var nameValueRaw: String? {
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
    
    var hasName: Bool { return name != nil }
}
