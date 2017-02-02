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


/// Represents an ASCII code

public typealias ASCII = UInt8


// Control Characters

public let ASCII_NUL: ASCII = 0x00
public let ASCII_SOH: ASCII = 0x01
public let ASCII_STX: ASCII = 0x02
public let ASCII_ETX: ASCII = 0x03
public let ASCII_EOT: ASCII = 0x04
public let ASCII_ENQ: ASCII = 0x05
public let ASCII_ACK: ASCII = 0x06
public let ASCII_BEL: ASCII = 0x07
public let ASCII_BS:  ASCII = 0x08; public let ASCII_BACKSPACE = ASCII_BS
public let ASCII_TAB: ASCII = 0x09
public let ASCII_LF:  ASCII = 0x0A; public let ASCII_LINEFEED = ASCII_LF; public let ASCII_NEWLINE = ASCII_LF
public let ASCII_VT:  ASCII = 0x0B
public let ASCII_FF:  ASCII = 0x0C; public let ASCII_FORMFEED = ASCII_FF
public let ASCII_CR:  ASCII = 0x0D; public let ASCII_CARRIAGE_RETURN = ASCII_CR; public let ASCII_RETURN = ASCII_CR
public let ASCII_SO:  ASCII = 0x0E
public let ASCII_SI:  ASCII = 0x0F

public let ASCII_DLE: ASCII = 0x10
public let ASCII_DC1: ASCII = 0x11
public let ASCII_DC2: ASCII = 0x12
public let ASCII_DC3: ASCII = 0x13
public let ASCII_DC4: ASCII = 0x14
public let ASCII_NAK: ASCII = 0x15
public let ASCII_SYN: ASCII = 0x16
public let ASCII_ETB: ASCII = 0x17
public let ASCII_CAN: ASCII = 0x18
public let ASCII_EM:  ASCII = 0x19
public let ASCII_SUB: ASCII = 0x1A
public let ASCII_ESC: ASCII = 0x1B
public let ASCII_FS:  ASCII = 0x1C
public let ASCII_GS:  ASCII = 0x1D
public let ASCII_RS:  ASCII = 0x1E
public let ASCII_US:  ASCII = 0x1F
    

// Printable characters

public let ASCII_SPACE: ASCII                = 0x20; public let ASCII_BLANK = ASCII_SPACE
public let ASCII_EXCLAMATION_MARK: ASCII     = 0x21
public let ASCII_DOUBLE_QUOTES: ASCII        = 0x22
public let ASCII_NUMBER: ASCII               = 0x23; public let ASCII_HASH = ASCII_NUMBER
public let ASCII_DOLLAR: ASCII               = 0x24
public let ASCII_PERCENT_SIGN: ASCII         = 0x25
public let ASCII_AMPERSAND: ASCII            = 0x26
public let ASCII_SINGLE_QUOTE: ASCII         = 0x27
public let ASCII_ROUND_BRACKET_OPEN: ASCII   = 0x28; public let ASCII_PARENTHESES_OPEN = ASCII_ROUND_BRACKET_OPEN; public let ASCII_FUNCTION_BRACKET_OPEN = ASCII_ROUND_BRACKET_OPEN
public let ASCII_ROUND_BRACKET_CLOSE: ASCII  = 0x29; public let ASCII_PARENTHESES_CLOSE = ASCII_ROUND_BRACKET_CLOSE; public let ASCII_FUNCTION_BRACKET_CLOSE = ASCII_ROUND_BRACKET_CLOSE
public let ASCII_ASTERISK: ASCII             = 0x2A
public let ASCII_PLUS: ASCII                 = 0x2B
public let ASCII_COMMA: ASCII                = 0x2C
public let ASCII_HYPHEN: ASCII               = 0x2D; public let ASCII_MINUS = ASCII_HYPHEN; public let ASCII_DASH = ASCII_HYPHEN
public let ASCII_PERIOD: ASCII               = 0x2E; public let ASCII_DOT = ASCII_PERIOD; public let ASCII_POINT = ASCII_PERIOD
public let ASCII_SLASH: ASCII                = 0x2F; public let ASCII_SOLIDUS = ASCII_SLASH; public let ASCII_FOREWARD_SLASH = ASCII_SLASH; public let ASCII_SLASH_FOREWARD = ASCII_SLASH

