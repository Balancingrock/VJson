// =====================================================================================================================
//
//  File:       Code.swift
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


public extension VJson {
    
    
    /// Returns the JSON code that represents the hierarchy of this item. Will return a fragment if self has a name.
    
    var code: String {
        
        if let name = name {
            return "\"\(name)\":\(_code)"
        } else {
            return _code
        }
    }
    
    
    /// Returns the JSON code that represents the hierarchy of this item without a leading name.

    fileprivate var _code: String {
        
        // Get rid of subscript generated objects that no longer serve a purpose
        
        self.removeEmptySubscriptObjects()
        
        var str = ""
        
        switch type {
            
        case .null:
            
            str += "null"
            
            
        case .bool:
            
            if bool == nil {
                str += "null"
            } else {
                str += "\(self.bool!)"
            }
            
            
        case .number:
            
            if number == nil {
                str += "null"
            } else {
                str += "\(self.number!)"
            }
            
            
        case .string:
            
            if string == nil {
                str += "null"
            } else {
                str += "\"\(self.string!)\""
            }
            
            
        case .object:
            
            str += "{"
            
            for i in 0 ..< (children?.count ?? 0) {
                if let child = children?.items[i], let name = child.name {
                    if i != (children?.count ?? 0) - 1 {
                        str += "\"\(name)\":\(child._code),"
                    } else {
                        str += "\"\(name)\":\(child._code)"
                    }
                } else {
                    str += "*** ERROR ***"
                }
            }
            
            str += "}"
            
            
        case .array:
            
            str += "["
            
            for i in 0 ..< (children?.count ?? 0) {
                if let child = children?.items[i] {
                    if i != children!.count - 1 {
                        str += "\(child._code),"
                    } else {
                        str += "\(child._code)"
                    }
                } else {
                    str += "*** ERROR ***"
                }
            }
            
            str += "]"
        }
        
        return str
    }
}
