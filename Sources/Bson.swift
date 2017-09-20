// =====================================================================================================================
//
//  File:       Bson.swift
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
//  Copyright:  (c) 2017 Marinus van der Lugt, All rights reserved.
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
//  (It is always a good idea to visit the website/blog/google to ensure that you actually pay me and not some imposter)
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
// History
//
// 0.10.8  - Initial version
//
// =====================================================================================================================
//
// BSON spec from: http://bsonspec.org/spec.html version 1.1, Copied 2017, Jun 23
//
// =====================================================================================================================
//
// The mapping of JSON types to BSON types is as follows:
//
// BSON | JSON
// --------------
// 0x01 | Number if the number is not expressable as an Int64
// 0x02 | String
// 0x03 | Object
// 0x04 | Array
// 0x08 | Bool
// 0x0A | Null
// 0x12 | Number if the number is expressable as an Int64
//
// =====================================================================================================================
//
// BSON spec from: http://bsonspec.org/spec.html version 1.1, Copied 2017, Jun 23
//
//
// Specification Version 1.1
// -------------------------
//
// BSON is a binary format in which zero or more ordered key/value pairs are stored as a single entity. We call this entity a document.
//
// The following grammar specifies version 1.1 of the BSON standard. We've written the grammar using a pseudo-BNF syntax. Valid BSON data is represented by the document non-terminal.
//
// Basic Types
// -----------
//
// The following basic types are used as terminals in the rest of the grammar. Each type must be serialized in little-endian format.
//
// byte         1 byte  (8-bits)
// int32        4 bytes (32-bit signed integer, two's complement)
// int64        8 bytes (64-bit signed integer, two's complement)
// double       8 bytes (64-bit IEEE 754-2008 binary floating point)
// decimal128	16 bytes (128-bit IEEE 754-2008 decimal floating point)
//
// Non-terminals
// -------------
//
// The following specifies the rest of the BSON grammar. Note that quoted strings represent terminals, and should be interpreted with C semantics (e.g. "\x01" represents the byte 0000 0001). Also note that we use the * operator as shorthand for repetition (e.g. ("\x01"*2) is "\x01\x01"). When used as a unary operator, * means that the repetition can occur 0 or more times.
//
// document	::=	int32 e_list "\x00"	(BSON Document. int32 is the total number of bytes comprising the document.)
// e_list	::=	element e_list | ""
// element	::=	"\x01" e_name double	(64-bit binary floating point)
//            |	"\x02" e_name string	(UTF-8 string)
//            |	"\x03" e_name document	(Embedded document)
//            |	"\x04" e_name document	(Array)
//            | "\x05" e_name binary	(Binary data)
//            |	"\x06" e_name       	(Undefined (value) — Deprecated)
//            |	"\x07" e_name (byte*12)	(ObjectId)
//            |	"\x08" e_name "\x00"	(Boolean "false")
//            |	"\x08" e_name "\x01"	(Boolean "true")
//            |	"\x09" e_name int64 	(UTC datetime)
//            |	"\x0A" e_name	        (Null value)
//            | "\x0B" e_name cstring cstring	(Regular expression - The first cstring is the regex pattern, the second is the regex options string. Options are identified by characters, which must be stored in alphabetical order. Valid options are 'i' for case insensitive matching, 'm' for multiline matching, 'x' for verbose mode, 'l' to make \w, \W, etc. locale dependent, 's' for dotall mode ('.' matches everything), and 'u' to make \w, \W, etc. match unicode.)
//            |	"\x0C" e_name string    (byte*12)	(DBPointer — Deprecated)
//            |	"\x0D" e_name string	(JavaScript code)
//            |	"\x0E" e_name string	(Symbol. Deprecated)
//            |	"\x0F" e_name code_w_s	(JavaScript code w/ scope)
//            |	"\x10" e_name int32     (32-bit integer)
//            |	"\x11" e_name uint64	(Timestamp)
//            |	"\x12" e_name int64	    (64-bit integer)
//            |	"\x13" e_name decimal128	(128-bit decimal floating point)
//            |	"\xFF" e_name           (Min key)
//            |	"\x7F" e_name           (Max key)
// e_name	::=	cstring	                (Key name)
// string	::=	int32 (byte*) "\x00"	(String - The int32 is the number of UTF-8 encoded characters + 1 (for the trailing '\x00'))
// cstring	::=	(byte*) "\x00"	        (Zero or more modified UTF-8 encoded characters followed by '\x00'.)
// binary	::=	int32 subtype (byte*)	Binary - The int32 is the number of bytes in the (byte*).
// subtype	::=	"\x00"                  Generic binary subtype
//            |	"\x01"                  Function
//            |	"\x02"                  Binary (Old)
//            |	"\x03"                  UUID (Old)
//            |	"\x04"                  UUID
//            |	"\x05"                  MD5
//            |	"\x80"                  User defined
// code_w_s	::=	int32 string document	Code w/ scope
//
// Array - The document for an array is a normal BSON document with integer values for the keys, starting with 0 and continuing sequentially. For example, the array ['red', 'blue'] would be encoded as the document {'0': 'red', '1': 'blue'}. The keys must be in ascending numerical order.
// UTC datetime - The int64 is UTC milliseconds since the Unix epoch.
// Timestamp - Special internal type used by MongoDB replication and sharding. First 4 bytes are an increment, second 4 are a timestamp.
// Min key - Special type which compares lower than all other possible BSON element values.
// Max key - Special type which compares higher than all other possible BSON element values.
// Generic binary subtype - This is the most commonly used binary subtype and should be the 'default' for drivers and tools.
// The BSON "binary" or "BinData" datatype is used to represent arrays of bytes. It is somewhat analogous to the Java notion of a ByteArray. BSON binary values have a subtype. This is used to indicate what kind of data is in the byte array. Subtypes from zero to 127 are predefined or reserved. Subtypes from 128-255 are user-defined.
//      \x02 Binary (Old) - This used to be the default subtype, but was deprecated in favor of \x00. Drivers and tools should be sure to handle \x02 appropriately. The structure of the binary data (the byte* array in the binary non-terminal) must be an int32 followed by a (byte*). The int32 is the number of bytes in the repetition.
//      \x03 UUID (Old) - This used to be the UUID subtype, but was deprecated in favor of \x04. Drivers and tools for languages with a native UUID type should handle \x03 appropriately.
//      \x80-\xFF "User defined" subtypes. The binary data can be anything.
// Code w/ scope - The int32 is the length in bytes of the entire code_w_s value. The string is JavaScript code. The document is a mapping from identifiers to values, representing the scope in which the string should be evaluated.
// =====================================================================================================================

