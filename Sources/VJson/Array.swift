// =====================================================================================================================
//
//  File:       Array.swift
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
    
    
    /// Creates an empty VJson ARRAY with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: An empty VJson ARRAY.
    
    static func array(_ name: String? = nil) -> VJson {
        return VJson(type: .array, name: name)
    }

    
    /// Returns a VJson ARRAY containing the given items. Only those items that have their 'parent' member set to 'nil' will be included.
    ///
    /// - Parameters:
    ///   - items: An array with items to be added (only if the item.parent == nil).
    ///   - name: The name for the VJson ARRAY.
    ///   - includeNil: If true (default = false) then nil items in the array will be included as VJson NULL items.
    
    convenience init(_ items: [VJson?], name: String? = nil, includeNil: Bool = false) {
        self.init(type: .array, name: name)
        let parentIsNilItems = items.filter(){ return $0?.parent == nil }
        if includeNil {
            self.children?.append(parentIsNilItems.map(){ $0 ?? VJson.null()})
        } else {
            self.children?.append(parentIsNilItems.compactMap(){$0})
        }
    }
    
    
    /// Returns a VJson ARRAY containing the given items.
    ///
    /// - Parameters:
    ///   - items: An array with items to be added.
    ///   - name: The name for the VJson ARRAY (optional).
    ///   - includeNil: If true (default = false) then nil items in the array will be included as VJson NULL items.
    
    convenience init(_ items: [VJsonSerializable?], name: String? = nil, includeNil: Bool = false) {
        self.init(items.map({$0?.json}), name: name, includeNil: includeNil)
    }

    
    /// True if this VJson object contains a JSON ARRAY.
    
    var isArray: Bool { return self.type == JType.array }

    
    /// Returns the item at the given index if it exists. Self must contain a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - at: The index of the requested item.
    ///
    /// - Returns: A VJson object with the requested item or nil if no item exists at the given index. Also returns nil if self does not contain a JSON ARRAY.
    
    func item(at index: Int) -> VJson? {
        guard isArray else { return nil }
        return self|index
    }
    
    
    /// The index of the given item. Self must contain a JSON ARRAY.
    ///
    /// - Parameters:
    ///   - of: The item to find the index of.
    ///
    /// - Returns: The index of the item if it is present. Nil if none was found or self does not contain a JSON ARRAY.
    
    func index(of item: VJson?) -> Int? {
        guard isArray else { return nil }
        guard let item = item else { return nil }
        return children?.index(of: item)
    }
    
        
    /// Inserts the given item at the given index. Self must contain a JSON ARRAY. Is Undoable.
    ///
    /// - Parameters:
    ///   - item: The item to be inserted.
    ///   - at index: The index at which the item will be inserted. The index must exist, insertion will fail for non-existing indexes.
    ///
    /// - Returns: True if the insertion was succesful. False if not.
    
    @discardableResult
    func insert(_ item: VJson?, at index: Int) -> Bool {
        guard let item = item else { return false }
        guard isArray else { return false }
        return children?.insert(item, at: index) ?? false
    }

    
    /// Removes the given object from self. Self must contain a JSON ARRAY. Is undoable.
    ///
    /// - Parameters:
    ///   - item: The item object to remove.
    ///
    /// - Returns: The item that was removed. Nil if the index is out of range.
    
    @discardableResult
    func remove(at index: Int) -> VJson? {
        guard isArray else { return nil }
        return children?.remove(at: index)
    }

    
    /// Replaces the item at the given index with the given item. Self must contain a JSON ARRAY. Is undoable.
    ///
    /// - Parameters:
    ///   - at: The index of the item to be replaced.
    ///   - with: The item to be inserted.
    ///
    /// - Returns: The replaced item, or nil if an error occured.
    
    @discardableResult
    func replace(at index: Int, with item: VJson?) -> VJson? {
        guard isArray else { return nil }
        guard let item = item else { return nil }
        return children?.replace(at: index, with: item)
    }
    
    
    /// Move an item to a new location. Is unodable.
    ///
    /// - Parameters:
    ///   - from: The index of the item to move.
    ///   - to: The new location for the item.
    ///
    /// - Returns: True when successful, false when not.
    
    @discardableResult
    func move(from source: Int, to destination: Int) -> Bool {
        guard type == .array else { return false }
        guard (source >= 0) && (source < nofChildren) else { return false }
        guard (destination >= 0) && (destination < nofChildren) else { return false }
        if source == destination { return true }
        
        // The undo actions are performed in the remove and insert operations
        
        guard let item = remove(at: source) else { return false }
        if source < destination {
            insert(item, at: destination - 1)
        } else {
            insert(item, at: destination)
        }
        return true
    }
    
    
    /// Appends the given item to the end of the array. Self must contain a JSON ARRAY or a type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - item: The item to be appended.
    
    func append(_ item: VJson?) {
        guard let item = item else { return }
        if type != .array { type = .array }
        guard type == .array else { return }
        children?.append(item)
    }
    
    
    /// Appends the given item to the end of the array. Self must contain a JSON ARRAY or a type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - item: The item to be appended.
    
    func append(_ item: VJsonSerializable?) {
        guard let item = item else { return }
        if type != .array { type = .array }
        guard type == .array else { return }
        children?.append(item.json)
    }
    
    
    /// Appends the given items to the end of the array. Self must contain a JSON ARRAY or a type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - items: The items to add.
    ///   - includeNil: If true, a VJson NULL will be added for each 'nil' in the array.
    
    func append(_ items: [VJson?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        if type != .array { type = .array }
        guard type == .array else { return }
        items.forEach() {
            if $0 == nil {
                if includeNil { _ = children?.append(VJson.null()) }
            } else {
                _ = children?.append($0)
            }
        }
    }
    
    
    /// Appends the given items to the end of the array. Self must contain a JSON ARRAY or a type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - items: The items to add.
    ///   - includeNil: If true, a VJson NULL will be added for each 'nil' in the array.
    
    func append(_ items: [VJsonSerializable?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        let newItems = items.map() { $0?.json }
        append(newItems, includeNil: includeNil)
    }
}
