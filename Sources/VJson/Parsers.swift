// =====================================================================================================================
//
//  File:       Parsers.swift
//  Project:    VJson
//
//  Version:    0.13.2
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
// 0.13.2  - Fixed another bug introduced in 0.13.0 due to support for escape sequences
// 0.13.1  - Fixed a bug introduced in 0.13.0 due to support for escape sequences
// 0.12.8  - Added location to the exception info
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

import Foundation
import Ascii


// MARK: - Creating a VJson hierarchy from json code

public extension VJson {
    
    
    /// A general purpose wrapper for function results that return ParseFunctionResult's
    ///
    /// Recommended use: let json = VJson.parse(data(from: myJsonCode)){ ... error handler ... }
    
    public typealias parseErrorSignature = (_ location: Int, _ code: Int, _ incomplete: Bool, _ message: String) -> Void
    
    
    /// This error type gets thrown if errors are found during parsing.
    ///
    /// - reason: The details of the error.
    
    public enum Exception: Error, CustomStringConvertible {
        
        
        /// The details of the error
        ///
        /// - code: An integer number that references the error location
        /// - incomplete: When true, the error occured because the parser ran out of characters.
        /// - message: A textual description of the error.
        
        case reason(location: Int, code: Int, incomplete: Bool, message: String)
        
        
        /// The textual description of the exception.
        
        public var description: String {
            if case let .reason(location, code, incomplete, message) = self { return "[Location: \(location), Code: \(code), Incomplete:\(incomplete)] \(message)" }
            return "VJson: Error in Exception enum"
        }
    }
    
    
    /// Error info from the parser for the parse operations that do not throw.
    
    public struct ParseError {
        
        
        /// An integer number that references the index of the character that caused the error
        
        public var location: Int
        
        
        /// An integer number that references the error in the parser code
        
        public var code: Int
        
        
        /// When true, the error occured because the parser ran out of characters.
        
        public var incomplete: Bool
        
        
        /// A textual description of the error.
        
        public var message: String
        
        
        /// Create a new ParseError
        ///
        /// - Parameters:
        ///   - code: An integer number that references the error location
        ///   - incomplete: True if the error occured because the parser ran out of characters.
        ///   - message: A textual description of the error.
        
        public init(location: Int, code: Int, incomplete: Bool, message: String) {
            self.location = location
            self.code = code
            self.incomplete = incomplete
            self.message = message
        }
        
        
        /// Creates an empty ParseError
        
        public init() {
            self.init(location: 0, code: -1, incomplete: false, message: "")
        }
        
        
        /// The textual description of the ParseError
        
