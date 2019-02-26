// =====================================================================================================================
//
//  File:       String.swift
//  Project:    VJson
//
//  Version:    0.15.4
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
// 0.15.4 - Improved code clarity of undo/redo
// 0.13.0  - Improved support for unicode and escape sequences.
// 0.12.7  - Fixed bug on asString assignment for Bool.
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

import Foundation
import BRUtils


public extension VJson {
    
    
    /// The Swift string value if this is a JSON STRING item, nil otherwise.
    ///
    /// - Note: When writing to this variable the string will be scanned for characters that need an escape sequence, when found, such characters will be replaced by their escape sequence.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non string will result in a fatal error.
    
    public var stringValue: String? {
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

    public var stringValuePrintable: String? {
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
    
    public var stringValueRaw: String? {
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
    
    public var isString: Bool { return self.type == JType.string }
    
    
    /// The value of this item interpretated as a string.
    ///
    /// NUMBER and BOOL return their string representation. NULL it returns "null" for OBJECT and ARRAY it returns an empty string.
    
    public var asString: String {
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
    
    public convenience init(_ string: String?, name: String? = nil) {
        if let string = string {
            self.init(type: .string, name: name)
            self.string = string.stringToJsonString()
        } else {
            self.init(type: .null, name: name)
        }
    }
}
