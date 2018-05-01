// =====================================================================================================================
//
//  File:       ArrayObject.swift
//  Project:    VJson
//
//  Version:    0.12.0
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
// 0.12.0 - Moved insert:child:at from Array.swift to here. Made the operation suitable for JSON OBJECTS.
// 0.11.4 - Added remove:child
// 0.10.8 - Split off from VJson.swift
//        - dictionaryValue now also returns those children from an ARRAY type that have a name
// =====================================================================================================================

import Foundation


public extension VJson {
    

    /// Returns a copy of the child items in this object if this object contains a JSON ARRAY or JSON OBJECT. An empty array for all other JSON types.
    
    public var arrayValue: Array<VJson> {
        guard type == .array || type == .object else { return [] }
        var arr: Array<VJson> = []
        children?.items.forEach(){ arr.append($0.duplicate) }
        return arr
    }

    
    /// Returns a copy of the children that have their name property set in a dictionary if this object contains a JSON OBJECT or JSON ARRAY. An empty dictionary for all other JSON types.
    
    public var dictionaryValue: Dictionary<String, VJson> {
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
    
    public var hasChildren: Bool {
        return (children?.count ?? 0) > 0
    }
    
    
    /// The number of child items this object contains.
    
    public var nofChildren: Int {
        return children?.count ?? 0
    }
    
    
    /// Removes all children from either ARRAY or OBJECT. Is undoable.
    
    public func removeAllChildren() {
        recordUndoRedoAction()
        children?.removeAll()
    }
    
    
    /// Inserts the given child at the given index. Self must be a JSON ARRAY or JSON OBJECT. Is Undoable. If self is a JSON OBJECT then the name of the child must have been set.
    ///
    /// - Parameters:
    ///   - child: The VJson object to be inserted.
    ///   - at index: The index at which it will be inserted. The index must exist, insertion will fail for non-existing indexes.
    ///
    /// - Returns: True if the insertion was succesful. False if not.
    
    @discardableResult
    public func insert(_ child: VJson?, at index: Int) -> Bool {
        guard let child = child else { return false }
        guard index < nofChildren else { return false }
        guard isArray || (isObject && child.hasName) else { return false }
        recordUndoRedoAction()
        return children?.insert(child, at: index) ?? false
    }
    
    
    /// Remove the given child from the children (if present).
    ///
    /// - Note: The child must be an actual child of self. I.e. the comparison is made using object references.
    ///
    /// - Returns: True if the child was removed.
    
    public func remove(_ child: VJson) -> Bool {
        guard let i = children?.index(of: child) else { return false }
        recordUndoRedoAction()
        children?.remove(at: i)
        return true
    }
    
    
    /// Removes the child items from self that are equal to the given item. Self must be an ARRAY or OBJECT. Is undoable.
    ///
    /// - Note: The parent is not compared when testing for equal.
    ///
    /// - Parameters:
    ///   - childrenEqualTo: The item to compare against.
    ///
    /// - Returns: The number of child items removed.
    
    public func remove(childrenEqualTo item: VJson?) -> Int {
        guard type == .array || type == .object else { return 0 }
        var count = 0
        if let indicies = children?.index(ofChildrenEqualTo: item) {
            recordUndoRedoAction()
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
    /// - Note: Is not undoable.
    
    public var enableCacheForObjects: Bool {
        set { children?.cacheEnabled = newValue }
        get { return children?.cacheEnabled ?? false}
    }

    
    /// Returns a new VJson object with a JSON OBJECT containing the items from the dictionary. Only those items that have their 'parent' member set to 'nil' will be included.
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
    
    
    /// Returns a new VJson object with a JSON OBJECT containing the items from the dictionary.
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