// =====================================================================================================================
//
//  File:       Array.swift
//  Project:    VJson
//
//  Version:    0.10.8
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Balancingrock/SwifterJSON
//
//  Copyright:  (c) 2014-2017 Marinus van der Lugt, All rights reserved.
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
// 0.10.8  - Split off from VJson.swift
//         - remove() now returns a bool instead of the removed child.
//         - remove(at) added.
//         - repace(at,with) now returns the replaced child (if any) instead of the inserted child.
//         - insert(child,at) now returns a bool instead of the child and will append for index > nofChildren
//         - The append operations no longer return anything.
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// Creates an empty JSON ARRAY item with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: The new VJson item containing a JSON ARRAY.
    
    public static func array(_ name: String? = nil) -> VJson {
        return VJson(type: .array, name: name)
    }

    
    /// Returns a new VJson object with a JSON ARRAY containing the given items. Only those items that have their 'parent' member set to 'nil' will be included.
    ///
    /// - Parameters:
    ///   - items: An array with VJson objects to be added as children, only those with parent == nil.
    ///   - name: The name for the JSON ARRAY item.
    ///   - includeNil: If true (default = false) then nil items in the array will be included as JSON NULL items.
    
    public convenience init(_ items: [VJson?], name: String? = nil, includeNil: Bool = false) {
        self.init(type: .array, name: name)
        let parentIsNilItems = items.filter(){ return $0?.parent == nil }
        if includeNil {
            self.children?.append(parentIsNilItems.map(){ $0 ?? VJson.null()})
        } else {
            self.children?.append(parentIsNilItems.flatMap(){$0})
        }
    }
    
    
    /// Returns a new VJson object with a JSON ARRAY containing the given items.
    ///
    /// - Parameters:
    ///   - items: An array with VJson objects to be added as children.
    ///   - name: The name for the contained item (optional).
    ///   - includeNil: If true (default = false) then nil items in the array will be included as JSON NULL items.
    
    public convenience init(_ items: [VJsonSerializable?], name: String? = nil, includeNil: Bool = false) {
        self.init(items.map({$0?.json}), name: name, includeNil: includeNil)
    }

    
    /// True if this object contains a JSON ARRAY object.
    
    public var isArray: Bool { return self.type == JType.array }

    
    /// Returns the child at the given index if it exists. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - at: The index of the requested child.
    ///
    /// - Returns: The object or nil if no object exists at the given index. If self is not an array, it also returns nil.
    
    public func child(at index: Int) -> VJson? {
        guard type == .array else { return nil }
        return self|index
    }
    
    
    /// The index of the given child. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - of: The child to find the index of.
    ///
    /// - Returns: The index of the child if it is present. Nil if none was found.
    
    public func index(of child: VJson?) -> Int? {
        guard let child = child else { return nil }
        guard type == .array else { return nil }
        return children?.index(of: child)
    }
    
    
    /// The indicies of the children with identical contents as the given child. An empty array if no comparable child is found. Self must be a JSON ARRAY item.
    ///
    /// - Parameters:
    ///   - ofChildEqualTo: The child to compare the content with.
    ///
    /// - Returns: The indicies of the child items with the same content. An empty array if none was found.
    
    public func index(ofChildrenEqualTo item: VJson?) -> [Int] {
        guard let item = item else { return [] }
        guard type == .array else { return [] }
        return children?.index(ofChildrenEqualTo: item) ?? []
    }
    
    
    /// Removes the given object from self. Self must be a JSON ARRAY. Is undoable.
    ///
    /// - Parameters:
    ///   - item: The child object to remove.
    ///
    /// - Returns: True if successful, false otherwise.
    
    @discardableResult
    public func remove(_ item: VJson?) -> Bool {
        guard type == .array else { return false }
        if let index = children?.index(of: item) {
            recordUndoRedoAction()
            return children?.remove(at: index) != nil
        } else {
            return false
        }
    }
    
    
    /// Removes the given object from self. Self must be a JSON ARRAY. Is undoable.
    ///
    /// - Parameters:
    ///   - item: The child object to remove.
    ///
    /// - Returns: True if successful, false otherwise.
    
    @discardableResult
    public func remove(at index: Int) -> VJson? {
        guard type == .array else { return nil }
        recordUndoRedoAction()
        return children?.remove(at: index)
    }

    
    /// Replaces the child at the given index with the given child. Self must be a JSON ARRAY. Is undoable.
    ///
    /// - Parameters:
    ///   - at: The index of the child to be replaced.
    ///   - with: The VJson object to be inserted.
    ///
    /// - Returns: The replaced child, or nil if an error occured.
    
    @discardableResult
    public func replace(at index: Int, with child: VJson?) -> VJson? {
        guard let child = child else { return nil }
        guard type == .array else { return nil }
        recordUndoRedoAction()
        return children?.replace(at: index, with: child)
    }
    
    
    /// Inserts the given child at the given index. Self must be a JSON ARRAY. Is Undoable.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be inserted.
    ///   - at index: The index at which it will be inserted. The index must exist, insertion will fail for non-existing indexes.
    ///
    /// - Returns: True if the insertion was succesful. False if not.
    
    @discardableResult
    public func insert(_ child: VJson?, at index: Int) -> Bool {
        guard let child = child else { return false }
        guard type == .array else { return false }
        guard index < nofChildren else { return false }
        recordUndoRedoAction()
        return children?.insert(child, at: index) ?? false
    }
    
    
    /// Appends the given object to the end of the array. Self must be a JSON ARRAY or the type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be appended.
    
    @discardableResult
    public func append(_ child: VJson?) {
        guard let child = child else { return }
        if VJson.typeChangeIsAllowed(from: type, to: .array) { undoableUpdate(to: .array) }
        guard type == .array else { return }
        recordUndoRedoAction()
        children?.append(child)
    }
    
    
    /// Appends the given object to the end of the array. Self must be a JSON ARRAY or or the type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be appended.
    
    @discardableResult
    public func append(_ item: VJsonSerializable?) {
        guard let item = item else { return }
        if VJson.typeChangeIsAllowed(from: type, to: .array) { undoableUpdate(to: .array) }
        guard type == .array else { return }
        recordUndoRedoAction()
        children?.append(item.json)
    }
    
    
    /// Appends the given objects to the end of the array. Self must be a JSON ARRAY or the type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - children: The items to add.
    ///   - includeNil: If true, a NULL will be added for each 'nil' in the array.
    
    public func append(_ items: [VJson?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        if VJson.typeChangeIsAllowed(from: type, to: .array) { undoableUpdate(to: .array) }
        guard type == .array else { return }
        recordUndoRedoAction()
        items.forEach() {
            if $0 == nil {
                if includeNil { _ = children?.append(VJson.null()) }
            } else {
                _ = children?.append($0)
            }
        }
    }
    
    
    /// Appends the given objects to the end of the array. Self must be a JSON ARRAY or the type change must be allowed. Is undoable.
    ///
    /// - Parameters:
    ///   - children: The items to add.
    ///   - includeNil: If true, a NULL will be added for each 'nil' in the array.
    
    public func append(_ items: [VJsonSerializable?]?, includeNil: Bool = false) {
        guard let items = items else { return }
        let newItems = items.map() { $0?.json }
        append(newItems, includeNil: includeNil)
    }
}
