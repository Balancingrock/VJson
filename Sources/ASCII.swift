// =====================================================================================================================
//
//  File:       ASCII.swift
//  Project:    SwifterJSON
//
//  Version:    0.9.14
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Balancingrock/SwifterJSON
//
//  Copyright:  (c) 2014-2016 Marinus van der Lugt, All rights reserved.
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
// v0.9.14 - Organizational and documentary changes for SPM and jazzy.
// v0.9.12 - Added textified & symbol
// v0.9.6  - Header update
// v0.9.1  - Added hexLookup
//         - Changed 'is___' functions to var's
// v0.9.0  - Initial release
// =====================================================================================================================

import Foundation


/// Defines ASCII codes 0x00..0xFF

public final class Ascii {

    
    /// Base type for ASCII codes
    
    public typealias ASCII = UInt8


    ///
    static public let _NUL: ASCII = 0x00
    
    ///
    static public let _SOH: ASCII = 0x01
    
    ///
    static public let _STX: ASCII = 0x02
    
    ///
    static public let _ETX: ASCII = 0x03
    
    ///
    static public let _EOT: ASCII = 0x04
    
    ///
    static public let _ENQ: ASCII = 0x05
    
    ///
    static public let _ACK: ASCII = 0x06
    
    ///
    static public let _BEL: ASCII = 0x07
    
    ///
    static public let _BS:  ASCII = 0x08
    
    ///
    static public let _BACKSPACE = _BS
    
    ///
    static public let _TAB: ASCII = 0x09
    
    ///
    static public let _LF:  ASCII = 0x0A
    
    ///
    static public let _LINEFEED = _LF
    
    ///
    static public let _NEWLINE = _LF
    
    ///
    static public let _VT:  ASCII = 0x0B
    
    ///
    static public let _FF:  ASCII = 0x0C
    
    ///
    static public let _FORMFEED = _FF
    
    ///
    static public let _CR:  ASCII = 0x0D
    
    ///
    static public let _CARRIAGE_RETURN = _CR
    
    ///
    static public let _RETURN = _CR
    
    ///
    static public let _SO:  ASCII = 0x0E
    
    ///
    static public let _SI:  ASCII = 0x0F

    ///
    static public let _DLE: ASCII = 0x10
    
    ///
    static public let _DC1: ASCII = 0x11
    
    ///
    static public let _DC2: ASCII = 0x12
    
    ///
    static public let _DC3: ASCII = 0x13
    
    ///
    static public let _DC4: ASCII = 0x14
    
    ///
    static public let _NAK: ASCII = 0x15
    
    ///
    static public let _SYN: ASCII = 0x16
    
    ///
    static public let _ETB: ASCII = 0x17
    
    ///
    static public let _CAN: ASCII = 0x18
    
    ///
    static public let _EM:  ASCII = 0x19
    
    ///
    static public let _SUB: ASCII = 0x1A
    
    ///
    static public let _ESC: ASCII = 0x1B
    
    ///
    static public let _FS:  ASCII = 0x1C
    
    ///
    static public let _GS:  ASCII = 0x1D
    
    ///
    static public let _RS:  ASCII = 0x1E
    
    ///
    static public let _US:  ASCII = 0x1F
    
    ///
    static public let _SPACE: ASCII = 0x20
    
    ///
    static public let _BLANK = _SPACE
    
    ///
    static public let _EXCLAMATION_MARK: ASCII = 0x21
    
    ///
    static public let _DOUBLE_QUOTES: ASCII = 0x22
    
    ///
    static public let _NUMBER: ASCII = 0x23
    
    ///
    static public let _HASH = _NUMBER
    
    ///
    static public let _DOLLAR: ASCII = 0x24
    
    ///
    static public let _PERCENT_SIGN: ASCII = 0x25
    
    ///
    static public let _AMPERSAND: ASCII = 0x26
    
    ///
    static public let _SINGLE_QUOTE: ASCII = 0x27
    
    ///
    static public let _ROUND_BRACKET_OPEN: ASCII = 0x28
    
    ///
    static public let _PARENTHESES_OPEN = _ROUND_BRACKET_OPEN
    
    ///
    static public let _FUNCTION_BRACKET_OPEN = _ROUND_BRACKET_OPEN
    
