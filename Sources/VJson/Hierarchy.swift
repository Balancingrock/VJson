// =====================================================================================================================
//
//  File:       Hierarchy.swift
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
    
    
    /// Returns the root of this JSON hierarchy.
    
    var root: VJson {
        
        if let parent = parent {
            return parent.root
        } else {
            return self
        }
    }
    
    
    /// Returns the root of the hierarchy and the path from there to this item.
    ///
    /// - Parameter from: The item at which to start the path in the return tuple.
    ///
    /// - Returns: A tuple with the path and the source for that path
    
    func location(from source: VJson? = nil) -> (source: VJson, path: Array<String>)? {
            
            
        // The path that will be returned.
        
        var path: Array<String> = []
        
        
        // The itteration variables
        
        var item: VJson = self
        var next: VJson! = self.parent
        
        
        while true {
            
            
            // Stop when the source item has been reached
            
            if let source = source, item === source { return (source, path) }
            
            
            // Stop when there is no parent
            
            if next == nil {
                if source == nil { return (item, path) }
                return nil
            }
            
            
            // Check if the path part is an array index or a name
            
            if next.isArray {
                
                
                // Determine the array index
                
                let index: Int! = next.index(of: item)
                
                
                // Catch programming error
                
                guard index != nil  else {
                    let message = "Child not contained in parent.\nChild = \(item.code))\n\nParent = \(next.code))"
                    assertionFailure(message)
                    return nil
                }
                
                path.insert(index.description, at: 0)
                
                
            } else {
                
                
                // Determine the path component
                
                let pathPart: String! = item.name
                guard pathPart != nil else {
                    let message = "The child from an object should always have a name.\nChild = \(item.code))\n\nParent = \(next.code))"
                    assertionFailure(message)
                    return nil
                }
                
                path.insert(pathPart, at: 0)
            }
            
            
            // Prepare for the next itteration
            
            item = next
            next = next.parent
        }
    }


    
    /// Looks for an item in the hierachy. If multiple items can be reached at the given path, it is unspecified which item will be returned.
    ///
    /// - Parameters:
    ///   - at: An array of strings describing the path at which the item should exist. Note that integer indexing will convert the string into an index before using. Hence a path of ["12"] can refer to the item at index 12 as well as the item for name "12".
    ///
    /// - Returns: the item at the given path if it exists. Otherwise nil.
    
    func item(at path: [String]) -> VJson? {
        
        if path.count == 0 {
            
            return self
            
        } else {
            
            switch self.type {
                
            case .array:
                
                let i = (path[0] as NSString).integerValue
                
                if i >= self.nofChildren { return nil }
                
                var reducedPath = path
                reducedPath.removeFirst()
                
                return children?.items[i].item(at: reducedPath)
                
                
            case .object:
                
                for child in children?.items ?? [] {
                    if child.name == nil { return nil } // Should not be possible
                    if child.name == path[0] {
                        
                        var reducedPath = path
                        reducedPath.removeFirst()
                        
                        return child.item(at: reducedPath)
                    }
                }
                return nil
                
                
            default: return nil
            }
        }
    }
    
    /// Looks for a specific item in the hierachy.
    ///
    /// - Parameters:
    ///   - at: A set of strings describing the path at which the item should exist. Note that integer indexing will convert the string into an index before using. Hence a path of "12" can refer to the item at index 12 as well as the item for name "12".
    ///
    /// - Returns: the item at the given path if it exists. Otherwise nil.
    
    func item(at path: String ...) -> VJson? {
        return item(at: path)
    }
    
    
    /// Looks for a specific item in the hierachy.
    ///
    /// - Parameters:
    ///   - of: The JSON TYPE of object to look for.
    ///   - at path: An array of strings describing the path at which the item should exist. Note that integer indexing will convert the string into an index before using. Hence a path of ["12"] can refer to the item at index 12 as well as the item for name "12".
    ///
    /// - Returns: the item at the given path if it exists and is of the given type. Otherwise nil.
    
    func item(of type: JType, at path: [String]) -> VJson? {
        
        if let item = item(at: path), item.type == type { return item }
        
        return nil
    }
    
    
    /// Looks for a specific item in the hierachy.
    ///
    /// - Parameters:
    ///   - of: The JSON TYPE of object to look for.
    ///   - at path: A set of strings describing the path at which the item should exist. Note that integer indexing will convert the string into an index before using. Hence a path of "12" can refer to the item at index 12 as well as the item for name "12".
    ///
    /// - Returns: the item at the given path if it exists and is of the given type. Otherwise nil.
    
    func item(of: JType, at path: String ...) -> VJson? {
        return item(of: of, at: path)
    }
    
    
    /// Returns all items at the given path.
    ///
    /// - Parameters:
    ///   - at: The path for the tems to return.
    ///
    /// - Returns: An array with items that can be reached at the given path.
    
    func items(at path: [String]) -> [VJson] {
        
        func items(path: [String], collection: [VJson]) -> [VJson] {
            
            var col: Array<VJson> = []
            
            for j in collection {
                col.append(contentsOf: j.items(at: path))
            }
            
            return col
        }

        
        // If the path is empty, return self
        
        if path.count == 0 { return [self] }
        
        
        // Create a new path that may be updated
        
        var path = path
        
        
        // Action depends on type of self
        
        switch type {
        
        case .object:
        
            
            // Create a collection of items that have the name of the first path part
            
            let id = path.removeFirst()
            var col: Array<VJson> = []
            
            for c in children!.items {
                if let n = c.nameValue, n == id {
                    col.append(c)
                }
            }

            
            // If no items were found, return an empty array
            
            if col.count == 0 { return [] }

            
            // If the path is empty, return the collection
            
            if path.count == 0 { return col }
            
            
            // Repeat the search for the next path part
            
            return items(path: path, collection: col)
            
            
        case .array:
        
            
            // Get the index of the child item
            
            let str = path.removeFirst()
            guard let index = Int(str) else { return [] }
            
            
            // Test validity of the index
            
            if index < 0 || index >= children!.count { return [] }
            
            
            // Get the item for the index
            
            let j = children!.items[index]
            
            
            // If the path is empty, return the item in an array
            
            if path.count == 0 { return [j] }
            
            
            // Repeat the search for the next part of the path
            
            return items(path: path, collection: [j])
            
            
        default:
            
            
            // There is no possible path
            
            return []
        }
    }
}
