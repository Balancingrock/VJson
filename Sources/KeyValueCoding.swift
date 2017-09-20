// =====================================================================================================================
//
//  File:       KeyValueCoding.swift
//  Project:    VJson
//
//  Version:    0.10.8
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Balancingrock/SwifterJSON
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
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

#if os(macOS)

import Foundation
import Cocoa

    
public extension VJson {
    
    
    /// This notification is posted when the value of an item was updated due to a key/value update cycle.
    
    public static let KVO_VALUE_UPDATE = Notification.Name(rawValue: "KVO_ValueUpdateNotification")

    
    /// Create a bool from a string.
    ///
    /// - Parameter str: The string to be converted.
    ///
    /// - Returns: Either 'true', 'false' or nil if the string could not be converted.
    
    private func stringToBool(_ str: String) -> Bool? {
        if str == "0" { return false }
        else if str == "1" { return true }
        else if str.compare("true", options: [.diacriticInsensitive, .caseInsensitive], range: nil, locale: nil) == ComparisonResult.orderedSame { return true }
        else if str.compare("false", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
        else if str.compare("yes", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return true }
        else if str.compare("no", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
        else if str.compare("t", options: [.diacriticInsensitive, .caseInsensitive], range: nil, locale: nil) == ComparisonResult.orderedSame { return true }
        else if str.compare("f", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
        else if str.compare("y", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return true }
        else if str.compare("n", options: [.diacriticInsensitive, .caseInsensitive]) == ComparisonResult.orderedSame { return false }
        else { return nil }
    }
    
    
    /// Converts Any? into a Bool.
    ///
    /// - Parameter any: The value to convert.
    ///
    /// - Returns: Either 'true', 'false' or nil if any could not be converted.
    
    private func boolFromAny(_ any: Any?) -> Bool? {
        if let b = any as? Bool { return b }
        if let n = any as? NSNumber { return n.boolValue }
        if let s = any as? String { return stringToBool(s) }
        if let i = any as? Int { return i == 1 }
        return nil
    }
    
    /// Converts Any? into a NSNumber.
    ///
    /// - Parameter any: The value to convert.
    ///
    /// - Returns: Either 'true', 'false' or nil if any could not be converted.
    
    private func numberFromAny(_ any: Any?) -> NSNumber? {
        if let n = any as? NSNumber { return n }
        if let b = any as? Bool { return NSNumber(value: b) }
        if let i = any as? Int { return NSNumber(value: i) }
        if let s = any as? String { return NSNumber(value: Double(s) ?? 0) }
        return nil
    }
    
    /// Converts Any? into a String.
    ///
    /// - Parameter any: The value to convert.
    ///
    /// - Returns: Either 'true', 'false' or nil if any could not be converted.
    
    private func stringFromAny(_ any: Any?) -> String? {
        if let s = any as? String { return s }
        if let n = any as? NSNumber { return n.description }
        if let b = any as? Bool { return b ? "true" : "false" }
        if let i = any as? Int { return i.description }
        return nil
    }
    
    
    /// Override the KVO 'setValue' to update the members.
    ///
    /// If an update is made, the KVO_VALUE_UPDATE notification is sent for the VJson item that was updated.
    
    public override func setValue(_ value: Any?, forKey key: String) {
        
        let pathKeys = key.components(separatedBy: ".")
        
        if let item = item(at: pathKeys) {
            
            switch item.type {
                
            // While a NULL may be changed into other types, this probably won't ever happen.
            case .null:
                if let b = boolFromAny(value) {
                    item.boolValue = b
                    NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                    return
                    
                } else if let n = numberFromAny(value) {
                    item.numberValue = n
                    NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                    return
                    
                } else if let s = stringFromAny(value) {
                    item.stringValue = s
                    NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                    return
                }
                
            // Update a bool
            case .bool:
                if let b = boolFromAny(value) {
                    item.boolValue = b
                    NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                    return
                }
                
            // Update a number
            case .number:
                if let n = numberFromAny(value) {
                    item.numberValue = n
                    NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                    return
                }
                
            // Update a string
            case .string:
                if let s = stringFromAny(value) {
                    item.stringValue = s
                    NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                    return
                }
                
            // Not supported (yet?)
            case .array, .object: break
            }
        }
        super.setValue(value, forKey: key)
    }
    
    
    /// Retrieves the value from a child item.
    
    public override func value(forKey key: String) -> Any? {
        
        let pathKeys = key.components(separatedBy: ".")
        
        if let item = item(at: pathKeys) {
            switch item.type {
            case .null: return nil
            case .bool: return item.boolValue
            case .number: return item.numberValue
            case .string: return item.stringValue
            case .array, .object: break
            }
        }
        return super.value(forKey: key)
    }
}
    
#endif