    ///
    static public let _ROUND_BRACKET_CLOSE: ASCII = 0x29
    
    ///
    static public let _PARENTHESES_CLOSE = _ROUND_BRACKET_CLOSE
    
    ///
    static public let _FUNCTION_BRACKET_CLOSE = _ROUND_BRACKET_CLOSE
    
    ///
    static public let _ASTERISK: ASCII = 0x2A
    
    ///
    static public let _PLUS: ASCII = 0x2B
    
    ///
    static public let _COMMA: ASCII = 0x2C
    
    ///
    static public let _HYPHEN: ASCII = 0x2D
    
    ///
    static public let _MINUS = _HYPHEN
    
    ///
    static public let _DASH = _HYPHEN
    
    ///
    static public let _PERIOD: ASCII = 0x2E
    
    ///
    static public let _DOT = _PERIOD
    
    ///
    static public let _POINT = _PERIOD
    
    ///
    static public let _SLASH: ASCII = 0x2F
    
    ///
    static public let _SOLIDUS = _SLASH
    
    ///
    static public let _FOREWARD_SLASH = _SLASH
    
    ///
    static public let _SLASH_FOREWARD = _SLASH
    
    ///
    static public let _0: ASCII = 0x30
    
    ///
    static public let _1: ASCII = 0x31
    
    ///
    static public let _2: ASCII = 0x32
    
    ///
    static public let _3: ASCII = 0x33
    
    ///
    static public let _4: ASCII = 0x34
    
    ///
    static public let _5: ASCII = 0x35
    
    ///
    static public let _6: ASCII = 0x36
    
    ///
    static public let _7: ASCII = 0x37
    
    ///
    static public let _8: ASCII = 0x38
    
    ///
    static public let _9: ASCII = 0x39
    
    ///
    static public let _COLON: ASCII = 0x3A
    
    ///
    static public let _SEMICOLON: ASCII = 0x3B
    
    ///
    static public let _LESS_THAN: ASCII = 0x3C
    
    ///
    static public let _LT = _LESS_THAN
    
    ///
    static public let _EQUALS: ASCII = 0x3D
    
    ///
    static public let _GREATER_THAN: ASCII = 0x3E
    
    ///
    static public let _GT = _GREATER_THAN
    
    ///
    static public let _QUESTION_MARK: ASCII = 0x3F
    
    ///
    static public let _AT_SYMBOL: ASCII = 0x40
    
    ///
    static public let _A: ASCII = 0x41
    
    ///
    static public let _B: ASCII = 0x42
    
    ///
    static public let _C: ASCII = 0x43
    
    ///
    static public let _D: ASCII = 0x44
    
    ///
    static public let _E: ASCII = 0x45
    
    ///
    static public let _F: ASCII = 0x46
    
    ///
    static public let _G: ASCII = 0x47
    
    ///
    static public let _H: ASCII = 0x48
    
    ///
    static public let _I: ASCII = 0x49
    
    ///
    static public let _J: ASCII = 0x4A
    
    ///
    static public let _K: ASCII = 0x4B
    
    ///
    static public let _L: ASCII = 0x4C
    
    ///
    static public let _M: ASCII = 0x4D
    
    ///
    static public let _N: ASCII = 0x4E
    
    ///
    static public let _O: ASCII = 0x4F
    
    ///
    static public let _P: ASCII = 0x50
    
    ///
    static public let _Q: ASCII = 0x51
    
    ///
    static public let _R: ASCII = 0x52
    
    ///
    static public let _S: ASCII = 0x53
    
    ///
    static public let _T: ASCII = 0x54
    
    ///
    static public let _U: ASCII = 0x55
    
    ///
    static public let _V: ASCII = 0x56
    
    ///
    static public let _W: ASCII = 0x57
    
    ///
    static public let _X: ASCII = 0x58
    
    ///
    static public let _Y: ASCII = 0x59
    
    ///
    static public let _Z: ASCII = 0x5A
    
    ///
    static public let _SQUARE_BRACKET_OPEN: ASCII  = 0x5B
    
    ///
    static public let _BOX_BRACKET_OPEN = _SQUARE_BRACKET_OPEN
    
    ///
    static public let _ARRAY_BRACKET_OPEN = _SQUARE_BRACKET_OPEN
    
