// =====================================================================================================================
//
//  File:       Object.swift
//  Project:    VJson
//
//  Version:    1.3.3
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2020 Marinus van der Lugt, All rights reserved.
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
// 1.3.3 - Fixed a bug in unflatten where the name of a child in an array was not nilled.
// 1.1.0 - Added flatten and unflatten operations
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


public extension VJson {

    
    /// Options that can be used to flatten a JSON OBJECT
    
    enum FlattenOptions {
        
        
        /// The separator to be used between flattened name components (not arrays)
        ///
        /// - Note: Will cause problems during unflatten when the separator and one of the sides of an array indicator are using the same character.
        ///
        /// Default = "."
        
        case separator(Character)
        
        
        /// The character to be used for the left side of an array indicator in a flattened name.
        ///
        /// - Note: Will cause problems during unflatten when the separator and this indicator are using the same character.
        ///
        /// Default = "["
        
        case leftArray(Character)


        /// The character to be used for the right side of an array indicator in a flattened name.
        ///
        /// - Note: Will cause problems during unflatten when the separator and this indicator are using the same character.
        ///
        /// Default = "]"

        case rightArray(Character)
        
        
        /// When used, will set the separator and leftArray to "." and rightArray will be empty.
        ///
        /// - Note: This will cause problems during unflatten if a name consist of only numbers or has a dot in it.
        
        case useDotArray
        
        
        /// If true, an array containing only elements of the types NONE, BOOL, NUMBER and/or STRING will be kept as an array

        case keepPrimitiveArray
    }
    
    
    /// Will flatten this object if it is a JSON OBJECT according to the options given.
    ///
    /// - Note: While it is always possible to flatten, it __may__ be impossible to unflatten and get back to the same JSON hierarchy as the one that was used to flatten. This happens when flatten options and/or existing names collide. To guarantee reversability be sure that no name contains a separator or leftArray or rightArray character, and that the seperator, leftArray and rightArray are all different.
    ///
    /// - Parameters options: The options to be applied to the flattening process. See enum definition.

    func flatten(_ options: FlattenOptions...) {
        
        // Only flatten JSON OBJECTS
        
        guard isObject else { return }

        
        // Process options
        
        let settings = FlattenSettings(options)
        
        
        // Flatten all childeren that are either an ARRAY or OBJECT
        
        self.forEach { (child: VJson) in
            
            switch child.type {
            
            case .null, .bool, .number, .string: break
                
            case .array:
                
                if !settings.keepPrimitiveArray || !child.isPrimitiveArray {
                    
                    
                    // Flatten the array
                    
                    flattenArray(array: child, addTo: self, flattenedParentName: child.name!, settings)
                    
                    
                    // Remove the array from self.
                    
                    _ = removeChild(child)
                }

                
            case .object:
                
                // Flatten the object
                
                flattenObject(object: child, addTo: self, flattenedParentName: child.name!, settings)
                
                
                // Remove the object from self.
                
                _ = removeChild(child)
            }
        }
    }
    
    
    /// Self is a primitive array if it does not contain either an ARRAY or an OBJECT.
    ///
    /// Also returns false if self is not an ARRAY.
    
    var isPrimitiveArray: Bool {
        guard isArray else { return false }
        for element in children!.items {
            if element.isArray || element.isObject { return false }
        }
        return true
    }
    
    
    /// Will attempt to recreate a (V)JSON hierarchy by unflattening the names of the items in this OBJECT.
    ///
    /// - Note: While it is always possible to flatten, it __may__ be impossible to unflatten and get back to the same JSON hierarchy as the one that was used to flatten. This happens when flatten options and/or existing names collide. To guarantee reversability be sure that no name contains a separator or leftArray or rightArray character, and that the seperator, leftArray and rightArray are all different and not empty.
    ///
    /// - Parameters options: The options to be applied to the unflattening process. See enum definition.

    
    func unflatten(_ options: FlattenOptions...) {
        
        // Only for JSON OBJECTS
        
        guard isObject else { return }

        
        // Process options
        
        let settings = FlattenSettings(options)

        
        // Process the names of all children
        
        forEach { (child: VJson) in
            
            var path = getPath(for: child.name!, using: settings)
            
            _ = removeChild(child)
            
            add(child, at: &path)
        }
    }
    
    fileprivate func add(_ child: VJson, at path: inout Array<PathComponent>) {
        
        let pathComponent = path.removeFirst()
        
        switch pathComponent {
        
        case .name(let name):
        
            // If this is the last path component, then add the child to this OBJECT.
            // If it is not the last path component, then add a path component corresponding to the type of the next path component. Then repeat this function.
            
            if path.count == 0 {
                add(child, for: name, replace: true)
            } else {
                let newItem: VJson
                if path[0].isName {
                    newItem = VJson.object()
                } else {
                    newItem = VJson.array()
                }
                add(newItem, for: name, replace: true)
                newItem.add(child, at: &path)
                if newItem.isArray { child.name = nil }
            }
            
            
        case .index(let index):
            
            // If this is the last path component, the add the child to this ARRAY
            // If it is not the last path component, then add a path component corresponding to the type of the next path component. Then repeat this function.

            if path.count == 0 {
                self[index] = child
            } else {
                let newItem: VJson
                if path[0].isName {
                    newItem = VJson.object()
                } else {
                    newItem = VJson.array()
                }
                self[index] = newItem
                newItem.add(child, at: &path)
                if newItem.isArray { child.name = nil }
            }
        }
    }
}



