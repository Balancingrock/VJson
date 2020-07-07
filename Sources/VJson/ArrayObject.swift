// =====================================================================================================================
//
//  File:       ArrayObject.swift
//  Project:    VJson
//
//  Version:    1.3.4
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2020 Marinus van der Lugt, All rights reserved.
//
//  License:    MIT, see LICENSE file
//
//  And because I need to make a living:
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
// 1.3.4 - Updated LICENSE
// 1.0.0 - Removed older history
// =====================================================================================================================

import Foundation


public extension VJson {
    

    /// Returns a copy of the child items in this object if this object contains a JSON ARRAY or JSON OBJECT. An empty array for all other JSON types.
    
    var arrayValue: Array<VJson> {
        if nofChildren == 0 { return [] }
        var arr: Array<VJson> = []
        children?.items.forEach(){ arr.append($0.duplicate) }
        return arr
    }

    
    /// Returns a copy of the children that have their name property set in a dictionary if this object contains a JSON OBJECT or JSON ARRAY. An empty dictionary for all other JSON types.
    
    var dictionaryValue: Dictionary<String, VJson> {
        if nofChildren == 0 { return [:] }
        var dict: Dictionary<String, VJson> = [:]
        children?.items.forEach(){
            if let name = $0.name {
                dict[name] = $0.duplicate
            }
        }
        return dict
    }

    
    /// True if this item contains any childeren. False if this item does not have any children.
    
    var hasChildren: Bool {
        return (children?.count ?? 0) > 0
    }
    
    
    /// The number of child items this object contains.
    
    var nofChildren: Int {
        return children?.count ?? 0
    }
    
    
    /// Removes all children from either ARRAY or OBJECT. Is undoable.
    
    func removeAllChildren() {
        children?.removeAll()
    }
    
    
    /// Inserts the given child at the given index. Self must contain a JSON ARRAY or JSON OBJECT. Is Undoable. If self contains a JSON OBJECT then the child must have a name.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be inserted.
    ///   - at index: The index at which it will be inserted. The index must exist, insertion will fail for non-existing indexes.
    ///
    /// - Returns: True if the insertion was succesful. False if not.
    
    @discardableResult
    func insertChild(_ child: VJson?, at index: Int) -> Bool {
        guard let child = child else { return false }
        guard isArray || (isObject && child.hasName) else { return false }
        return children?.insert(child, at: index) ?? false
    }
    
    
    /// Appends the given child at the end. Self must contain a JSON ARRAY or JSON OBJECT. Is Undoable. If self contains a JSON OBJECT then the child must have a name.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be appended.
    ///   - at index: The index at which it will be inserted. The index must exist, insertion will fail for non-existing indexes.
    ///
    /// - Returns: True if the insertion was succesful. False if not.
    
    @discardableResult
    func appendChild(_ child: VJson?) -> Bool {
        guard let child = child else { return false }
        guard isArray || (isObject && child.hasName) else { return false }
        children?.append(child)
        return children != nil
    }

    
    /// Remove the given child from the children (if present). Self must contain a JSON ARRAY or JSON OBJECT.
    ///
    /// - Note: The child must be an actual child of self. I.e. the comparison is made using object references.
    ///
    /// - Returns: True if the child was removed.
    
    func removeChild(_ child: VJson) -> Bool {
        guard let i = children?.index(of: child) else { return false }
        children?.remove(at: i)
        return true
    }
    
    
    /// Removes the child items from self that are equal to the given item. Self must contain an ARRAY or OBJECT. Is undoable.
    ///
    /// - Note: The parent is not compared when testing for equal.
    ///
    /// - Parameters:
    ///   - childrenEqualTo: The item to compare against.
    ///
    /// - Returns: The number of child items removed.
    
    func removeChildren(equalTo item: VJson?) -> Int {
        guard type == .array || type == .object else { return 0 }
        var count = 0
        if let indicies = children?.index(ofChildrenEqualTo: item) {
            for index in indicies.reversed() {
                _ = children?.remove(at: index)
                count += 1
            }
        }
        return count
    }

    
    /// Controls the status of the dictionary cache for JSON OBJECTs. The dictionary cache can be used to speed up subscript access. As a ROM when looking for an OBJECT members 3 times or more, the cache will pay back its overhead. In some cases 2 times may be enough. More than 3 times is generally always quicker with cache enabled.
    ///
    /// - Note: The dictionary cache will speed up access for OBJECT members, but will "lose" members with duplicate names. I.e. a {"one":1, "one":2} object will only contain {"one":2} when caching is enabled. However the lost member is still present in the "children" array and will be saved (or be part of the generated code).
    ///
    /// - Note: The cache will be reset on every write access.
    
    var enableCacheForObjects: Bool {
        set { children?.cacheEnabled = newValue }
        get { return children?.cacheEnabled ?? false}
    }
}
