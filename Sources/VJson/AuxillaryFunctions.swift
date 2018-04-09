// =====================================================================================================================
//
//  File:       AuxillaryFunctions.swift
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
    
    public static func findPossibleJsonCode(start: UnsafeMutableRawPointer, count: Int) -> UnsafeBufferPointer<UInt8>? {
        
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