public let ASCII_0: ASCII                    = 0x30
public let ASCII_1: ASCII                    = 0x31
public let ASCII_2: ASCII                    = 0x32
public let ASCII_3: ASCII                    = 0x33
public let ASCII_4: ASCII                    = 0x34
public let ASCII_5: ASCII                    = 0x35
public let ASCII_6: ASCII                    = 0x36
public let ASCII_7: ASCII                    = 0x37
public let ASCII_8: ASCII                    = 0x38
public let ASCII_9: ASCII                    = 0x39
public let ASCII_COLON: ASCII                = 0x3A
public let ASCII_SEMICOLON: ASCII            = 0x3B
public let ASCII_LESS_THAN: ASCII            = 0x3C; public let ASCII_LT = ASCII_LESS_THAN
public let ASCII_EQUALS: ASCII               = 0x3D
public let ASCII_GREATER_THAN: ASCII         = 0x3E; public let ASCII_GT = ASCII_GREATER_THAN
public let ASCII_QUESTION_MARK: ASCII        = 0x3F

public let ASCII_AT_SYMBOL: ASCII            = 0x40
public let ASCII_A: ASCII                    = 0x41
public let ASCII_B: ASCII                    = 0x42
public let ASCII_C: ASCII                    = 0x43
public let ASCII_D: ASCII                    = 0x44
public let ASCII_E: ASCII                    = 0x45
public let ASCII_F: ASCII                    = 0x46
public let ASCII_G: ASCII                    = 0x47
public let ASCII_H: ASCII                    = 0x48
public let ASCII_I: ASCII                    = 0x49
public let ASCII_J: ASCII                    = 0x4A
public let ASCII_K: ASCII                    = 0x4B
public let ASCII_L: ASCII                    = 0x4C
public let ASCII_M: ASCII                    = 0x4D
public let ASCII_N: ASCII                    = 0x4E
public let ASCII_O: ASCII                    = 0x4F

public let ASCII_P: ASCII                    = 0x50
public let ASCII_Q: ASCII                    = 0x51
public let ASCII_R: ASCII                    = 0x52
public let ASCII_S: ASCII                    = 0x53
public let ASCII_T: ASCII                    = 0x54
public let ASCII_U: ASCII                    = 0x55
public let ASCII_V: ASCII                    = 0x56
public let ASCII_W: ASCII                    = 0x57
public let ASCII_X: ASCII                    = 0x58
public let ASCII_Y: ASCII                    = 0x59
public let ASCII_Z: ASCII                    = 0x5A
public let ASCII_SQUARE_BRACKET_OPEN: ASCII  = 0x5B; public let ASCII_BOX_BRACKET_OPEN = ASCII_SQUARE_BRACKET_OPEN; public let ASCII_ARRAY_BRACKET_OPEN = ASCII_SQUARE_BRACKET_OPEN
public let ASCII_BACKSLASH: ASCII            = 0x5C; public let ASCII_REVERSE_SOLIDUS = ASCII_BACKSLASH; public let ASCII_BACKWARD_SLASH = ASCII_BACKSLASH; public let ASCII_SLASH_BACKWARD = ASCII_BACKSLASH
public let ASCII_SQUARE_BRACKET_CLOSE: ASCII = 0x5D; public let ASCII_BOX_BRACKET_CLOSE = ASCII_SQUARE_BRACKET_CLOSE; public let ASCII_ARRAY_BRACKET_CLOSE = ASCII_SQUARE_BRACKET_CLOSE
public let ASCII_CARET: ASCII                = 0x5E
public let ASCII_UNDERSCORE: ASCII           = 0x5F

public let ASCII_GRAVE_ACCENT: ASCII         = 0x60
public let ASCII_a: ASCII                    = 0x61
public let ASCII_b: ASCII                    = 0x62
public let ASCII_c: ASCII                    = 0x63
public let ASCII_d: ASCII                    = 0x64
public let ASCII_e: ASCII                    = 0x65
public let ASCII_f: ASCII                    = 0x66
public let ASCII_g: ASCII                    = 0x67
public let ASCII_h: ASCII                    = 0x68
public let ASCII_i: ASCII                    = 0x69
public let ASCII_j: ASCII                    = 0x6A
public let ASCII_k: ASCII                    = 0x6B
public let ASCII_l : ASCII                   = 0x6C
public let ASCII_m: ASCII                    = 0x6D
public let ASCII_n: ASCII                    = 0x6E
public let ASCII_o: ASCII                    = 0x6F