    ///
    static public let _BACKSLASH: ASCII = 0x5C
    
    ///
    static public let _REVERSE_SOLIDUS = _BACKSLASH
    
    ///
    static public let _BACKWARD_SLASH = _BACKSLASH
    
    ///
    static public let _SLASH_BACKWARD = _BACKSLASH
    
    ///
    static public let _SQUARE_BRACKET_CLOSE: ASCII = 0x5D
    
    ///
    static public let _BOX_BRACKET_CLOSE = _SQUARE_BRACKET_CLOSE
    
    ///
    static public let _ARRAY_BRACKET_CLOSE = _SQUARE_BRACKET_CLOSE
    
    ///
    static public let _CARET: ASCII = 0x5E
    
    ///
    static public let _UNDERSCORE: ASCII = 0x5F
    
    ///
    static public let _GRAVE_ACCENT: ASCII = 0x60
    
    ///
    static public let _a: ASCII = 0x61
    
    ///
    static public let _b: ASCII = 0x62
    
    ///
    static public let _c: ASCII = 0x63
    
    ///
    static public let _d: ASCII = 0x64
    
    ///
    static public let _e: ASCII = 0x65
    
    ///
    static public let _f: ASCII = 0x66
    
    ///
    static public let _g: ASCII = 0x67
    
    ///
    static public let _h: ASCII = 0x68
    
    ///
    static public let _i: ASCII = 0x69
    
    ///
    static public let _j: ASCII = 0x6A
    
    ///
    static public let _k: ASCII = 0x6B
    
    ///
    static public let _l : ASCII = 0x6C
    
    ///
    static public let _m: ASCII = 0x6D
    
    ///
    static public let _n: ASCII = 0x6E
    
    ///
    static public let _o: ASCII = 0x6F
    
    ///
    static public let _p: ASCII = 0x70
    
    ///
    static public let _q: ASCII = 0x71
    
    ///
    static public let _r: ASCII = 0x72
    
    ///
    static public let _s: ASCII = 0x73
    
    ///
    static public let _t: ASCII = 0x74
    
    ///
    static public let _u: ASCII = 0x75
    
    ///
    static public let _v: ASCII = 0x76
    
    ///
    static public let _w: ASCII = 0x77
    
    ///
    static public let _x: ASCII = 0x78
    
    ///
    static public let _y: ASCII = 0x79
    
    ///
    static public let _z: ASCII = 0x7A
    
    ///
    static public let _BRACE_OPEN: ASCII = 0x7B
    
    ///
    static public let _CURLY_BRACE_OPEN = _BRACE_OPEN
    
    ///
    static public let _VERTICAL_BAR: ASCII = 0x7C
    
    ///
    static public let _BRACE_CLOSE: ASCII = 0x7D
    
    ///
    static public let _CURLY_BRACE_CLOSE = _BRACE_CLOSE
    
    ///
    static public let _TILDE: ASCII = 0x7E
    
    ///
    static public let _DELETE: ASCII = 0x7F


    /// The string represenation of the hexadecimal value.
    
    static public let hexLookup: Array<String> = [
        "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "0A", "0B", "0C", "0D", "0E", "0F",
        "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "1A", "1B", "1C", "1D", "1E", "1F",
        "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "2A", "2B", "2C", "2D", "2E", "2F",
        "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "3A", "3B", "3C", "3D", "3E", "3F",
        "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "4A", "4B", "4C", "4D", "4E", "4F",
        "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "5A", "5B", "5C", "5D", "5E", "5F",
        "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "6A", "6B", "6C", "6D", "6E", "6F",
        "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "7A", "7B", "7C", "7D", "7E", "7F",
        "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "8A", "8B", "8C", "8D", "8E", "8F",
        "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "9A", "9B", "9C", "9D", "9E", "9F",
        "A0", "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "AA", "AB", "AC", "AD", "AE", "AF",
        "B0", "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "BA", "BB", "BC", "BD", "BE", "BF",
        "C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "CA", "CB", "CC", "CD", "CE", "CF",
        "D0", "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "DA", "DB", "DC", "DD", "DE", "DF",
        "E0", "E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8", "E9", "EA", "EB", "EC", "ED", "EE", "EF",
        "F0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "FA", "FB", "FC", "FD", "FE", "FF",
        ]
    
    
    /// The printable string representation. If there is no printable a "." is used.
    