fileprivate func getPath(for name: String, using settings: FlattenSettings) -> Array<PathComponent> {
    
    // The result bucket
    
    var path: Array<PathComponent> = []
    
    
    // Split the name into parts, each part is either a name or an index part
    
    let pathComponents = name.split(separator: settings.separator)
    
    
    // If the separator and the leftArray indicator are the same and a ".", then check each pathComponent if it is a name or an index
    // Note that this assumes that the useDotArray option has been used to flatten the object.
    
    if settings.separator == "." && settings.leftArray == "." && settings.rightArray == nil {
        
        // The splitting operation has separated names and indexes
        // Assume that if a sub can be converted to Int and back and still is the same, then it must be an index.
        // Note that this can fail, if names have dots in them.
        
        for sub in pathComponents {
            if let num = Int(String(sub)), sub == String(num) {
                path.append(PathComponent.index(num))
            } else {
                path.append(.name(String(sub)))
            }
        }
        
        return path
    
    } else {
    
        // A best-guess implementation is choosen, it is assumed that leftArray and the separator are different and that the rightArray is not an empty character.
        
        for sub in pathComponents {
            
            // Try to split the sub into name and raw indexes
            
            let subsub = sub.split(separator: settings.leftArray)
            
            
            // Append the name to the result
            
            path.append(.name(String(subsub[0])))

            
            // Add indexes to the result (if possible)
            
            if subsub.count > 1 {
                
                for var rawIndex in subsub[1 ..< subsub.count] {
                    
                    
                    // Remove the rightArray character (if present)
                    
                    if settings.rightArray != nil {
                        rawIndex.removeLast()
                    }
                
                    // Convert the string index to a number
                    
                    if let num = Int(String(rawIndex)), rawIndex == String(num) {
                        path.append(.index(num))
                    } else {
                        path.append(.name(String(rawIndex)))
                    }
                }
            }
        }
    }
    
    return path
}


/// Used to reconstruct the path during unflattening

fileprivate enum PathComponent {
    case name(String)
    case index(Int)
    var isName: Bool { if case .name = self { return true } else { return false } }
    var isIndex: Bool { if case .index = self { return true } else { return false } }
}


/// The flattening settings to be applied to a flattening operation.

fileprivate struct FlattenSettings {

    
    /// The separator character to be used
    
    var separator: Character = "."
    
    
    /// The character to be used for the left side of an array indicator in a flattened name.
    
    var leftArray: Character = "["
    
    
    /// The character to be used for the right side of an array indicator in a flattened name.

    var rightArray: Character? = "]"
    
    
    /// Returns the content of the rightArray as a string, string is empty when rightArray is nil.
    
    var rightArrayAsString: String {
        if rightArray == nil { return "" }
        else { return String(rightArray!) }
    }
    
    
    /// If true, an array containing only elements of the types NONE, BOOL, NUMBER and/or STRING will be kept as an array
    
    var keepPrimitiveArray = false
    
    
    /// Create a new FlattenSettings structure.
    ///
    /// - Parameters options: The options to be reflected in the settings. See enum definition.

    init(_ options: [VJson.FlattenOptions] = []) {
        
        for option in options {
            switch option {
            case .separator(let char): separator = char
            case .leftArray(let char): leftArray = char
            case .rightArray(let char): rightArray = char
            case .useDotArray: leftArray = "." ; rightArray = nil; separator = "."
            case .keepPrimitiveArray: keepPrimitiveArray = true
            }
        }
    }
}


/// Will flatten the VJson object if it contains a JSON ARRAY.
///
/// - Parameters:
///     - array: The VJson object containg the JSON ARRAY to be flattened
///     - addTo: The VJson root object to add the flattened array to.
///     - flattenedParentName: The flattened name of the parent (will be used as the first part of the flattened element name)
///     - settings: The settings to be applied to the flattening process.

fileprivate func flattenArray(array: VJson, addTo root: VJson, flattenedParentName: String, _ settings: FlattenSettings) {
    
    for (index, element) in array.children!.items.enumerated() {
        
        let flattenedName = flattenedParentName + String(settings.leftArray) + String(index) + settings.rightArrayAsString

        switch element.type {
        
        case .null, .bool, .number, .string:
            
            root.add(element, for: flattenedName, replace: true)
        
            
        case .array:
            
            if settings.keepPrimitiveArray && element.isPrimitiveArray {
                root.add(element, for: flattenedName, replace: true)
            } else {
                flattenArray(array: element, addTo: root, flattenedParentName: flattenedName, settings)
            }

            
        case .object:
            
            flattenObject(object: element, addTo: root, flattenedParentName: flattenedName, settings)
        }
    }
}


/// Will flatten the VJson object if it contains a JSON OBJECT.
///
/// - Parameters:
///     - array: The VJson object containg the JSON OBJECT to be flattened
///     - addTo: The VJson root object to add the flattened object to.
///     - flattenedParentName: The flattened name of the parent (will be used as the first part of the flattened element name)
///     - settings: The settings to be applied to the flattening process.

fileprivate func flattenObject(object: VJson, addTo root: VJson, flattenedParentName: String, _ settings: FlattenSettings) {
    
    object.forEach { (item: VJson) in
        
        let flattenedName = flattenedParentName + String(settings.separator) + item.nameValue!

        switch item.type {
            
        case .null, .bool, .number, .string:
                
            root.add(item, for: flattenedName, replace: true)
            
                
        case .array:
                
            if settings.keepPrimitiveArray && item.isPrimitiveArray {
                root.add(item, for: flattenedName, replace: true)
            } else {
                flattenArray(array: item, addTo: root, flattenedParentName: flattenedName, settings)
            }

                
        case .object:
                
            flattenObject(object: item, addTo: root, flattenedParentName: flattenedName, settings)
        }
    }
}
