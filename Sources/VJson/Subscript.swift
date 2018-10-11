// =====================================================================================================================
//
//  File:       Subscript.swift
//  Project:    VJson
//
//  Version:    0.15.0
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
//  I strongly believe that voluntarism is the way for societies to function optimally. I thus reject
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
// 0.15.0 - Harmonized names, now uses 'item' or 'items' for items contained in OBJECTs instead of 'child'
//          or 'children'. The name 'child' or 'children' is now used exclusively for operations transcending
//          OBJECTs or ARRAYs.
//          General overhaul of comments and documentation.
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Assigns/retrieves based on the given index.
    ///
    /// Only valid for VJson objects containing a JSON ARRAY.
    ///
    /// - Note: Can result in a fatal error if the VJson.fatalErrorOnTypeConversion is set to 'true' (= default)
    
    public subscript(index: Int) -> VJson {
        
        set {
            
            // If this is an ARRAY object, then make sure there are enough elements and create the requested element
            
            if type != .array { undoableUpdate(to: .array) }
            
            
            // Ensure that enough elements are present in the array
            
            if let children = children {
                
                while index > (children.count - 1) {
                    let item = VJson.null()
                    item.createdBySubscript = true
                    _ = children.append(item)
                }
                
                children.replace(at: index, with: newValue)
            }
        }
        
        get {
            
            
            // If this is an ARRAY object, then make sure there are enough elements and return the requested element
            
            if type != .array { undoableUpdate(to: .array) }
            
            
            // Ensure that enough elements are present in the array
            
            if let children = children {
                while index > (children.count - 1) {
                    let item = VJson.null()
                    item.createdBySubscript = true
                    _ = children.append(item)
                }
            }
            
            return children?.items[index] ?? VJson("***ERROR***") // The ?? should never be activated
        }
    }
    
    
    /// Assigns/retrieves based on the given key.
    ///
    /// Only valid for VJson objects containing a JSON OBJECT.
    ///
    /// - Note: Can result in a fatal error if the VJson.fatalErrorOnTypeConversion is set to 'true' (= default)
    
    public subscript(key: String) -> VJson {
        
        set {
            
            
            // If this is not an object type, change it into an object
            
            if type != .object { undoableUpdate(to: .object) }
            
            add(newValue, for: key)
        }
        
        get {
            
            
            // If this is not an object type, change it into an object
            
            if type != .object { undoableUpdate(to: .object) }
            
            
            // If the requested object exist, return it
            
            if let result = children!.cached(key) { return result } // Try the cache
            
            let arr = items(with: key)
            
            if arr.count > 0 { return arr[0] }
            
            
            // If the request value does not exist, create it
            // This allows object creation for 'object["key1"]["key2"]["key3"] = VJson(12)' constructs.
            
            let new = VJson.null()
            new.createdBySubscript = true
            add(new, for: key)
            
            return new
        }
    }
    
    
    // Remove empty objects that resulted from subscript access.
    
    internal func removeEmptySubscriptObjects() {
        
        
        // For JSON OBJECTs, remove all name/value pairs that are created by a subscript and do not contain any non-subscript generated value
        
        if type == .object {
            
            
            // Itterate over all name/value pairs
            
            for item in children?.items ?? [] {
                
                
                // Make sure that this value has all its subscript generated values removed
                
                if item.nofChildren > 0 { item.removeEmptySubscriptObjects() }
                
                
                // Remove the value if it is generated by subscript and contains no usefull items
                
                if item.createdBySubscript && item.nofChildren == 0 {
                    _ = children?.remove(item)
                }
            }
            
            return
        }
        
        
        // For JSON ARRAYs, remove all values that are createdby a subscript and do not contain any non-subscript generated value
        
        if type == .array {
            
            
            // This array will contain the indicies of all values that should be removed
            
            var itemsToBeRemoved = [Int]()
            
            
            // Loop over all values, backwards. As soon as a value is hit that cannot be removed, stop iterating
            
            if (children?.count ?? 0) > 0 {
                
                for index in (0 ..< (children?.count ?? 0)).reversed() {
                    
                    if let item = children?[index] {
                        
                        
                        // Make sure that this value has all its subscript generated values removed
                        
                        if item.nofChildren > 0 { item.removeEmptySubscriptObjects() }
                        
                        
                        // If this value is created by subscript, then check if it has content
                        
                        if item.createdBySubscript && item.nofChildren == 0 {
                            itemsToBeRemoved.append(index)
                        } else {
                            break
                        }
                    }
                }
                
                
                // Actually remove items, if any.
                // Note: Because of the reverse loop above, the indexes in itemsToBeRemoved count down.
                
                for i in itemsToBeRemoved { children!.remove(at: i) }
            }
        }
    }
}