    static public let dumpLookup: Array<String> = [
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        " ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/",
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?",
        "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
        "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "^", "_",
        "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
        "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ]
    
    
    /// The printable symbol name. If there is no printable symbol name "." is used.
    
    static public let symbolLookup: Array<String> = [
        "NUL", "SOH", "STX", "ETX", "EOT", "ENQ", "ACK", "BEL", "BS", "TAB", "LF", "VT", "FF", "CR", "SO", "SI",
        "DLE", "DC1", "DC2", "DC3", "DC4", "NAK", "SYN", "ETB", "CAN", "EM", "SUB", "ESC", "FS", "GS", "RS", "US",
        "SPACE", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/",
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?",
        "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
        "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "^", "_",
        "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
        "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~", "DEL",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".",
        ]


    /// Checks if the character is a control character (0x00..0x1F)
    ///
    /// - Parameter c: The ASCII char to examine
    ///
    /// - Returns: true if it is a control character.
    
    static public func isControl(_ c: ASCII) -> Bool {
        return c < _SPACE
    }
    
    
    /// Checks if the character is printable (0x20..0x7E)
    ///
    /// - Parameter c: The ASCII char to examine
    ///
    /// - Returns: true if it is a printable
    
    static public func isPrintable(_ c: ASCII) -> Bool {
        return (c >= _SPACE && c < _DELETE)
    }
    
    
    /// Checks if the character is a number (0..9)
    ///
    /// - Parameter c: The ASCII char to examine
    ///
    /// - Returns: true if it is a number
    
    static public func isNumber(_ c: ASCII) -> Bool {
        return (c >= _0 && c <= _9)
    }
    
    
    /// Checks if the character is a hexadecimal (0..9, a..f, A..F)
    ///
    /// - Parameter c: The ASCII char to examine
    ///
    /// - Returns: true if it is a hexadecimal
    
    static public func isHexadecimalDigit(_ c: ASCII) -> Bool {
        
        if isNumber(c) { return true }
        if (c >= _a && c <= _f) { return true }
        if (c >= _A && c <= _F) { return true }
        return false
    }
    
    
    /// Checks if the character is a white space (blank, tab, return, linefeed)
    ///
    /// - Parameter c: The ASCII char to examine
    ///
    /// - Returns: true if it is a whitespace
    
    static public func isWhitespace(_ c: ASCII) -> Bool {
        if c == _SPACE { return true }
        if c == _TAB { return true }
        if c == _CR { return true }
        if c == _LF { return true }
        return false
    }
}


// MARK: - ASCII protocol extensions

public extension Ascii.ASCII {
    
    
    /// True if the ASCII character is a control character (0x00..0x1F), false otherwise.

    public var isAsciiControl: Bool {
        return Ascii.isControl(self)
    }
    
    
    /// True if the ASCII character is printable (0x20..0x7E), false otherwise.

    public var isAsciiPrintable: Bool {
        return Ascii.isPrintable(self)
    }
    
    
    /// True if the ASCII character is a number (0..9), false otherwise.

    public var isAsciiNumber: Bool {
        return Ascii.isNumber(self)
    }
    
    
    /// True if the ASCII character is a hexadecimal (0..9, a..f, A..F), false otherwise.

    public var isAsciiHexadecimalDigit: Bool {
        return Ascii.isHexadecimalDigit(self)
    }
    

    /// True if the ASCII character is a white space (blank, tab, return, linefeed), false otherwise.

    public var isAsciiWhitespace: Bool {
        return Ascii.isWhitespace(self)
    }
    

    /// The string represenation of the hexadecimal value.

    public var hexString: String {
        return Ascii.hexLookup[Int(self)]
    }
    
    
    /// A string of 1 printable character, unprintables are replaced by a dot.
    
    public var textified: String {
        return Ascii.dumpLookup[Int(self)]
    }
    
    
    /// A string of up to three characters representing the symbol for the value. Unprintables are represented by their abbreviation. Values > 0x7F are represented by a dot.
    
    public var symbol: String {
        return Ascii.symbolLookup[Int(self)]
    }
}

