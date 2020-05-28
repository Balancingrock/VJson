// =====================================================================================================================
//
//  File:       String.swift
//  Project:    VJson
//
//  Version:    1.2.2
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2020 Marinus van der Lugt, All rights reserved.
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
//  Like you, I need to make a living:
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
// 1.2.2 - Made stringValueRaw fileprivate
// 1.0.0 - Removed older history
// =====================================================================================================================

import Foundation
import BRUtils


public extension VJson {
    
    
    /// The Swift string value if this is a JSON STRING item, nil otherwise.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non string will result in a fatal error.
    
    var stringValue: String? {
        get {
            return self.string?.jsonStringToString()
        }
        set {
            if let newValue = newValue {
                if type != .string { type = .string }
                let jstr = newValue.stringToJsonString()
                string = jstr
            } else {
                type = .null
            }
        }
    }
    
    
    /// The string value if this is a JSON STRING item, nil otherwise. The string will contain only printable characters, escape sequences are replaced by their printable equivalent.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence. Printables will also be converted (back) into their escape sequence.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non string will result in a fatal error.

    var stringValuePrintable: String? {
        get {
            return self.string?.jsonStringToString(lut: printableJsonStringSequenceLUT)
        }
        set {
            if let newValue = newValue {
                if type != .string { type = .string }
                let jstr = newValue.stringToJsonString(lut: printableJsonStringSequenceLUT)
                string = jstr
            } else {
                type = .null
            }
        }
    }
    
    
    /// The raw string value as read/received or written/transferred. A sequence of single byte UTF8 characters. Escape sequences are not replaced by their escaped characters on neither read nor write.
    
    fileprivate var stringValueRaw: String? {
        get { return string }
        set {
            if let newValue = newValue {
                if type != .string { type = .string }
                string = newValue
            } else {
                type = .null
            }
        }
    }
    
    
    /// True if this object contains a JSON STRING object.
    
    var isString: Bool { return self.type == JType.string }
    
    
    /// The value of this item interpretated as a string.
    ///
    /// NUMBER and BOOL return their string representation. NULL it returns "null" for OBJECT and ARRAY it returns an empty string.
    
    var asString: String {
        get {
            switch type {
            case .null: return "null"
            case .bool: return bool == nil ? "null" : "\(bool ?? false)"
            case .string: return stringValue ?? "null"
            case .number: return number == nil ? "null" : (number ?? NSNumber(value: 0)).stringValue
            case .array, .object: return ""
            }
        }
        set {
            switch type {
            case .null, .array, .object: break
            case .bool: boolValue = Bool(lettersOrDigits: newValue) ?? false
            case .string: stringValue = newValue.stringToJsonString()
            case .number: numberValue = NSNumber.factory(boolIntDouble: newValue)
            }
        }
    }
    
    
    /// Creates a new VJson item with a JSON STRING with the given value. If the given string is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item, note that the string will be converted into a JSON escaped string. I.e. all characters that must be escaped will be converted into their escaped sequences.
    ///   - name: The name for the value (optional).
    
    convenience init(_ string: String?, name: String? = nil) {
        if let string = string {
            self.init(type: .string, name: name)
            self.string = string.stringToJsonString()
        } else {
            self.init(type: .null, name: name)
        }
    }
}
