// =====================================================================================================================
//
//  File:       Merge.swift
//  Project:    VJson
//
//  Version:    0.16.0
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
//  I strongly believe that voluntarism is the way for societies to function optimally. So you can pay whatever you
//  think our code is worth to you.
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
// 0.16.0 - Removed warnings for Swift 5
// 0.15.4 - Improved code clarity of undo/redo
//        - Fixed problem where no duplicates were made in a merging operation
// 0.15.0 - Harmonized names, now uses 'item' or 'items' for items contained in OBJECTs instead of 'child'
//          or 'children'. The name 'child' or 'children' is now used exclusively for operations transcending
//          OBJECTs or ARRAYs.
//          General overhaul of comments and documentation.
// 0.10.8  - Split off from VJson.swift
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Updates the content of self with the content of the object to be merged. Subitems with the same name in self as in other will be made identical to the subitem in other.
    ///
    /// This merge function was designed to support the outline view. When subitems are merged the original subitem will remain, only its data content will change. This also applies to array items.
    ///
    /// After merging the two hierarchies will not share objects, i.e. all shared data is duplicated.
    ///
    /// - Note: This operation can change the types of the content in self to and from null. Other type conversions are only possible if VJson.fatalErrorOnTypeConversion is set to 'false'
    ///
    /// - Note: If other has two subitems with the same name, the order in which they appear will be preserved
    ///
    /// - Parameters
    ///   - with: The object to be merged into self.
    
    func merge(with other: VJson) {
        
        
        // Copy the name
        
        self.name = other.name
        
        
        // The other type drives the merge, for the simple types (non-array non-object) the other is simply copied.
        
        switch other.type {
            
        case .null:
            type = .null
            return
            
        case .bool:
            type = .bool
            bool = other.bool
            return
            
        case .string:
            type = .string
            string = other.string
            return
            
        case .number:
            type = .number
            number = other.numberValue
            return
            
        case .object:
            
            // If self is not an object, then make self the same as other
            
            switch self.type {
                
            case .null, .bool, .number, .string, .array:
                type = .object
                for c in other {
                    self.children!.append(c.duplicate)
                }
                return
                
            case .object:
                
                // Override children with the same name as in others, add those that are not present.
                
                
                // Adds a checkmark to each element, just to keep score.
                
                struct CheckBoxed<T> {
                    var checked: Bool = false
                    let value: T
                    init(_ value: T) { self.value = value }
                }
                
                
                // Create a list of all self children with a marker for each
                
                var selfChildren: Array<CheckBoxed<VJson>> = []
                self.children?.items.forEach({ selfChildren.append(CheckBoxed($0))})
                
                
                // Any other children that are not contained in self children will be added in this array before adding them to self.
                
                var newChildren: Array<VJson> = []
                
                
                // Merge self children with same name as other children
                
                for oc in other {
                    var sc: VJson?
                    for index in 0 ..< selfChildren.count {
                        if !selfChildren[index].checked && (selfChildren[index].value.name == oc.name) {
                            sc = selfChildren[index].value
                            selfChildren[index].checked = true
                            break
                        }
                    }
                    if sc == nil {
                        newChildren.append(oc.duplicate)
                    } else {
                        sc?.merge(with: oc.duplicate)
                    }
                }
                
                
                // Add the new children in other to self
                
                self.children?.append(newChildren)
            }
            
            
        case .array:
            
            switch self.type {
            case .null, .bool, .number, .string, .object:
                type = .array
                self.children?.append(other.arrayValue)
                return
                
            case .array:
                
                for index in 0 ..< (other.children?.count ?? 0) {
                    if index < (self.children?.count ?? 0) {
                        self.children?.items[index].merge(with: other.children!.items[index].duplicate)  // Force unwrap tested before use
                    } else {
                        _ = self.children?.append(other.children!.items[index].duplicate)  // Force unwrap tested before use
                    }
                }
            }
        }
    }
}
