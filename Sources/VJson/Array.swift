// =====================================================================================================================
//
//  File:       Array.swift
//  Project:    VJson
//
//  Version:    0.15.3
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
// History
//
// 0.15.3 - Reimplemented undo/redo
// 0.15.0 - Moved the insert:at operation from ArrayObject to this file and made it array specific.
//          Removed remove:
//          Harmonized names, now uses 'item' or 'items' for items contained in OBJECTs instead of 'child'
//          or 'children'. The name 'child' or 'children' is now used exclusively for operations transcending
//          OBJECTs or ARRAYs.
//          General overhaul of comments and documentation.
// 0.12.0 - Moved insert:child:at to ArrayObject.swift.
// 0.11.2 - Added move:from:to
// 0.10.8 - Split off from VJson.swift
//        - remove() now returns a bool instead of the removed child.
//        - remove:at added.
//        - repace:at:with now returns the replaced child (if any) instead of the inserted child.
//        - insert:child:at now returns a bool instead of the child and will append for index > nofChildren
//        - The append operations no longer return anything.
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Creates an empty VJson ARRAY with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: An empty VJson ARRAY.
    
    public static func array(_ name: String? = nil) -> VJson {
        return VJson(type: .array, name: name)
    }

    
    /// Returns a VJson ARRAY containing the given items. Only those items that have their 'parent' member set to 'nil' will be included.
    ///
    /// - Parameters:
    ///   - items: An array with items to be added (only if the item.parent == nil).
    ///   - name: The name for the VJson ARRAY.
    ///   - includeNil: If true (default = false) then nil items in the array will be included as VJson NULL items.
    
    public convenience init(_ items: [VJson?], name: String? = nil, includeNil: Bool = false) {
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
    
    public convenience init(_ items: [VJsonSerializable?], name: String? = nil, includeNil: Bool = false) {
        self.init(items.map({$0?.json}), name: name, includeNil: includeNil)
    }

    
    /// True if this VJson object contains a JSON ARRAY.
    
    public var isArray: Bool { return self.type == JType.array }

    
    /// Returns the item at the given index if it exists. Self must contain a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - at: The index of the requested item.
    ///
    /// - Returns: A VJson object with the requested item or nil if no item exists at the given index. Also returns nil if self does not contain a JSON ARRAY.
    
    public func item(at index: Int) -> VJson? {
        guard isArray else { return nil }
        return self|index
    }
    
    
    /// The index of the given item. Self must contain a JSON ARRAY.
    ///
    /// - Parameters:
    ///   - of: The item to find the index of.
    ///
    /// - Returns: The index of the item if it is present. Nil if none was found or self does not contain a JSON ARRAY.
    
    public func index(of item: VJson?) -> Int? {
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
    public func insert(_ item: VJson?, at index: Int) -> Bool {
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
    public func remove(at index: Int) -> VJson? {
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
    public func replace(at index: Int, with item: VJson?) -> VJson? {
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
    public func move(from source: Int, to destination: Int) -> Bool {
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
    
    public func append(_ item: VJson?) {
        guard let item = item else { return }
        if VJson.typeChangeIsAllowed(from: type, to: .array) { undoableUpdate(to: .array) }
        guard type == .array else { return }
        children?.append(item)
    }
    
    
    /// Appends the given item to the end of the array. Self must contain a JSON ARRAY or a type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - item: The item to be appended.
    
    public func append(_ item: VJsonSerializable?) {
        guard let item = item else { return }
        if VJson.typeChangeIsAllowed(from: type, to: .array) { undoableUpdate(to: .array) }
        guard type == .array else { return }
        children?.append(item.json)
    }
    
    
    /// Appends the given items to the end of the array. Self must contain a JSON ARRAY or a type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - items: The items to add.
    ///   - includeNil: If true, a VJson NULL will be added for each 'nil' in the array.
    
    public func append(_ items: [VJson?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        if VJson.typeChangeIsAllowed(from: type, to: .array) { undoableUpdate(to: .array) }
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
    
    public func append(_ items: [VJsonSerializable?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        let newItems = items.map() { $0?.json }
        append(newItems, includeNil: includeNil)
    }
}
