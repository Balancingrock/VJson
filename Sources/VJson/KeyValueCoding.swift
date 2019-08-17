// =====================================================================================================================
//
//  File:       KeyValueCoding.swift
//  Project:    VJson
//
//  Version:    1.0.0
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
// 1.0.0 - Removed older history
// =====================================================================================================================

#if os(macOS)

import Foundation
import Cocoa

    
public extension VJson {
    
    
    /// This notification is posted when the value of an item was updated due to a key/value update cycle.
    
    static let KVO_VALUE_UPDATE = Notification.Name(rawValue: "KVO_ValueUpdateNotification")

    
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
    
    
    ///
    
    func setValueFromAny(_ value: Any?) -> Bool {
        
        switch type {
            
        // While a NULL may be changed into other types, this probably won't ever happen.
        case .null:
            if let b = boolFromAny(value) {
                boolValue = b
                return true
                
            } else if let n = numberFromAny(value) {
                numberValue = n
                return true
                
            } else if let s = stringFromAny(value) {
                stringValue = s
                return true
            }
            
        // Update a bool
        case .bool:
            if let b = boolFromAny(value) {
                boolValue = b
                return true
            }
            
        // Update a number
        case .number:
            if let n = numberFromAny(value) {
                numberValue = n
                return true
            }
            
        // Update a string
        case .string:
            if let s = stringFromAny(value) {
                stringValue = s
                return true
            }
            
        // Not supported (yet?)
        case .array, .object:
            break
        }
        
        return false
    }
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        let pathKeys = key.stringToJsonString().components(separatedBy: ".")
        
        if let item = item(at: pathKeys) {
            
            if item.setValueFromAny(value) {
                NotificationCenter.default.post(name: VJson.KVO_VALUE_UPDATE, object: item)
                return
            }
        }
        super.setValue(value, forKey: key)
    }
    
    
    override func value(forKey key: String) -> Any? {
        
        let pathKeys = key.stringToJsonString().components(separatedBy: ".")
        
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
