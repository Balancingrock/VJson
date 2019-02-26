// =====================================================================================================================
//
//  File:       Number.swift
//  Project:    VJson
//
//  Version:    0.15.4
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
// 0.15.4 - Improved code clarity of undo/redo
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

import Foundation


fileprivate extension NSNumber {
    
    convenience init?(value: Int?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }
    
    convenience init?(value: Int8?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }

    convenience init?(value: Int16?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }

    convenience init?(value: Int32?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }

    convenience init?(value: Int64?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }

    convenience init?(value: UInt?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }
    
    convenience init?(value: UInt8?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }
    
    convenience init?(value: UInt16?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }
    
    convenience init?(value: UInt32?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }
    
    convenience init?(value: UInt64?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }

    convenience init?(value: Double?) {
        guard let value = value else { return nil }
        self.init(value: value)
    }
}

public extension VJson {
    
    /// The number as an NSNumber if this is a JSON NUMBER item, nil otherwise.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var numberValue: NSNumber? {
        get { return number?.copy() as? NSNumber }
        set {
            if let newValue = newValue {
                if type != .number { type = .number }
                number = newValue.copy() as? NSNumber
            } else {
                type = .null
            }
        }
    }
    
    
    /// True if this object contains a JSON NUMBER object.
    ///
    /// - Note: If the Apple Parser was used, all JSON bools will have been converted into a NUMBER.
    
    public var isNumber: Bool { return self.type == JType.number }
    
    
    /// The value of this item interpretated as a number.
    ///
    /// For a NUMBER it returns a copy of that number, for NULL, OBJECT and ARRAY it returns a NSNumber with the value 0, for STRING it tries to read the string as a number (if that fails, it is regarded as a zero) and for a BOOL it creates a NSNumber with the bool as its value.
    
    public var asNumber: NSNumber {
        switch type {
        case .null, .object, .array: return NSNumber(value: 0)
        case .bool:   return NSNumber(value: self.bool ?? false)
        case .number: return numberValue ?? NSNumber(value: 0)
        case .string: return NSNumber(value: Double(string ?? "0") ?? 0)
        }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var intValue: Int? {
        get { return number?.intValue }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int8Value: Int8? {
        get { return number?.int8Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int16Value: Int16? {
        get { return number?.int16Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int32Value: Int32? {
        get { return number?.int32Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var int64Value: Int64? {
        get { return number?.int64Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uintValue: UInt? {
        get { return number?.uintValue }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint8Value: UInt8? {
        get { return number?.uint8Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint16Value: UInt16? {
        get { return number?.uint16Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint32Value: UInt32? {
        get { return number?.uint32Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var uint64Value: UInt64? {
        get { return number?.uint64Value }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// The integer value of this item interpretated as a number.
    ///
    /// For a NUMBER it returns the integer value of that number, for NULL, OBJECT and ARRAY it returns 0, for STRING it tries to read the string as a number (if that fails, it is regarded as a zero) and for a BOOL it is either 0 or 1.
    
    public var asInt: Int {
        return asNumber.intValue
    }
    
    
    /// Convenience accessor if this item is a JSON NUMBER.
    ///
    /// If the VJson.fatalErrorOnTypeConversion is set to 'true' (default) then assigning a non number will result in a fatal error.
    
    public var doubleValue: Double? {
        get { return number?.doubleValue }
        set { numberValue = NSNumber(value: newValue) }
    }
    
    
    /// The double value of this item interpretated as a number.
    ///
    /// For a NUMBER it returns the double value of that number, for NULL, OBJECT and ARRAY it returns 0, for STRING it tries to read the string as a number (if that fails, it is regarded as a zero) and for a BOOL it is either 0 or 1.
    
    public var asDouble: Double {
        return asNumber.doubleValue
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int8?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt8?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int16?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt16?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int32?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt32?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Int64?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: UInt64?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Float?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given value is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(_ value: Double?, name: String? = nil) {
        if let value = value {
            self.init(type: .number, name: name)
            number = NSNumber(value: value)
        } else {
            self.init(type: .null, name: name)
        }
    }
    
    
    /// Creates a new VJson item with a JSON NUMBER with the given value. If the given number is a nil, a JSON NULL is created.
    ///
    /// - Parameters:
    ///   - value: The value for the new item.
    ///   - name: The name for the value (optional).
    
    public convenience init(number: NSNumber?, name: String? = nil) {
        if let number = number {
            self.init(type: .number, name: name)
            self.number = (number.copy() as! NSNumber)
        } else {
            self.init(type: .null, name: name)
        }
    }
}
