// =====================================================================================================================
//
//  File:       Object.swift
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
// 0.15.0  - Harmonized names, now uses 'item' or 'items' for items contained in OBJECTs instead of 'child'
//           or 'children'. The name 'child' or 'children' is now used exclusively for operations transcending
//           OBJECTs or ARRAYs.
// 0.13.0  - Added escape sequence support
// 0.12.2  - Bugfix, uniqueName no longer appends numbers but updates the number.
// 0.12.1  - Added public to uniqueName:startsWith
// 0.12.0  - Added uniqueName:startsWith
// 0.10.8  - Split off from VJson.swift
//         - The add operations no longer return a value.
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Creates an empty JSON OBJECT item with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: The new VJson item containing a JSON OBJECT.
    
    public static func object(_ name: String? = nil) -> VJson {
        return VJson(type: .object, name: name)
    }
    
    
    /// True if this object contains a JSON OBJECT object.
    
    public var isObject: Bool { return self.type == JType.object }

    
    /// Returns the item with the requested name, if any.
    ///
    /// - Parameters:
    ///   - name: The name of the requested item.
    ///
    /// - Returns: The requested item if it is present, nil otherwise.
    
    public func item(with name: String) -> VJson? {
        guard type == .object else { return nil }
        return self|name
    }
    
    
    /// Return all items with the given name.
    ///
    /// - Parameter with: The name of the sought after items.
    ///
    /// - Returns: An array with the found items, may be empty.
    
    public func items(with name: String) -> [VJson] {
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
    
    public func add(_ item: VJson?, for name: String? = nil, replace: Bool = true) {
        guard let item = item else { return }
        if name == nil && !item.hasName { return }
        undoableUpdate(to: .object)
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
    
    public func add(_ item: VJsonSerializable?, for name: String? = nil, replace: Bool = true) {
        return add(item?.json, for: name, replace: replace)
    }
    
    
    /// Removes all items with the given name from this object only. Self must contain a JSON OBJECT.
    ///
    /// - Parameters:
    ///   - forName: The name of the items to be removed.
    ///
    /// - Returns: The number of items removed.
    
    @discardableResult
    public func removeItems(forName name: String) -> Int {
        guard type == .object else { return 0 }
        recordUndoRedoAction()
        return children?.remove(childrenWith: name.stringToJsonString()) ?? 0
    }
    
    
    /// Creates a unique name by appending a '<joiner><number>' to the given name when necessary. The number will be the lowest possible number that makes the name unique, starting from 1. Self must be a JSON OBJECT.
    ///
    /// - Parameters:
    ///   - startsWith: The string with which the name should start.
    ///   - joiner: The string to use to join the name with the number. Default = '-'
    ///
    /// - Returns: A unique name or nil when self is not an OBJECT.
    
    public func uniqueName(startsWith str: String, joiner: String = "-") -> String? {
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
    
    public convenience init(items: [String:VJson], name: String? = nil) {
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
    
    public convenience init(_ items: [String:VJsonSerializable], name: String? = nil) {
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
