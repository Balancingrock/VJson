// =====================================================================================================================
//
//  File:       Object.swift
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
    
    
    /// Creates an empty JSON OBJECT item with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: The new VJson item containing a JSON OBJECT.
    
    static func object(_ name: String? = nil) -> VJson {
        return VJson(type: .object, name: name)
    }
    
    
    /// True if this object contains a JSON OBJECT object.
    
    var isObject: Bool { return self.type == JType.object }

    
    /// Returns the item with the requested name, if any.
    ///
    /// - Parameters:
    ///   - name: The name of the requested item.
    ///
    /// - Returns: The requested item if it is present, nil otherwise.
    
    func item(with name: String) -> VJson? {
        guard type == .object else { return nil }
        return self|name
    }
    
    
    /// Return all items with the given name.
    ///
    /// - Parameter with: The name of the sought after items.
    ///
    /// - Returns: An array with the found items, may be empty.
    
    func items(with name: String) -> [VJson] {
        guard type == .object else { return [] }
        let jname = name.stringToJsonString()
        return self.children?.items.filter(){ $0.name == jname } ?? []
    }
    
    
    /// Add a new item with the given name or replace a current item with that same name (when "replace" = 'true'). Self must contain a JSON OBJECT item or a NULL. If it is a NULL it will be converted into an OBJECT.
    ///
    /// - Parameters:
    ///   - item: The item that should replace or be appended. The item must have a name or a name must be provided in the parameter "for name". If a name is provided in "for name" then that name will take precedence and replace the name contained in the item.
    ///   - name: If nil, the item must already have a name. If non-nil, then this name will be used and the name of the item (if present) will be overwritten.
    ///   - replace: If 'true' (default) it will replace all existing items with the same name. If 'false', then the item will be added and no check on duplicate names will be performed.
    
    func add(_ item: VJson?, for name: String? = nil, replace: Bool = true) {
        guard let item = item else { return }
        if name == nil && !item.hasName { return }
        if type != .object { type = .object }
        if name != nil { item.name = name?.stringToJsonString() }
        if replace { children?.remove(childrenWith: item.name) }
        children?.append(item)
    }
    
    
    /// Add a new item with the given name or replace a current item with that same name (when "replace" = 'true'). Self must contain a JSON OBJECT item or a NULL. If it is a NULL it will be converted into an OBJECT.
    ///
    /// - Parameters:
    ///   - item: The item that should replace or be appended. The item must have a name or a name must be provided in the parameter "for name". If a name is provided in "for name" then that name will take precedence and replace the name contained in the item.
    ///   - name: If nil, the item must already have a name. If non-nil, then this name will be used and the name of the item (if present) will be overwritten.
    ///   - replace: If 'true' (default) it will replace all existing items with the same name. If 'false', then the item will be added and no check on duplicate names will be performed.
    
    func add(_ item: VJsonSerializable?, for name: String? = nil, replace: Bool = true) {
        return add(item?.json, for: name, replace: replace)
    }
    
    
    /// Removes all items with the given name from this object only. Self must contain a JSON OBJECT.
    ///
    /// - Parameters:
    ///   - forName: The name of the items to be removed.
    ///
    /// - Returns: The number of items removed.
    
    @discardableResult
    func removeItems(forName name: String) -> Int {
        guard type == .object else { return 0 }
        return children?.remove(childrenWith: name.stringToJsonString()) ?? 0
    }
    
    
    /// Creates a unique name by appending a '<joiner><number>' to the given name when necessary. The number will be the lowest possible number that makes the name unique, starting from 1. Self must be a JSON OBJECT.
    ///
    /// - Parameters:
    ///   - startsWith: The string with which the name should start.
    ///   - joiner: The string to use to join the name with the number. Default = '-'
    ///
    /// - Returns: A unique name or nil when self is not an OBJECT.
    
    func uniqueName(startsWith str: String, joiner: String = "-") -> String? {
        guard isObject else { return nil }
        var uniqueName = str
        var count = 1
        while self|uniqueName != nil {
            uniqueName = "\(str)\(joiner)\(count)"
            count += 1
        }
        return uniqueName
    }
    
    
    /// Returns a VJson object with a JSON OBJECT containing the items from the dictionary. Only those items that have their 'parent' member set to 'nil' will be included.
    ///
    /// - Parameters:
    ///   - items: A dictionary with the name/value pairs to be included as children.
    ///   - name: The name for the contained item (optional).
    
    convenience init(items: [String:VJson], name: String? = nil) {
        self.init(type: .object, name: name)
        var newItems: Array<VJson> = []
        let parentIsNilItems = items.filter(){ return $0.value.parent == nil }
        for (pname, item) in parentIsNilItems {
            item.name = pname
            newItems.append(item)
        }
        self.children?.append(newItems)
    }
    
    
    /// Returns a VJson object with a JSON OBJECT containing the items from the dictionary.
    ///
    /// - Parameters:
    ///   - items: A dictionary with the name/value pairs to be included as children.
    ///   - name: The name for the contained item (optional).
    
    convenience init(_ items: [String:VJsonSerializable], name: String? = nil) {
        self.init(type: VJson.JType.object, name: name)
        var newItems: [VJson] = []
        for (name, item) in items {
            let jitem = item.json
            jitem.name = name
            newItems.append(jitem)
        }
        self.children?.append(newItems)
    }

}
