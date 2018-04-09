// =====================================================================================================================
//
//  File:       Children.swift
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
//         - Renamed index:ofChild to index:of
// =====================================================================================================================

import Foundation


public extension VJson {
    
    
    /// A wrapper for the child items, used only for ARRAYs and OBJECTs
    
    public class Children {
        
        
        // May only be created internally
        
        internal init(parent: VJson) { self.parent = parent }
        
        
        // The parent of the children (which will always be the enclosing VJson item)
        
        private unowned let parent: VJson
        
        
        // A chache that is used to speed up access to OBJECT items
        
        private var objectMemberCache: Dictionary<String, VJson>?
        
        
        // Enables or disables the cache
        
        internal var cacheEnabled: Bool = false {
            didSet { objectMemberCache = nil }
        }
        
        
        /// The child items under management
        
        public internal(set) var items: Array<VJson> = [] {
            didSet { objectMemberCache = nil }
        }
        
        
        /// Subscript access to the child items
        
        internal private(set) subscript(index: Int) -> VJson? {
            get {
                guard index < items.count else { return nil }
                guard index >= 0 else { return nil }
                return items[index]
            }
            set {
                guard let child = newValue else { return }
                guard index < items.count else { return }
                guard index >= 0 else { return }
                
                
                // Ensures the child's parent is always set
                
                child.parent = parent
                
                
                // Remove the parent from the child to be replaced
                
                items[index].parent = nil
                
                
                // Replace the child
                
                items[index] = child
            }
        }
        
        
        /// A shortcut to the count of the array of children
        
        public var count: Int { return items.count }
        
        
        /// Returns the index of the given child item.
        ///
        /// - Parameter of: The child to be found.
        ///
        /// - Returns: The index of the requested child, or nil if not found.
        
        internal func index(of child: VJson?) -> Int? {
            guard let child = child else { return nil }
            for (index, item) in items.enumerated() {
                if item === child { return index } // Compare and break if the child is found
            }
            return nil
        }
        
        
        /// Returns an array with the indicies of all items that are equal to the given child.
        ///
        /// - Parameter ofChildrenEqualTo: The child to compare the items to.
        ///
        /// - Returns: An array with the indicies of the items that match the child.
        
        internal func index(ofChildrenEqualTo child: VJson?) -> [Int] {
            guard let child = child else { return [] }
            var result: Array<Int> = []
            for (index, item) in items.enumerated() {
                if item == child { result.append(index) }
            }
            return result
        }
        
        
        /// Add the given child item to the end of the existing children
        ///
        /// - Parameter child: The child to be added.
        ///
        /// - Returns: The child that was added.
        
        internal func append(_ child: VJson?) {
            guard let child = child else { return }
            
            child.parent = parent // Ensures the child's parent is always set
            items.append(child)
        }
        
        
        /// Add the given child items to the end of the existing children
        ///
        /// - Parameter array: The array with new child items.
        
        internal func append(_ array: Array<VJson>) {
            array.forEach() { append($0) }
        }
        
        
        /// Inserts the given child item at the specified position.
        ///
        /// - Parameters:
        ///   - child: The item to be inserted.
        ///   - at: The index where to insert the child.
        ///
        /// - Returns: True on success, false on failure.
        
        @discardableResult
        internal func insert(_ child: VJson?, at index: Int) -> Bool {
            guard let child = child else { return false }
            guard index >= 0 else { return false }
            child.parent = parent // Ensures the child's parent is always set
            if index < items.count {
                items.insert(child, at: index)
            } else {
                items.append(child)
            }
            return true
        }
        
        
        /// Replaces the child at the specified index with the new child, returns the replaced child on success.
        ///
        /// - Parameters:
        ///   - at: The index of the child to be replaced.
        ///   - with: The child item to be placed at the specified index.
        ///
        /// - Returns: The replaced child or nil.
        
        @discardableResult
        internal func replace(at index: Int, with child: VJson?) -> VJson? {
            guard let child = child else { return parent }
            guard index < items.count else { return nil }
            guard index >= 0 else { return nil }
            
            let removed = items[index]
            removed.parent = nil // Remove the parent from the previous child

            child.parent = parent // Ensures the new child's parent is set correctly
            items[index] = child
            
            return removed
        }
        
        
        /// Removes the child at the specified index.
        ///
        /// - Parameter childAt: The index of the child item to be removed.
        ///
        /// - Returns: The child that was removed, or nil if the index did not exist.
        
        @discardableResult
        internal func remove(at index: Int) -> VJson? {
            guard index < items.count else { return nil }
            guard index >= 0 else { return nil }
            
            items[index].parent = nil // Make sure it is decoupled from the parent
            return items.remove(at: index)
        }
        
        
        /// Removes the specified child.
        ///
        /// - Parameter child: The child to be removed.
        ///
        /// - Returns: True on success, false if nothing was removed.
        
        @discardableResult
        internal func remove(_ child: VJson?) -> Bool {
            guard let child = child else { return false }
            
            if let index = index(of: child) {
                items[index].parent = nil // Make sure it is decoupled from the parent
                items.remove(at: index)
                return true
            } else {
                return false
            }
        }
        
        
        /// Remove all child items that are identical to the specified child item.
        ///
        /// - Parameter childrenWith: The child against which to compare the internal items.
        ///
        /// - Returns: The number of children removed.
        
        @discardableResult
        internal func remove(childrenWith name: String?) -> Int {
            guard let name = name else { return 0 }
            
            var result = 0
            for i in (0 ..< items.count).reversed() {
                if items[i].name == name {
                    remove(at: i)
                    result += 1 // Count the number of removed children
                }
            }
            return result
        }
        
        
        /// Removes all children.
        
        internal func removeAll() {
            items.forEach(){ $0.parent = nil }
            items.removeAll()
        }
        
        
        /// Returns a cached value if chaching is enabled.
        ///
        /// It will also build the cache if the cache is not present, but enabled.
        
        internal func cached(_ key: String) -> VJson? {
            if !cacheEnabled { return nil }
            if objectMemberCache == nil {
                objectMemberCache = [:]
                for child in items {
                    guard let name = child.name else {
                        objectMemberCache = nil
                        return nil
                    }
                    objectMemberCache?[name] = child
                }
            }
            return objectMemberCache?[key]
        }
    }
}