public let ASCII_p: ASCII                    = 0x70
public let ASCII_q: ASCII                    = 0x71
public let ASCII_r: ASCII                    = 0x72
public let ASCII_s: ASCII                    = 0x73
public let ASCII_t: ASCII                    = 0x74
public let ASCII_u: ASCII                    = 0x75
public let ASCII_v: ASCII                    = 0x76
public let ASCII_w: ASCII                    = 0x77
public let ASCII_x: ASCII                    = 0x78
public let ASCII_y: ASCII                    = 0x79
public let ASCII_z: ASCII                    = 0x7A
public let ASCII_BRACE_OPEN: ASCII           = 0x7B; public let ASCII_CURLY_BRACE_OPEN = ASCII_BRACE_OPEN
public let ASCII_VERTICAL_BAR: ASCII         = 0x7C
public let ASCII_BRACE_CLOSE: ASCII          = 0x7D; public let ASCII_CURLY_BRACE_CLOSE = ASCII_BRACE_CLOSE
public let ASCII_TILDE: ASCII                = 0x7E
public let ASCII_DELETE: ASCII               = 0x7F


/// The string represenation of the hexadecimal value.

public let hexLookup: Array<String> = [
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

public let dumpLookup: Array<String> = [
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

public let symbolLookup: Array<String> = [
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


/// Checks if the ASCII character is a control character (0x00..0x1F)
///
/// - Parameter c: The ASCII char to examine
///
/// - Returns: true if it is a control character.

public func isAsciiControl(_ c: ASCII) -> Bool {
    return c < ASCII_SPACE
}


/// Checks if the ASCII character is printable (0x20..0x7E)
///
/// - Parameter c: The ASCII char to examine
///
/// - Returns: true if it is a printable

public func isAsciiPrintable(_ c: ASCII) -> Bool {
    return (c >= ASCII_SPACE && c < ASCII_DELETE)
}


/// Checks if the ASCII character is a number (0..9)
///
/// - Parameter c: The ASCII char to examine
///
/// - Returns: true if it is a number

public func isAsciiNumber(_ c: ASCII) -> Bool {
    return (c >= ASCII_0 && c <= ASCII_9)
}


/// Checks if the ASCII character is a hexadecimal (0..9, a..f, A..F)
///
/// - Parameter c: The ASCII char to examine
///
/// - Returns: true if it is a hexadecimal

public func isAsciiHexadecimalDigit(_ c: ASCII) -> Bool {
    
    if isAsciiNumber(c) { return true }
    if (c >= ASCII_a && c <= ASCII_f) { return true }
    if (c >= ASCII_A && c <= ASCII_F) { return true }
    return false
}


/// Checks if the ASCII character is a white space (blank, tab, return, linefeed)
///
/// - Parameter c: The ASCII char to examine
///
/// - Returns: true if it is a whitespace

public func isAsciiWhitespace(_ c: ASCII) -> Bool {
    if c == ASCII_SPACE { return true }
    if c == ASCII_TAB { return true }
    if c == ASCII_CR { return true }
    if c == ASCII_LF { return true }
    return false
}


// MARK: - ASCII protocol extensions

public extension ASCII {
    
    
    /// True if the ASCII character is a control character (0x00..0x1F), false otherwise.

    public var isAsciiControl: Bool {
        return self < ASCII_SPACE
    }
    
    
    /// True if the ASCII character is printable (0x20..0x7E), false otherwise.

    public var isAsciiPrintable: Bool {
        return (self >= ASCII_SPACE && self < ASCII_DELETE)
    }
    
    
    /// True if the ASCII character is a number (0..9), false otherwise.

    public var isAsciiNumber: Bool {
        return (self >= ASCII_0 && self <= ASCII_9)
    }
    
    
    /// True if the ASCII character is a hexadecimal (0..9, a..f, A..F), false otherwise.

    public var isAsciiHexadecimalDigit: Bool {
        if self.isAsciiNumber { return true }
        if (self >= ASCII_a && self <= ASCII_f) { return true }
        if (self >= ASCII_A && self <= ASCII_F) { return true }
        return false
    }
    

    /// True if the ASCII character is a white space (blank, tab, return, linefeed), false otherwise.

    public var isAsciiWhitespace: Bool {
        if self == ASCII_SPACE { return true }
        if self == ASCII_TAB { return true }
        if self == ASCII_CR { return true }
        if self == ASCII_LF { return true }
        return false
    }
    

    /// The string represenation of the hexadecimal value.

    public var hexString: String {
        return hexLookup[Int(self)]
    }
    
    
    /// A string of 1 printable character, unprintables are replaced by a dot.
    
    public var textified: String {
        return dumpLookup[Int(self)]
    }
    
    
    /// A string of up to three characters representing the symbol for the value. Unprintables are represented by their abbreviation. Values > 0x7F are represented by a dot.
    
    public var symbol: String {
        return symbolLookup[Int(self)]
    }
}