import Foundation
import BRUtils


fileprivate let intSet = CharacterSet.init(charactersIn: "cislqCISL") // Note: "unsigned long long", i.e. UInt64 is not included


public extension VJson {
    
    
    /// Returns the BSON code describing this item's hierarchy.
    ///
    // - Note: The JSON NUMBER type is stored either as Double or Int. The Int will in have the resolution of an Int64. This range is smaller than the JSON NUMBER range, even if the JSON NUMBER range is in fact limited by the UInt64.
    
    public var bson: Data {
        
        var bytes = Data()
        
        
        // Type determines the representation
        
        switch self.type {
        case .null:
            
            // A null bson
            bytes.append(UInt8(0x0A))
            
            // BSON e_name
            if let name = name { bytes.append(name) }
            bytes.append(UInt8(0))  // End of string marker
            return bytes
            
            
        case .bool:
            
            // If the bool is nil, return a null BSON instead
            
            if bool == nil {
                
                bytes.append(UInt8(0x0A))
                
                // BSON e_name
                if let name = name { bytes.append(name) }
                bytes.append(UInt8(0))  // End of string marker
                
            } else {
                
                // BSON type
                bytes.append(UInt8(0x08))
                
                // BSON e_name
                if let name = name { bytes.append(name) }
                bytes.append(UInt8(0))  // End of string marker
                
                // Bool value
                bytes.append(bool!)
            }
            
            return bytes
            
            
        case .number:
            
            var nd: Double?
            var ni: Int64?
            
            // If the bool is nil, return a null BSON instead
            if let n = number {
                
                // Create an integer or a double depending on the type inside the NSNumber
                guard let cType: UnicodeScalar = UnicodeScalar(Int(n.objCType.pointee)) else {
                    assert(false, "Cannot convert NSNumber cType to unicode scalar")
                    fatalError("Cannot convert NSNumber cType to unicode scalar")
                }
                
                if intSet.contains(cType) {
                    ni = Int64.clamped(n)
                } else {
                    nd = n.doubleValue
                }
            }
            
            if let d = nd {
                
                // Start a BSON Double
                bytes.append(UInt8(0x01))
                
                // BSON e_name
                if let name = name { bytes.append(name) }
                bytes.append(UInt8(0))  // End of string marker
                
                // Add the double
                bytes.append(d)
                
            } else if let i = ni {
                
                // Start a BSON Int64
                bytes.append(UInt8(0x12))
                
                // BSON e_name
                if let name = name { bytes.append(name) }
                bytes.append(UInt8(0))  // End of string marker
                
                // Add the int64
                bytes.append(i)
                
            } else {
                
                // A null bson
                bytes.append(UInt8(0x0A))
                
                // The bson name
                if let name = name { bytes.append(name) }
                bytes.append(UInt8(0))  // End of string marker
            }
            
            return bytes
            
            
        case .string:
            
            guard let str = string else {
                
                // A null bson
                bytes.append(UInt8(0x0A))
                
                // The bson name
                if let name = name { bytes.append(name) }
                bytes.append(UInt8(0))  // End of string marker
                return bytes
            }
            
            // Start a BSON Int64
            bytes.append(UInt8(0x02))
            
            // BSON e_name
            if let name = name { bytes.append(name) }
            bytes.append(UInt8(0))  // End of string marker
            
            // Add the string
            let i32length = Int32(str.utf8.count)
            bytes.append(i32length)
            bytes.append(str)
            bytes.append(UInt8(0))  // End of string marker
            return bytes
            
            
        case .array:
            
            // A array bson
            bytes.append(UInt8(0x04))
            
            // The bson name
            if let name = name { bytes.append(name) }
            bytes.append(UInt8(0))  // End of string marker
            
            // The contained document
            var document = Data()
            children!.items.forEach {
                document.append($0.bson)
            }
            bytes.append(Int32(document.count + 5))
            bytes.append(document)
            bytes.append(UInt8(0x00))
            
            return bytes
            
            
        case .object:
            
            // A document bson
            bytes.append(UInt8(0x03))
            
            // The bson name
            if let name = name { bytes.append(name) }
            bytes.append(UInt8(0))  // End of string marker
            
            // The contained document
            var document = Data()
            children!.items.forEach {
                document.append($0.bson)
            }
            bytes.append(Int32(document.count + 5))
            bytes.append(document)
            bytes.append(UInt8(0x00))
            
            return bytes
        }
    }
    
