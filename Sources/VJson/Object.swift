// =====================================================================================================================
//
//  File:       Object.swift
//  Project:    VJson
//
//  Version:    0.10.8
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
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

    
    /// Returns the child with the requested name, if any.
    ///
    /// - Parameters:
    ///   - name: The name of the requested child.
    ///
    /// - Returns: The requested child if it is present, nil otherwise.
    
    public func child(with name: String) -> VJson? {
        guard type == .object else { return nil }
        return self|name
    }
    
    
    /// Return all children with the given name. The count will be zero if no child with the given name exists.
    ///
    // - Parameter with: The name of the sought after child items.
    ///
    /// - Returns: An array with the found child items, may be empty.
    
    public func children(with name: String) -> [VJson] {
        guard type == .object else { return [] }
        return self.children?.items.filter(){ $0.name == name } ?? []
    }
    
    
    /// Add a new item with the given name or replace a current item with that same name (when "replace" = 'true'). Self must contain a JSON OBJECT item or a NULL. If it is a NULL it will be converted into an OBJECT.
    ///
    /// - Parameters:
    ///   - child: The child that should replace or be appended. The child must have a name or a name must be provided in the parameter "for name". If a name is provided in "for name" then that name will take precedence and replace the name contained in the child item.
    ///   - name: If nil, the child must already have a name. If non-nil, then this name will be used and the name of the child (if present) will be overwritten.
    ///   - replace: If 'true' (default) it will replace all existing items with the same name. If 'false', then the child will be added and no check on duplicate names will be performed.
    
    public func add(_ child: VJson?, for name: String? = nil, replace: Bool = true) {
        guard let child = child else { return }
        if name == nil && !child.hasName { return }
        undoableUpdate(to: .object)
        if name != nil { child.name = name }
        if replace { children?.remove(childrenWith: child.name) }
        children?.append(child)
    }
    
    
    /// Add a new item with the given name or replace a current item with that same name (when "replace" = 'true'). Self must contain a JSON OBJECT item or a NULL. If it is a NULL it will be converted into an OBJECT.
    ///
    /// - Parameters:
    ///   - child: The child that should replace or be appended. The child must have a name or a name must be provided in the parameter "for name". If a name is provided in "for name" then that name will take precedence and replace the name contained in the child item.
    ///   - name: If nil, the child must already have a name. If non-nil, then this name will be used and the name of the child (if present) will be overwritten.
    ///   - replace: If 'true' (default) it will replace all existing items with the same name. If 'false', then the child will be added and no check on duplicate names will be performed.
    
    public func add(_ item: VJsonSerializable?, for name: String? = nil, replace: Bool = true) {
        return add(item?.json, for: name, replace: replace)
    }
    
    
    /// Removes all children with the given name from this object only. Self must contain a JSON OBJECT.
    ///
    /// - Parameters:
    ///   - childrenWith: The name of the child items to be removed.
    ///
    /// - Returns: The number of children removed.
    
    @discardableResult
    public func remove(childrenWith name: String) -> Int {
        guard type == .object else { return 0 }
        recordUndoRedoAction()
        return children?.remove(childrenWith: name) ?? 0
    }
}