        public var description: String {
            return "[Location: \(location), Code: \(code), Incomplete:\(incomplete)] \(message)"
        }
    }
    
    
    /// Parsing a JSON hierarchy stored in a file
    ///
    /// - Parameter from: The URL of a file.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(file: URL, onError: parseErrorSignature) -> VJson? {
        do {
            return try parse(file: file)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            onError(location, code, incomplete, message)
            
        } catch let error {
            onError(0, -1, false, "\(error)")
        }
        return nil
    }
    
    
    /// Create a VJson hierarchy from the contents of the given file.
    ///
    /// - Parameter file: The URL that designates the file to be read.
    ///
    /// - Returns: A VJson hierarchy with the contents of the file.
    ///
    /// - Throws: Either an VJson.Error.reason or an NSError if the VJson hierarchy could not be created or the file not be read.
    
    public static func parse(file: URL) throws -> VJson {
        var data = try Data(contentsOf: URL(fileURLWithPath: file.path), options: Data.ReadingOptions.uncached)
        return try vJsonParser(data: &data)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given file.
    ///
    /// - Parameters:
    ///   - file: The URL that designates the file to be read.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(file: URL, errorInfo: inout ParseError?) -> VJson? {
        
        do {
            return try parse(file: file)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            errorInfo?.location = location
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.location = 0
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
    
    
    /// Parsing a JSON hierarchy stored in a buffer
    ///
    /// - Parameter from: The buffer to parse.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(buffer: UnsafeBufferPointer<UInt8>, onError: parseErrorSignature) -> VJson? {
        
        do {
            return try VJson.vJsonParser(buffer: buffer)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            onError(location, code, incomplete, message)
            
        } catch let error {
            onError(0, -1, false, "\(error)")
        }
        return nil
    }
    
    
    /// Create a VJson hierarchy with the contents of the given buffer.
    ///
    /// - Parameters:
    ///   - buffer: The buffer containing the data to be parsed.
    ///
    /// - Returns: A VJson hierarchy with the contents of the buffer.
    ///
    /// - Throws: A VJson.Error.reason if the parsing failed.
    
    public static func parse(buffer: UnsafeBufferPointer<UInt8>) throws -> VJson {
        return try VJson.vJsonParser(buffer: buffer)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given buffer.
    ///
    /// - Parameters
    ///   - buffer: The buffer containing the data to be parsed.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(buffer: UnsafeBufferPointer<UInt8>, errorInfo: inout ParseError?) -> VJson? {
        
        do {
            return try parse(buffer: buffer)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            errorInfo?.location = location
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.location = 0
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
    
    
    /// Parsing a JSON hierarchy stored in a string.
    ///
    /// - Parameter from: The string to parse.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(string: String, onError: parseErrorSignature) -> VJson? {
        do {
            return try VJson.parse(string: string)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            onError(location, code, incomplete, message)
            
        } catch let error {
            onError(0, -1, false, "\(error)")
        }
        return nil
    }
    
    
    /// Create a VJson hierarchy with the contents of the given string.
    ///
    /// - Parameters:
    ///   - string: The string containing the data to be parsed.
    ///
    /// - Returns: A VJson hierarchy with the contents of the buffer.
    ///
    /// - Throws: A VJson.Error.reason if the parsing failed.
    
    public static func parse(string: String) throws -> VJson {
        guard var data = string.data(using: String.Encoding.utf8) else {
            throw VJson.Exception.reason(location: 0, code: 59, incomplete: false, message: "Could not convert string to UTF8")
        }
        return try VJson.vJsonParser(data: &data)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given buffer.
    ///
    /// - Parameters
    ///   - string: The string containing the data to be parsed.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(string: String, errorInfo: inout ParseError?) -> VJson? {
        
        do {
            return try parse(string: string)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            errorInfo?.location = location
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.location = 0
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
    
    
    /// Parsing a JSON hierarchy stored in a Data object
    ///
    /// - Parameter from: The data to parse.
    ///
    /// - Returns: A ParseFunctionResult
    
    public static func parse(data: inout Data, onError: parseErrorSignature) -> VJson? {
        do {
            return try VJson.vJsonParser(data: &data)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            onError(location, code, incomplete, message)
            
        } catch let error {
            onError(0, -1, false, "\(error)")
        }
        return nil
    }
    
    
    /// Create a VJson hierarchy with the contents of the given data object.
    ///
    /// - Parameters:
    ///   - data: The data object containing the data to be parsed.
    ///
    /// - Returns: A VJson hierarchy with the contents of the data object.
    ///
    /// - Throws: A VJson.Error.reason if the parsing failed.
    
    public static func parse(data: inout Data) throws -> VJson {
        return try VJson.vJsonParser(data: &data)
    }
    
    
    /// Create a VJson hierarchy with the contents of the given data object.
    ///
    /// - Parameters
    ///   - data: The data object containing the data to be parsed.
    ///   - errorInfo: A (pointer to a) struct that will contain the error info if an error occured during parsing (i.e. when the result of the function if nil).
    ///
    /// - Returns: On success the VJson hierarchy. On error a nil for the VJson hierarchy and the structure with error information filled in.
    
    public static func parse(data: inout Data, errorInfo: inout ParseError?) -> VJson? {
        do {
            return try VJson.vJsonParser(data: &data)
            
        } catch let .reason(location, code, incomplete, message) as VJson.Exception {
            errorInfo?.location = location
            errorInfo?.code = code
            errorInfo?.incomplete = incomplete
            errorInfo?.message = message
            
        } catch let error {
            errorInfo?.location = 0
            errorInfo?.code = -1
            errorInfo?.incomplete = false
            errorInfo?.message = "\(error)"
        }
        return nil
    }
}


// MARK: - Apple's parser

public extension VJson {
    
    
    /// This parser uses the Apple NSJSONSerialization class to parse the given data.
    ///
    /// - Note: Parser differences: Apple's parser is usually faster (about 2x). However Apple's parser cannot parse multiple key/value pairs with the same name and Apple's parser will create a VJson NUMBER items for BOOL's.
    ///
    /// - Returns: A VJson hierarchy
    ///
    /// - Throws: The error thrown by NSJSONSerialization. Error code 100 should be impossible.
    
    public static func parseUsingAppleParser(_ data: Data) throws -> VJson {
        
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return try getVJsonFrom(json as AnyObject)
    }
    
    private static func getVJsonFrom(_ o: AnyObject) throws -> VJson {
        
        if let str = o as? NSString {
            
            return VJson(str as String)
            
        } else if let num = o as? NSNumber {
            
            return VJson(number: num)
            
        } else if o is NSNull {
            
            return VJson.null()
            
        } else if let arr = o as? NSArray {
            
            let vjson = VJson.array()
            
            for e in arr {
                vjson.append(try getVJsonFrom(e as AnyObject))
            }
            
            return vjson
            
        } else if let dict = o as? NSDictionary {
            
            let vjson = VJson.object()
            
            for e in dict {
                let name = (e.key as? String) ?? "***ERROR***"
                let value = try getVJsonFrom(e.value as AnyObject)
                vjson.add(value, for: name)
            }
            
            return vjson
            
        } else {
            
            // This should be impossible.
            throw Exception.reason(location: 0, code: 100, incomplete: true, message: "Illegal value in AppleParser result")
        }
    }
}


// MARK: - The VJson parser

internal extension VJson {
    
    
    /// Parses the given sequence of bytes (ASCII or UTF8 encoded) according to ECMA-404, 1st edition October 2013. The sequence should contain exactly one JSON hierarchy. Any errors will result in a throw.
    ///
    /// - Parameter buffer: A buffer with ASCII or UTF8 formatted data to be parsed.
    ///
    /// - Returns: The VJson hierarchy representing the data in the buffer.
    ///
    /// - Throws: Error.reason
    
    fileprivate static func vJsonParser(buffer: UnsafeBufferPointer<UInt8>) throws -> VJson {
        
        guard buffer.count > 0 else { throw Exception.reason(location: 0, code: 1, incomplete: true, message: "Empty buffer") }
        
        
        // Start at the beginning
        
        var offset: Int = 0
        
        
        // Top level, a value is expected
        
        let val = try readValue(buffer.baseAddress!, numberOfBytes: buffer.count, offset: &offset)
        
        
        // Only whitespaces allowed after the value
        
        if offset < buffer.count {
            
            skipWhitespaces(buffer.baseAddress!, numberOfBytes: buffer.count, offset: &offset)
            
            if offset < buffer.count { throw Exception.reason(location: offset, code: 2, incomplete: false, message: "Unexpected characters after end of parsing at offset \(offset - 1)") }
        }
        
        return val
    }
    
    
    /// Parses the data according to ECMA-404, 1st edition October 2013. The sequence should contain exactly one JSON hierarchy. Any errors will result in a throw.
    ///
    /// - Parameter data: A data object with ASCII or UTF8 formatted data to be parsed.
    ///
    /// - Returns: The VJson hierarchy representing the data in the buffer.
    ///
    /// - Throws: Error.reason
    
    fileprivate static func vJsonParser(data: inout Data) throws -> VJson {
        
        guard data.count > 0 else { throw Exception.reason(location: 0, code: 3, incomplete: true, message: "Empty buffer") }
        
        
        // Start at the beginning
        
        var offset: Int = 0
        
        
        // Top level, a value is expected
        
        let val = try data.withUnsafeBytes() {
            
            (ptr: UnsafePointer<UInt8>) -> VJson in
            
            try readValue(ptr, numberOfBytes: data.count, offset: &offset)
        }
        
        
        // Remove consumed bytes
        
        if offset > 0 {
            let range = Range(uncheckedBounds: (lower: 0, upper: offset))
            var dummy: UInt8 = 0
            let empty = UnsafeBufferPointer<UInt8>(start: &dummy, count: 0)
            data.replaceSubrange(range, with: empty)
        }
        
        return val
    }
    
    
    // The number formatter for the number value
    
    private static var formatter: NumberFormatter?
    
    
    // The conversion from string to number using the above number formatter
    
    private static func toDouble(_ str: String) -> Double? {
        if VJson.formatter == nil {
            VJson.formatter = NumberFormatter()
            VJson.formatter?.decimalSeparator = "."
        }
        return VJson.formatter?.number(from: str)?.doubleValue
    }
    
    
    // Read the last three characters of a "true" value
    
    private static func readTrue(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 4, incomplete: true, message: "Illegal value, missing 'r' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._r { throw Exception.reason(location: offset, code: 5, incomplete: false, message: "Illegal value, no 'r' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 6, incomplete: true, message: "Illegal value, missing 'u' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._u { throw Exception.reason(location: offset, code: 7, incomplete: false, message: "Illegal value, no 'u' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 8, incomplete: true, message: "Illegal value, missing 'e' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._e { throw Exception.reason(location: offset, code: 9, incomplete: false, message: "Illegal value, no 'e' in 'true' at offset \(offset)") }
        offset += 1
        
        return VJson(true)
    }
    
    
    // Read the last four characters of a "false" value
    
    private static func readFalse(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 10, incomplete: true, message: "Illegal value, missing 'a' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._a { throw Exception.reason(location: offset, code: 11, incomplete: false, message: "Illegal value, no 'a' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 12, incomplete: true, message: "Illegal value, missing 'l' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._l { throw Exception.reason(location: offset, code: 13, incomplete: false, message: "Illegal value, no 'l' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 14, incomplete: true, message: "Illegal value, missing 's' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._s { throw Exception.reason(location: offset, code: 15, incomplete: false, message: "Illegal value, no 's' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 16, incomplete: true, message: "Illegal value, missing 'e' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._e { throw Exception.reason(location: offset, code: 17, incomplete: false, message: "Illegal value, no 'e' in 'true' at offset \(offset)") }
        offset += 1
        
        return VJson(false)
    }
    
    
    // Read the last three characters of a "null" value
    
    private static func readNull(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 18, incomplete: true, message: "Illegal value, missing 'u' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._u { throw Exception.reason(location: offset, code: 19, incomplete: false, message: "Illegal value, no 'u' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 20, incomplete: true, message: "Illegal value, missing 'l' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._l { throw Exception.reason(location: offset, code: 21, incomplete: false, message: "Illegal value, no 'l' in 'true' at offset \(offset)") }
        offset += 1
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 22, incomplete: true, message: "Illegal value, missing 'l' in 'true' at end of buffer") }
        if buffer[offset] != Ascii._l { throw Exception.reason(location: offset, code: 23, incomplete: false, message: "Illegal value, no 'l' in 'true' at offset \(offset)") }
        offset += 1
        
        return VJson.null()
    }
    
    
    // Read the next characters as a string, ends with non-escaped double quote
    
    private static func readString(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 24, incomplete: true, message: "Missing end of string at end of buffer") }
        
        var strbuf = Array<UInt8>()
        
        var stringEnd = false
        
        while !stringEnd {
            
            if buffer[offset] == Ascii._DOUBLE_QUOTES {
                stringEnd = true
            } else {
                
                if buffer[offset] == Ascii._BACKSLASH {
                    strbuf.append(Ascii._BACKSLASH)
                    
                    offset += 1
                    
                    if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 25, incomplete: true, message: "Missing end of string at end of buffer") }
                    
                    switch buffer[offset] {
                    case Ascii._DOUBLE_QUOTES, Ascii._BACKWARD_SLASH, Ascii._FOREWARD_SLASH, Ascii._b, Ascii._f, Ascii._n, Ascii._r, Ascii._t: strbuf.append(buffer[offset])
                    //case Ascii._b: strbuf.append(Ascii._BACKSPACE)
                    //case Ascii._f: strbuf.append(Ascii._FORMFEED)
                    //case Ascii._n: strbuf.append(Ascii._NEWLINE)
                    //case Ascii._r: strbuf.append(Ascii._CARRIAGE_RETURN)
                    //case Ascii._t: strbuf.append(Ascii._TAB)
                    case Ascii._u:
                        strbuf.append(buffer[offset])
                        offset += 1
                        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 26, incomplete: true, message: "Missing second byte after \\u in string") }
                        strbuf.append(buffer[offset])
                        offset += 1
                        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 27, incomplete: true, message: "Missing third byte after \\u in string") }
                        strbuf.append(buffer[offset])
                        offset += 1
                        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 28, incomplete: true, message: "Missing fourth byte after \\u in string") }
                        strbuf.append(buffer[offset])
                    default:
                        throw Exception.reason(location: offset, code: 29, incomplete: false, message: "Illegal character after \\ in string")
                    }
                    
                } else {
                    
                    strbuf.append(buffer[offset])
                }
            }
            
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 30, incomplete: true, message: "Missing end of string at end of buffer") }
        }
        
        if let str: String = String(bytes: strbuf, encoding: String.Encoding.ascii) {
            let v = VJson("")
            v.stringValueRaw = str
            return v
        } else {
            throw Exception.reason(location: offset, code: 31, incomplete: false, message: "NSUTF8StringEncoding conversion failed at offset \(offset - 1)")
        }
    }
    
    private static func readNumber(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        var numbuf = Array<UInt8>()
        
        // Sign
        if buffer[offset] == Ascii._MINUS {
            numbuf.append(buffer[offset])
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 32, incomplete: true, message: "Missing number at end of buffer") }
        }
        
        // First digit series
        if buffer[offset].isAsciiNumber {
            while buffer[offset].isAsciiNumber {
                numbuf.append(buffer[offset])
                offset += 1
                // If the original string is a fraction, it could end right after the number
                if offset >= numberOfBytes {
                    if let numstr = String(bytes: numbuf, encoding: String.Encoding.utf8) {
                        if let double = toDouble(numstr) {
                            return VJson(double)
                        } else {
                            throw Exception.reason(location: offset, code: 33, incomplete: false, message: "Could not convert to double at end of buffer") // Probably impossible
                        }
                    } else {
                        throw Exception.reason(location: offset, code: 34, incomplete: false, message: "NSUTF8StringEncoding conversion failed at end of buffer")
                    }
                }
            }
        } else {
            throw Exception.reason(location: offset, code: 35, incomplete: false, message: "Illegal character in number at offset \(offset)")
        }
        
        // Fraction
        if buffer[offset] == Ascii._DOT {
            numbuf.append(buffer[offset])
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 36, incomplete: true, message: "Missing digits (expecting fraction) at offset \(offset - 1)") }
            if buffer[offset].isAsciiNumber {
                while buffer[offset].isAsciiNumber {
                    numbuf.append(buffer[offset])
                    offset += 1
                    // If the original string is a fraction, it could end right after the number
                    if offset >= numberOfBytes {
                        if let numstr = String(bytes: numbuf, encoding: String.Encoding.utf8) {
                            if let double = toDouble(numstr) {
                                return VJson(double)
                            } else {
                                throw Exception.reason(location: offset, code: 37, incomplete: false, message: "Could not convert to double at end of buffer") // Probably impossible
                            }
                        } else {
                            throw Exception.reason(location: offset, code: 38, incomplete: false, message: "NSUTF8StringEncoding conversion failed at end of buffer")
                        }
                    }
                }
            } else {
                throw Exception.reason(location: offset, code: 39, incomplete: false, message: "Illegal character in fraction at offset \(offset)")
            }
        }
        
        // Mantissa
        if buffer[offset] == Ascii._e || buffer[offset] == Ascii._E {
            numbuf.append(buffer[offset])
            offset += 1
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 40, incomplete: true, message: "Missing mantissa at buffer end") }
            if buffer[offset] == Ascii._MINUS || buffer[offset] == Ascii._PLUS {
                numbuf.append(buffer[offset])
                offset += 1
                if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 41, incomplete: true, message: "Missing mantissa at buffer end") }
            }
            if buffer[offset].isAsciiNumber {
                while buffer[offset].isAsciiNumber {
                    numbuf.append(buffer[offset])
                    offset += 1
                    if offset >= numberOfBytes { break }
                }
            } else {
                throw Exception.reason(location: offset, code: 42, incomplete: false, message: "Illegal character in mantissa at offset \(offset)")
            }
        }
        
        // Number completed
        
        if let numstr = String(bytes: numbuf, encoding: String.Encoding.utf8) {
            return VJson((toDouble(numstr) ?? Double(0.0)))
        } else {
            throw Exception.reason(location: offset, code: 43, incomplete: false, message: "NSUTF8StringEncoding conversion failed for number ending at offset \(offset - 1)")
        }
        
    }
    
    private static func readArray(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 44, incomplete: true, message: "Missing array end at end of buffer") }
        
        
        let result = VJson(type: .array, name: nil)
        
        
        // Index points at value or end-of-array bracket
        
        if buffer[offset] == Ascii._SQUARE_BRACKET_CLOSE {
            offset += 1
            return result
        }
        
        
        // The offset should point at a value
        
        while offset < numberOfBytes {
            
            let value = try readValue(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            // Value received, walk to the next "]" or "," or end of json
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 45, incomplete: true, message: "Missing array end at end of buffer") }
            
            if buffer[offset] == Ascii._COMMA {
                result.append(value)
                offset += 1
            } else if buffer[offset] == Ascii._SQUARE_BRACKET_CLOSE {
                offset += 1
                result.append(value)
                return result
            } else {
                throw Exception.reason(location: offset, code: 58, incomplete: false, message: "Expected comma or end-of-array bracket")
            }
        }
        
        throw Exception.reason(location: offset, code: 46, incomplete: true, message: "Missing array end at end of buffer")
    }
    
    
    // The value should never return an .ERROR type. If an error occured it should be reported through the errorString and errorReason.
    
    private static func readValue(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 47, incomplete: true, message: "Missing value at end of buffer") }
        
        
        // index points at non-whitespace
        
        var val: VJson
        
        switch buffer[offset] {
            
        case Ascii._BRACE_OPEN:
            offset += 1
            val = try readObject(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._SQUARE_BRACKET_OPEN:
            offset += 1
            val = try readArray(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._DOUBLE_QUOTES:
            offset += 1
            val = try readString(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._MINUS:
            val = try readNumber(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._0...Ascii._9:
            val = try readNumber(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._n:
            offset += 1
            val = try readNull(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._f:
            offset += 1
            val = try readFalse(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        case Ascii._t:
            offset += 1
            val = try readTrue(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
        default: throw Exception.reason(location: offset, code: 48, incomplete: false, message: "Illegal character at start of value at offset \(offset)")
        }
        
        return val
    }
    
    private static func readObject(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) throws -> VJson {
        
        skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
        
        if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 49, incomplete: true, message: "Missing object end at end of buffer") }
        
        
        // Result object
        
        let result = VJson(type: .object, name: nil)
        
        
        // Index points at non-whitespace
        
        if buffer[offset] == Ascii._BRACE_CLOSE {
            offset += 1
            return result
        }
        
        
        // Add name/value pairs
        
        while offset < numberOfBytes {
            
            
            // The offset should point at "
            
            var name: String
            
            if buffer[offset] == Ascii._DOUBLE_QUOTES {
                
                offset += 1
                let str = try readString(buffer, numberOfBytes: numberOfBytes, offset: &offset)
                
                if str.type == .string {
                    name = str.string!
                } else {
                    throw Exception.reason(location: offset, code: 50, incomplete: false, message: "Programming error")
                }
                
            } else {
                throw Exception.reason(location: offset, code: 51, incomplete: false, message: "Expected double quotes of name in name/value pair at offset \(offset)")
            }
            
            
            // The colon is next
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 52, incomplete: true, message: "Missing ':' in name/value pair at offset \(offset - 1)") }
            
            if buffer[offset] != Ascii._COLON {
                throw Exception.reason(location: offset, code: 53, incomplete: false, message: "Missing ':' in name/value pair at offset \(offset)")
            }
            
            offset += 1 // Consume the ":"
            
            
            // A value should be next
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 54, incomplete: true, message: "Missing value of name/value pair at buffer end") }
            
            let val = try readValue(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            
            // Add the name/value pair to this object
            
            val.name = name
            result.add(val, for: nil, replace: false)
            
            
            // A comma or brace end should be next
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 55, incomplete: true, message: "Missing end of object at buffer end") }
            
            if buffer[offset] == Ascii._BRACE_CLOSE {
                offset += 1
                return result
            }
            
            if buffer[offset] != Ascii._COMMA { throw Exception.reason(location: offset, code: 56, incomplete: false, message: "Unexpected character, expected comma at offset \(offset)") }
            
            offset += 1 // Consume the ','
            
            skipWhitespaces(buffer, numberOfBytes: numberOfBytes, offset: &offset)
            
            if offset >= numberOfBytes { throw Exception.reason(location: offset, code: 60, incomplete: true, message: "Missing name/value pair at buffer end") }
        }
        
        throw Exception.reason(location: offset, code: 57, incomplete: true, message: "Missing name in name/value pair of object at buffer end")
    }
    
    private static func skipWhitespaces(_ buffer: UnsafePointer<UInt8>, numberOfBytes: Int, offset: inout Int) {
        
        if offset >= numberOfBytes { return }
        while buffer[offset].isAsciiWhitespace {
            offset += 1
            if offset >= numberOfBytes { break }
        }
    }
}