    public convenience init?(bson: inout Data, onError: ((String) -> Void)? = nil) {
        
        // Self must be an object when initiatialised from a bson item
        self.init(type: JType.object)
        
        
        // The length of the document
        guard
            var docSize = bson.removeFirstInt32(),
            Int(docSize) >= bson.count
            else { return nil }
        
        // Subtract the size of the first integer
        docSize -= 4
        
        // Loop until empty (keep in mind the closing 0 at the end of the document)
        while docSize > 1 {
            
            if let typeIndicator = bson.removeFirstUInt8() {
                
                switch typeIndicator {
                    
                case 0x01: // Double
                    let theName = bson.removeFirstUtf8CString()
                    if let theDouble = bson.removeFirstDouble() {
                        let json = VJson.init(theDouble, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x02: // String
                    let theName = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirstInt32()
                    if let theString = bson.removeFirstUtf8CString() {
                        let json = VJson.init(theString, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x03: // Object
                    let theName = bson.removeFirstUtf8CString()
                    if let object = VJson(bson: &bson) {
                        self.add(object, for: theName, replace: false)
                    }
                    
                    
                case 0x04: // Array
                    let theName = bson.removeFirstUtf8CString()
                    if let object = VJson(bson: &bson) {
                        object.objectToArray()
                        self.add(object, for: theName, replace: false)
                    }
                    
                    
                case 0x05: // Binary (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    if let size = bson.removeFirstInt32() {
                        let _ = bson.removeFirstUInt8()
                        let _ = bson.removeFirst(Int(size))
                    }
                    
                    
                case 0x06: // Undefined (depricated, not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    
                    
                case 0x07: // ObjectId (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirst(12)
                    
                    
                case 0x08: // Bool
                    let theName = bson.removeFirstUtf8CString()
                    if let theBool = bson.removeFirstBool() {
                        let json = VJson.init(theBool, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x09: // UTC datetime (mapped to UInt64)
                    let theName = bson.removeFirstUtf8CString()
                    if let theUInt64 = bson.removeFirstUInt64() {
                        let json = VJson.init(theUInt64, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x0A: // Null
                    let theName = bson.removeFirstUtf8CString()
                    let json = VJson.null(theName)
                    self.add(json)
                    
                    
                case 0x0B: // Regex (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirstUtf8CString()
                    
                    
                case 0x0C: // DBPointer (depricated, not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirstInt32()
                    let _ = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirst(12)
                    
                    
                case 0x0D: // Javascript code (mapped to string)
                    let theName = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirstInt32()
                    if let theString = bson.removeFirstUtf8CString() {
                        let json = VJson.init(theString, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x0E: // Symbol (mapped to string)
                    let theName = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirstInt32()
                    if let theString = bson.removeFirstUtf8CString() {
                        let json = VJson.init(theString, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x0F: // Javascript code with scope (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    if let size = bson.removeFirstInt32(), size > 4 {
                        let _ = bson.removeFirst(Int(size - 4))
                    }
                    
                    
                case 0x10: // Int32
                    let theName = bson.removeFirstUtf8CString()
                    if let theInt32 = bson.removeFirstInt32() {
                        let json = VJson.init(theInt32, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x11: // Timestamp (mapped to UInt64)
                    let theName = bson.removeFirstUtf8CString()
                    if let theUInt64 = bson.removeFirstUInt64() {
                        let json = VJson.init(theUInt64, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x12: // Int64
                    let theName = bson.removeFirstUtf8CString()
                    if let theInt64 = bson.removeFirstInt64() {
                        let json = VJson.init(theInt64, name: theName)
                        self.add(json)
                    }
                    
                    
                case 0x13: // 128-bit decimal floating point (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    let _ = bson.removeFirst(16)
                    
                    
                case 0xFF: // Min Key (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    
                    
                case 0x7F: // Max Key (not supported, skipped)
                    let _ = bson.removeFirstUtf8CString()
                    
                    
                default: return nil
                }
                
            } else {
                
                return nil
            }
        }
        
        // There should be a closing zero
        if let zero = bson.removeFirstUInt8(), zero == 0 { return }
        
        // Error
        return nil
    }
}
