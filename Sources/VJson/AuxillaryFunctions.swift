// =====================================================================================================================
//
//  File:       AuxillaryFunctions.swift
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

import Foundation
import Ascii


public extension VJson {
    
    
    /// Scans a memory area for a JSON formatted message as defined by opening and closing braces. Scanning for the opening brace starts at the first byte. Scanning continues until either the closing brace or the end of the range is encountered. Braces inside strings are not evaluated.
    ///
    /// - Note: This function does not guarantee that the JSON code between the braces is valid JSON code.
    ///
    /// - Note: When a buffer is returned, the start of the buffer is the location of the opening brace, which is not necessarily equal to the start-pointer.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of an area that must be scnanned for a JSON message.
    ///   - count: The number of bytes that must be scanned.
    ///
    /// - Returns: Nil if no (complete) JSON message was found, otherwise an UnsafeBufferPointer covering the area with the JSON message. Note that the bufer is not copied. Hence make sure to process the JSON message before removing or moving the data in that area.
    
    static func findPossibleJsonCode(start: UnsafeMutableRawPointer, count: Int) -> UnsafeBufferPointer<UInt8>? {
        
        enum ScanPhase { case normal, inString, escaped, hex1, hex2, hex3, hex4 }
        
        var scanPhase: ScanPhase = .normal
        
        var countOpeningBraces = 0
        var countClosingBraces = 0
        
        var bytePtr = start.assumingMemoryBound(to: UInt8.self)
        let pastLastBytePtr = start.assumingMemoryBound(to: UInt8.self).advanced(by: count)
        
        var jsonAreaStart = bytePtr // Any value, will be overwritten on success
        var jsonCount = 0 // Any value, will be overwritten on success
        
        while bytePtr < pastLastBytePtr {
            let byte = bytePtr.pointee
            switch scanPhase {
            case .normal:
                if byte == Ascii._BRACE_OPEN {
                    countOpeningBraces += 1
                    if countOpeningBraces == 1 {
                        jsonAreaStart = bytePtr
                        jsonCount = 0
                    }
                } else if byte == Ascii._BRACE_CLOSE {
                    countClosingBraces += 1
                    if countOpeningBraces == countClosingBraces {
                        jsonCount += 1
                        let jsonBufferArea = UnsafeBufferPointer<UInt8>(start: jsonAreaStart, count: jsonCount)
                        return jsonBufferArea
                    }
                } else if byte == Ascii._DOUBLE_QUOTES {
                    scanPhase = .inString
                }
            case .inString:
                if byte == Ascii._DOUBLE_QUOTES {
                    scanPhase = .normal
                } else if byte == Ascii._BACKWARD_SLASH {
                    scanPhase = .escaped
                }
            case .escaped:
                if byte == Ascii._u {
                    scanPhase = .hex1
                } else {
                    scanPhase = .inString
                }
            case .hex1: scanPhase = .hex2
            case .hex2: scanPhase = .hex3
            case .hex3: scanPhase = .hex4
            case .hex4: scanPhase = .inString
            }
            bytePtr = bytePtr.advanced(by: 1)
            jsonCount += 1
        }
        return nil
    }
}
