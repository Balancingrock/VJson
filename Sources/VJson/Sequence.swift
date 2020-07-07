// =====================================================================================================================
//
//  File:       Sequence.swift
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


extension VJson: Sequence {
    
    
    /// The generator for the VJson object.
    
    public struct MyGenerator: IteratorProtocol {
        
        public typealias Element = VJson
        
        // The object for which the generator generates
        private let source: VJson
        
        // The objects already delivered through the generator
        private var sent: Array<VJson> = []
        
        fileprivate init(source: VJson) {
            self.source = source
        }
        
        /// Returns the next subitem
        ///
        /// - Returns: The next subitem.
        
        mutating public func next() -> Element? {
            
            // Only when the source has values to deliver
            if let values = source.children?.items {
                
                // Find a value that has not been sent already
                OUTER: for i in values {
                    
                    // Check if the value has not been sent already
                    for s in sent {
                        
                        // If it was sent, then try the next value
                        if i === s { continue OUTER }
                    }
                    
                    // Found a value that was not sent yet
                    // Remember that it will be sent
                    sent.append(i)
                    
                    // Send it
                    return i
                }
            }
            
            // Nothing left to send
            return nil
        }
    }
    
    
    /// defines the struct used as the iterator
    
    public typealias Iterator = MyGenerator
    
    
    /// Creates an iterator
    ///
    /// - Returns: A new iterator.
    
    public func makeIterator() -> Iterator { return MyGenerator(source: self) }
}
