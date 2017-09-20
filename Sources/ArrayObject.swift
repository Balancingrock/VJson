// =====================================================================================================================
//
//  File:       ArrayObject.swift
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
    
    
    /// Creates an empty JSON OBJECT item with the given name (if any).
    ///
    /// - Parameter name: The name for the item (optional).
    ///
    /// - Returns: The new VJson item containing a JSON OBJECT.
    
    public static func object(_ name: String? = nil) -> VJson {
        return VJson(type: .object, name: name)
    }
    
    
    /// True if this object contains a JSON ARRAY object.
    
    public var isArray: Bool { return self.type == JType.array }
    
    
    /// True if this object contains a JSON OBJECT object.
    
    public var isObject: Bool { return self.type == JType.object }
    

    /// Returns a copy of the child items in this object if this object contains a JSON ARRAY or JSON OBJECT. An empty array for all other JSON types.
    
    public var arrayValue: Array<VJson> {
        guard type == .array || type == .object else { return [] }
        var arr: Array<VJson> = []
        children?.items.forEach(){ arr.append($0.duplicate) }
        return arr
    }

    
    /// Returns a copy of the children in a dictionary if this object contains a JSON OBJECT. An empty dictionary for all other JSON types.
    
    public var dictionaryValue: Dictionary<String, VJson> {
        if type != .object { return [:] }
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
    
    
    /// Removes all children from either ARRAY or OBJECT
    
    public func removeAllChildren() {
        recordUndoRedoAction()
        children?.removeAll()
    }
    
    
    /// Removes the child items from self that are equal to the given item. Self must be an ARRAY or OBJECT.
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
    
    public var enableCacheForObjects: Bool {
        set { children?.cacheEnabled = newValue }
        get { return children?.cacheEnabled ?? false}
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
