// =====================================================================================================================
//
//  File:       Type.swift
//  Project:    VJson
//
//  Version:    0.15.3
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
// 0.15.4 - Removed operations 'changeType and undoableUpdate
// 0.15.3 - Reimplemented undo/redo
// 0.11.2 - Added changeType:to
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Set this option to 'true' to help find unwanted type conversions (in the debugging phase?).
    ///
    /// A type conversion occures if -for example- a string is assigned to a JSON item that contains a BOOL. If this flag is set to 'true', such a conversion will result in a fatal error. If this flag is set to 'false', the conversion will happen silently.
    ///
    /// Conversion to and from NULL are always possible, if it is necessary to force a type change irrespective of the value of this flag make two changes, first to NULL then to the desired type.
    
    public static var fatalErrorOnTypeConversion = true

    
    /// The JSON types.
    
    public enum JType: CustomStringConvertible {
        
        
        /// A JSON NULL
        
        case null
        
        
        /// A JSON BOOL
        
        case bool
        
        
        /// A JSON NUMBER
        
        case number
        
        
        /// A JSON STRING
        
        case string
        
        
        /// A JSON OBJECT
        
        case object
        
        
        /// A JSON ARRAY
        
        case array
        
        
        /// Return the string for the case
        ///
        /// Note: This approach has a slight performance edge over 'enum JType: String'
        
        public var description: String {
            switch self {
            case .null: return "Null"
            case .bool: return "Bool"
            case .number: return "Number"
            case .string: return "String"
            case .object: return "Object"
            case .array: return "Array"
            }
        }
    }
    
    
    /// Raises a fatal error is a type change is not allowed.
    ///
    /// - Parameters:
    ///   - from: The type to change from.
    ///   - to: The type to change to
    ///
    /// - Returns: When the type change is allowed it will return, otherwise a fatal error will be raised.
    
    public static func fatalIfTypeChangeNotAllowed(from old: JType, to new: JType) {
        if typeChangeIsAllowed(from: old, to: new) { return }
        fatalError("Type change from \(old) to \(new) is not supported.")
    }
    
    
    /// Checks if a type change is allowed.
    ///
    /// - Parameters:
    ///   - from: The type to change from.
    ///   - to: The type to change to
    ///
    /// - Returns: True when the type change is allowed false otherwise.
    
    public static func typeChangeIsAllowed(from old: JType, to new: JType) -> Bool {
        if old == .null { return true }
        if new == .null { return true }
        if old == new { return true }
        return !VJson.fatalErrorOnTypeConversion
    }
}
